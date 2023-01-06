module typus_oracle::supra {
    use sui::event::emit;
    use std::string::{Self, String};
    use std::vector;

    use SupraOracle::PriceOracle::{get_price, OracleHolder};

    public entry fun retrieve_price(
        oracle_holder: &mut OracleHolder,
        symbol_bytes: vector<u8>
    ) {
        let price_str = get_price(oracle_holder, symbol_bytes);
        let price = string_to_u64(price_str);
        emit(PriceEvent{price});
    }

    fun string_to_u64(value: String): u64 {
        let result = 0;
        let bytes = string::bytes(&value);
        let index = 0;
        let length = vector::length(bytes);
        while (index < length) {
            let digit = (*vector::borrow(bytes, index) as u64);
            assert!(digit >= 48 && digit <= 57, 0);
            result = result * 10 + (digit - 48);
            index = index + 1;
        };
        result
    }

    struct PriceEvent has copy, drop { price: u64 }
}