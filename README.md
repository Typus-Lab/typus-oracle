# Typus Oracle

## Deploy

`sui client publish  --gas-budget 10000`

`export PACKAGE=0x7d683916b32c25b0061e65d3c744838cea225fe9`

`sui client call --gas-budget 10000 --package $PACKAGE --module "unix_time" --function "new_time"`

`sui client call --gas-budget 10000 --package $PACKAGE --module "oracle" --function "new_oracle" --type-args  0x2009591841eff19d6c5e97eae7a45f2f3908e502::btc::BTC --args 8`

`sui client call --gas-budget 10000 --package $PACKAGE --module "oracle" --function "new_oracle" --type-args  0x2009591841eff19d6c5e97eae7a45f2f3908e502::eth::ETH --args 8`

## Usage

### PACKAGE
`0x7d683916b32c25b0061e65d3c744838cea225fe9`

### Time Oracle (20s update)

1. unix_time: `0x4233c8371e7a211b1d3791159f2a6426a881f1af`
   * Key: `0xf492708ba32bcdeebb1bc1783d62469f38cd1f4e`

### Price Oracle (20s update)

1. BTC `0x7f29aa4deda6e704b2205bcaa601f59727957fcd`
    * Token: `0x2009591841eff19d6c5e97eae7a45f2f3908e502::btc::BTC`
    * Key: `0x44603e27a9935ad60c3f8cdcaa99c9d945a433ab`
    * Data Source: https://api.binance.com/api/v3/ticker/price?symbol=BTCBUSD 


2. ETH `0xddbbf9f418bdfd6bb6bdb2155c430ef787285562`
    * Token: `0x2009591841eff19d6c5e97eae7a45f2f3908e502::eth::ETH`
    * Key: `0x6b491b3d735a4b5bfcb0e8ed3ad26efba40277bd`
    * Data Source: https://api.binance.com/api/v3/ticker/price?symbol=ETHBUSD 

Token: https://github.com/Typus-Lab/sui-dev-token

Usage: https://github.com/Typus-Lab/typus-dov

<!-- ## Supra Oracle
https://supraoracles.com

`sui client call --gas-budget 10000 --package $PACKAGE --module "supra" --function "retrieve_price" --args 0xc40820e20346809f11f0bd04e954792f897a84d0 btc_usdt` -->
