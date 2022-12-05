module typus_oracle::unix_time {
    use sui::tx_context::{Self, TxContext};
    use sui::object::{Self, UID, ID};
    use sui::transfer;
    use sui::event::emit;

    // ======== Structs =========

    struct Time has key {
        id: UID,
        unix_ms: u64,
        epoch: u64,
    }

    struct Key has key {
        id: UID,
        for: ID,
    }

    // ======== Functions =========

    public entry fun new_time(
        ctx: &mut TxContext
    ) {

        let id = object::new(ctx);
        let for = object::uid_to_inner(&id);
        
        let time = Time { 
            id,
            unix_ms: 0,
            epoch: tx_context::epoch(ctx)
        };

        transfer::share_object(time);

        transfer::transfer(Key {
            for,
            id: object::new(ctx)
        }, tx_context::sender(ctx));
    }

    public entry fun update(
        time: &mut Time,
        key: &Key,
        unix_ms: u64,
        ctx: &mut TxContext
    ) {
        assert!(&key.for == object::borrow_id(time), EKeyMismatch);

        time.unix_ms = unix_ms;
        time.epoch = tx_context::epoch(ctx);
        emit(TimeEvent { unix_ms, epoch: tx_context::epoch(ctx) });
    }

    public entry fun copy_key(
        key: &Key,
        ctx: &mut TxContext
    ) {
        transfer::transfer(Key {
            id: object::new(ctx),
            for: key.for
        }, tx_context::sender(ctx));
    }

    public fun get_time(
        time: &Time
    ): (u64, u64) {
        (time.unix_ms , time.epoch)
    }

    public fun get_unix_ms(
        time: &Time
    ): u64 {
        time.unix_ms
    }

    public fun get_epoch(
        time: &Time
    ): u64 {
        time.epoch
    }

    /// Key does not match the Lock.
    const EKeyMismatch: u64 = 0;

    struct TimeEvent has copy, drop { unix_ms: u64, epoch: u64 }

    #[test_only]
    public fun new_time_for_testing(
        ctx: &mut TxContext
    ): Time {
        let time = Time { 
            id: object::new(ctx),
            unix_ms: 0,
            epoch: tx_context::epoch(ctx)
        };

        let manager_cap = ManagerCap { id: object::new(ctx) };

        transfer::transfer(manager_cap, tx_context::sender(ctx));
        time
    }
    
    #[test_only]
    public fun destroy_for_testing(self: Time){
        let Time{
            id,
            unix_ms: _,
            epoch: _,
        } = self;
        object::delete(id);
    }
}