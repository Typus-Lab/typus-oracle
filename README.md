# Typus Oracle

## Deploy

`sui client publish  --gas-budget 10000`

`export ORACLE_PACKAGE=0x5b1f5680041041624069ef03f23947001b073642`

`sui client call --gas-budget 10000 --package $ORACLE_PACKAGE --module "unix_time" --function "new_time"`

`sui client call --gas-budget 10000 --package $ORACLE_PACKAGE --module "oracle" --function "new_oracle" --type-args  0x1ed338b4e737d89729386b8170b0f45910ad30fa::btc::BTC --args 0x8`

`sui client call --gas-budget 10000 --package $ORACLE_PACKAGE --module "oracle" --function "new_oracle" --type-args  0x1ed338b4e737d89729386b8170b0f45910ad30fa::eth::ETH --args 0x8`

## Usage

### PACKAGE
`0x5b1f5680041041624069ef03f23947001b073642`

### Time Oracle (20s update)

1. unix_time: `0x1480773700cdeecfbac028f5345ec8f472750ef8`
   * Key: `0x70994349ab48543e87aa8cd75a06c82f3e445554`

### Price Oracle (20s update)

1. BTC `0x16114800df34a8d8b8613b3d5591ca9131e4f7bd`
    * Token: `0x1ed338b4e737d89729386b8170b0f45910ad30fa::btc::BTC`
    * Key: `0x45561f8f767ebd77a23bdc7fcf2ccfb26c6478ab`
    * Data Source: https://api.binance.com/api/v3/ticker/price?symbol=BTCBUSD 


2. ETH `0x4280ab701d4d5d94a75e29c32b36a96a5ace4f05`
    * Token: `0x1ed338b4e737d89729386b8170b0f45910ad30fa::eth::ETH`
    * Key: `0x8e2ff3a4fcefe7f6621cf691c49f3243b1019499`
    * Data Source: https://api.binance.com/api/v3/ticker/price?symbol=ETHBUSD 

3. SUI `0x477e9ad2eaf7555a581a7fb849c1b8af594d2181`
    * Token: `0x1ed338b4e737d89729386b8170b0f45910ad30fa::sui::SUI`
    * Key: `0xacda48af7ae9d20c670354071971ed9e124c16fe`

Token: https://github.com/Typus-Lab/sui-dev-token

Usage: https://github.com/Typus-Lab/typus-dov

<!-- ## Supra Oracle
https://supraoracles.com

`sui client call --gas-budget 10000 --package $PACKAGE --module "supra" --function "retrieve_price" --args 0xc40820e20346809f11f0bd04e954792f897a84d0 btc_usdt` -->
