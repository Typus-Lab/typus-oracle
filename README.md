# Typus Oracle

## Deploy

`sui client publish  --gas-budget 10000`

`export ORACLE_PACKAGE=0x437d2eb473bd348ad22b37ffb84bd652656026b1`

`sui client call --gas-budget 10000 --package $ORACLE_PACKAGE --module "unix_time" --function "new_time"`

`sui client call --gas-budget 10000 --package $ORACLE_PACKAGE --module "oracle" --function "new_oracle" --type-args  0xc6e0ac81e9640d3afdc8a1b77c16e9aaecd4ed3c::btc::BTC --args 8`

`sui client call --gas-budget 10000 --package $ORACLE_PACKAGE --module "oracle" --function "new_oracle" --type-args  0xc6e0ac81e9640d3afdc8a1b77c16e9aaecd4ed3c::eth::ETH --args 8`

## Usage

### PACKAGE
`0x437d2eb473bd348ad22b37ffb84bd652656026b1`

### Time Oracle (20s update)

1. unix_time: `0x5dab4b752d2d8464cfd586ca094cc6023bb58168`
   * Key: `0x53ff9fbe1c16295109052342147a0317192521ae`

### Price Oracle (20s update)

1. BTC `0xf426b718c4710541a90a0c897cbbcac10a5f8783`
    * Token: `0xc6e0ac81e9640d3afdc8a1b77c16e9aaecd4ed3c::btc::BTC`
    * Key: `0xadfe36a79baf23aab4a1370806bf7460bd9570d4`
    * Data Source: https://api.binance.com/api/v3/ticker/price?symbol=BTCBUSD 


2. ETH `0x1a32cc8d6633a9747879ba494925e730c1636ed1`
    * Token: `0xc6e0ac81e9640d3afdc8a1b77c16e9aaecd4ed3c::eth::ETH`
    * Key: `0xf8ff4884c45bff1970a31f574a5f277249d487d0`
    * Data Source: https://api.binance.com/api/v3/ticker/price?symbol=ETHBUSD 

Token: https://github.com/Typus-Lab/sui-dev-token

Usage: https://github.com/Typus-Lab/typus-dov

<!-- ## Supra Oracle
https://supraoracles.com

`sui client call --gas-budget 10000 --package $PACKAGE --module "supra" --function "retrieve_price" --args 0xc40820e20346809f11f0bd04e954792f897a84d0 btc_usdt` -->
