# Typus Oracle

## Deploy

`sui client publish  --gas-budget 10000`

`export ORACLE_PACKAGE=0xcba43b3a1672f3c782e2167fc64710799009d5bb`

`sui client call --gas-budget 10000 --package $ORACLE_PACKAGE --module "unix_time" --function "new_time"`

`sui client call --gas-budget 10000 --package $ORACLE_PACKAGE --module "oracle" --function "new_oracle" --type-args  0x3e416d10557c532838c2d0d6996c8a3bc81371a7::btc::BTC --args 0x8`

`sui client call --gas-budget 10000 --package $ORACLE_PACKAGE --module "oracle" --function "new_oracle" --type-args  0x3e416d10557c532838c2d0d6996c8a3bc81371a7::eth::ETH --args 0x8`

## Usage

### PACKAGE
`0xcba43b3a1672f3c782e2167fc64710799009d5bb`

### Time Oracle (20s update)

1. unix_time: `0x55031e1edc517a4b16543c1c081ba33a59ffd084`
   * Key: `0x59f22fbf2672197b28841813588297c84f7e9ed1`

### Price Oracle (20s update)

1. BTC `0x764d0c3b931006a473453a0095032681fcb26304`
    * Token: `0x3e416d10557c532838c2d0d6996c8a3bc81371a7::btc::BTC`
    * Key: `0x30357dc1c2a2feed17b8683d202968631088a207`
    * Data Source: https://api.binance.com/api/v3/ticker/price?symbol=BTCBUSD 


2. ETH `0x112b09dfe4f976c65a4905faa5993175861dfad0`
    * Token: `0x3e416d10557c532838c2d0d6996c8a3bc81371a7::eth::ETH`
    * Key: `0x697f82c94f9f248ae9b4da567d1a89e1d268b2f2`
    * Data Source: https://api.binance.com/api/v3/ticker/price?symbol=ETHBUSD 

3. SUI `0x249808c33309a97d271e7a7da67c328f1eb9b312`
    * Token: `0x3e416d10557c532838c2d0d6996c8a3bc81371a7::sui::SUI`
    * Key: `0x7010b351664cff58a9ce2064f63055b28eebe074`

Token: https://github.com/Typus-Lab/sui-dev-token

Usage: https://github.com/Typus-Lab/typus-dov

<!-- ## Supra Oracle
https://supraoracles.com

`sui client call --gas-budget 10000 --package $PACKAGE --module "supra" --function "retrieve_price" --args 0xc40820e20346809f11f0bd04e954792f897a84d0 btc_usdt` -->
