// module typus_oracle::supra {
//     use sui::event::emit;
//     use std::string::String;
    
//     use SupraOracle::PriceOracle::{get_price, OracleHolder};

//     public entry fun retrieve_price(
//         oracle_holder: &mut OracleHolder,
//         symbol_bytes: vector<u8>
//     ) {
//         let price = get_price(oracle_holder, symbol_bytes);

//         emit(PriceEvent{price});
//     }

//     struct PriceEvent has copy, drop { price: String }
// }