module typus_oracle::oracle {
    use sui::tx_context::{Self, TxContext};
    use sui::object::{Self, UID, ID};
    use sui::transfer;
    use sui::event::emit;
    use sui::clock::{Self, Clock};

    use std::type_name;
    use std::ascii::String;
    use std::option::{Self, Option};

    // ======== Structs =========

    struct ManagerCap has key {
        id: UID,
    }

    struct Oracle<phantom T> has key {
        id: UID,
        quote_token: String,
        base_token: String,
        decimal: u64,
        price: u64,
        twap_price: u64,
        ts_ms: u64,
        epoch: u64,
        time_interval: u64,
        switchboard: Option<ID>,
    }

    // ======== Functions =========

    fun init(ctx: &mut TxContext) {
        transfer::transfer(
            ManagerCap {id: object::new(ctx)},
            tx_context::sender(ctx)
        );
    }

    #[test_only]
    public fun test_init(ctx: &mut TxContext) {
        init(ctx);
    }

    public entry fun new_oracle<T>(
        _manager_cap: &ManagerCap,
        quote_token: String,
        base_token: String,
        decimal: u64,
        ctx: &mut TxContext
    ) {

        let id = object::new(ctx);

        let oracle = Oracle<T> {
            id,
            quote_token,
            base_token,
            decimal,
            price: 0,
            twap_price: 0,
            ts_ms: 0,
            epoch: tx_context::epoch(ctx),
            time_interval: 300 * 1000,
            switchboard: option::none(),
        };

        transfer::share_object(oracle);
    }

    public entry fun update<T>(
        oracle: &mut Oracle<T>,
        _manager_cap: &ManagerCap,
        price: u64,
        twap_price: u64,
        clock: &Clock,
        ctx: &mut TxContext
    ) {
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

    entry fun update_switchboard_oracle<T>(
        oracle: &mut Oracle<T>,
        _manager_cap: &ManagerCap,
        feed: &Aggregator,
    ) {
        let id = object::id(feed);
        oracle.switchboard = option::some(id);
    }

    use switchboard::aggregator::{Aggregator};
    use typus_oracle::switchboard_feed_parser;

    entry fun update_with_switchboard<T>(
        oracle: &mut Oracle<T>,
        feed: &Aggregator,
        clock: &Clock,
        ctx: &mut TxContext
    ) {
        assert!(option::is_some(&oracle.switchboard), E_NOT_SWITCHBOARD);
        assert!(option::borrow(&oracle.switchboard) == &object::id(feed), E_INVALID_SWITCHBOARD);

        let ts_ms = clock::timestamp_ms(clock);

        let (price_u128, decimal_u8) = switchboard_feed_parser::log_aggregator_info(feed);
        assert!(price_u128 > 0, E_INVALID_PRICE);

        let decimal = (decimal_u8 as u64);
        if (decimal > oracle.decimal) {
            price_u128 = price_u128 / ((10 ^ (decimal - oracle.decimal)) as u128);
        } else {
            price_u128 = price_u128 * ((10 ^ (oracle.decimal - decimal)) as u128);
        };

        let price = (price_u128 as u64);
        oracle.price = price;
        oracle.twap_price = price;
        oracle.ts_ms = ts_ms;
        oracle.epoch = tx_context::epoch(ctx);

        let token = *type_name::borrow_string(&type_name::get<T>());

        emit(PriceEvent {token, price, ts_ms, epoch: tx_context::epoch(ctx) });
    }



    public entry fun copy_manager_cap<T>(
        _manager_cap: &ManagerCap,
        recipient: address,
        ctx: &mut TxContext
    ) {
        transfer::transfer(ManagerCap {id: object::new(ctx)}, recipient);
    }

    public fun get_oracle<T>(
        oracle: &Oracle<T>
    ): (u64, u64, u64, u64) {
        (oracle.price, oracle.decimal, oracle.ts_ms, oracle.epoch)
    }

    public fun get_price<T>(
        oracle: &Oracle<T>,
        clock: &Clock,
    ): (u64, u64) {
        let ts_ms = clock::timestamp_ms(clock);
        assert!(ts_ms - oracle.ts_ms < oracle.time_interval, E_ORACLE_EXPIRED);
        (oracle.price, oracle.decimal)
    }

    public fun get_twap_price<T>(
        oracle: &Oracle<T>,
        clock: &Clock,
    ): (u64, u64) {
        let ts_ms = clock::timestamp_ms(clock);
        assert!(ts_ms - oracle.ts_ms < oracle.time_interval, E_ORACLE_EXPIRED);
        (oracle.twap_price, oracle.decimal)
    }

    public entry fun update_time_interval<T>(
        oracle: &mut Oracle<T>,
        _manager_cap: &ManagerCap,
        time_interval: u64,
    ) {
        oracle.time_interval = time_interval;
    }

    const E_ORACLE_EXPIRED: u64 = 1;
    const E_INVALID_PRICE: u64 = 2;
    const E_NOT_SWITCHBOARD: u64 = 3;
    const E_INVALID_SWITCHBOARD: u64 = 4;

    struct PriceEvent has copy, drop { token: String, price: u64, ts_ms: u64, epoch: u64 }
}