module typus_oracle::oracle {
    use sui::tx_context::{Self, TxContext};
    use sui::object::{Self, UID, ID};
    use sui::transfer;
    use sui::event::emit;

    // ======== Structs =========

    struct Oracle<phantom T> has key {
        id: UID,
        decimal: u64,
        price: u64,
        twap_price_1h: u64,
        ts_ms: u64,
        epoch: u64,
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
            epoch: tx_context::epoch(ctx)
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

        emit(PriceEvent { price, ts_ms, epoch: tx_context::epoch(ctx) });
    }

    public entry fun copy_key<T>(
        key: &Key<T>,
        ctx: &mut TxContext
    ) {
        transfer::transfer(Key<T> {
            id: object::new(ctx),
            for: key.for
        }, tx_context::sender(ctx));
    }

    public fun get_oracle<T>(
        oracle: &Oracle<T>
    ): (u64, u64, u64, u64) {
        (oracle.price, oracle.decimal, oracle.ts_ms, oracle.epoch)
    }

    /// Key does not match the Lock.
    const EKeyMismatch: u64 = 0;

    struct PriceEvent has copy, drop { price: u64, ts_ms: u64, epoch: u64 }
}