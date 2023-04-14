module typus_oracle::oracle {
    use sui::tx_context::{Self, TxContext};
    use sui::object::{Self, UID, ID};
    use sui::transfer;
    use sui::event::emit;
    use std::type_name;
    use std::ascii::String;

    // ======== Structs =========

    struct Oracle<phantom T> has key {
        id: UID,
        decimal: u64,
        price: u64,
        twap_price_1h: u64,
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
        decimal: u64,
        ctx: &mut TxContext
    ) {

        let id = object::new(ctx);
        let for = object::uid_to_inner(&id);

        let oracle = Oracle<T> {
            id,
            decimal,
            price: 0,
            twap_price_1h: 0,
            ts_ms: 0,
            epoch: tx_context::epoch(ctx),
            time_interval: 60 * 1000
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
        twap_price_1h: u64,
        ts_ms: u64,
        ctx: &mut TxContext
    ) {
        assert!(&key.for == object::borrow_id(oracle), EKeyMismatch);

        oracle.price = price;
        oracle.twap_price_1h = twap_price_1h;
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

    entry fun update_time_interval<T>(
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

    struct PriceEvent has copy, drop { token: String, price: u64, ts_ms: u64, epoch: u64 }
}