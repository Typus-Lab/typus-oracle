module typus_oracle::oracle {
    use sui::tx_context::{Self, TxContext};
    use sui::object::{Self, UID, ID};
    use sui::transfer;
    use sui::event::emit;
    use sui::clock::{Self, Clock};

    use std::type_name;
    use std::ascii::String;

    // ======== Structs =========

    struct Oracle<phantom T> has key {
        id: UID,
        quote_token: String,
        base_token: String,
        decimal: u64,
        price: u64,
        twap_price: u64,
        ts_ms: u64,
        epoch: u64,
        time_interval: u64
    }

    struct Key<phantom T> has key {
        id: UID,
        for: ID,
    }

    // ======== Functions =========

    public entry fun new_oracle<T>(
        quote_token: String,
        base_token: String,
        decimal: u64,
        ctx: &mut TxContext
    ) {

        let id = object::new(ctx);
        let for = object::uid_to_inner(&id);

        let oracle = Oracle<T> {
            id,
            quote_token,
            base_token,
            decimal,
            price: 0,
            twap_price: 0,
            ts_ms: 0,
            epoch: tx_context::epoch(ctx),
            time_interval: 300 * 1000
        };

        transfer::share_object(oracle);

        transfer::transfer(Key<T> {
            for,
            id: object::new(ctx)
        }, tx_context::sender(ctx));
    }

    public entry fun update<T>(
        oracle: &mut Oracle<T>,
        key: &Key<T>,
        price: u64,
        twap_price: u64,
        clock: &Clock,
        ctx: &mut TxContext
    ) {
        assert!(&key.for == object::borrow_id(oracle), EKeyMismatch);
        assert!(price > 0, E_INVALID_PRICE);
        assert!(twap_price > 0, E_INVALID_PRICE);

        let ts_ms = clock::timestamp_ms(clock);

        oracle.price = price;
        oracle.twap_price = twap_price;
        oracle.ts_ms = ts_ms;
        oracle.epoch = tx_context::epoch(ctx);

        let token = *type_name::borrow_string(&type_name::get<T>());

        emit(PriceEvent {token, price, ts_ms, epoch: tx_context::epoch(ctx) });
    }

    public entry fun copy_key<T>(
        key: &Key<T>,
        recipient: address,
        ctx: &mut TxContext
    ) {
        transfer::transfer(Key<T> {
            id: object::new(ctx),
            for: key.for
        }, recipient);
    }

    public fun get_oracle<T>(
        oracle: &Oracle<T>
    ): (u64, u64, u64, u64) {
        (oracle.price, oracle.decimal, oracle.ts_ms, oracle.epoch)
    }

    public fun get_price<T>(
        oracle: &Oracle<T>,
        ts_ms: u64,
    ): (u64, u64) {
        assert!(ts_ms - oracle.ts_ms < oracle.time_interval, E_ORACLE_EXPIRED);
        (oracle.price, oracle.decimal)
    }

    public fun get_twap_price<T>(
        oracle: &Oracle<T>,
        ts_ms: u64,
    ): (u64, u64) {
        assert!(ts_ms - oracle.ts_ms < oracle.time_interval, E_ORACLE_EXPIRED);
        (oracle.twap_price, oracle.decimal)
    }

    public entry fun update_time_interval<T>(
        oracle: &mut Oracle<T>,
        key: &Key<T>,
        time_interval: u64,
    ) {
        assert!(&key.for == object::borrow_id(oracle), EKeyMismatch);
        oracle.time_interval = time_interval;
    }

    /// Key does not match the Lock.
    const EKeyMismatch: u64 = 0;
    const E_ORACLE_EXPIRED: u64 = 1;
    const E_INVALID_PRICE: u64 = 2;

    struct PriceEvent has copy, drop { token: String, price: u64, ts_ms: u64, epoch: u64 }
}