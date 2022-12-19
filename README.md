# Typus Oracle

## Deploy

`sui client publish  --gas-budget 10000`

`export PACKAGE=0x76d673a3f7aa558016e692b4de02c71de11f00b7`

`sui client call --gas-budget 10000 --package $PACKAGE --module "unix_time" --function "new_time"`

`sui client call --gas-budget 10000 --package $PACKAGE --module "oracle" --function "new_oracle" --type-args  0xcd396739e72ccd373eca7e575d50ba1438bd8022::btc::BTC --args 8`

`sui client call --gas-budget 10000 --package $PACKAGE --module "oracle" --function "new_oracle" --type-args  0xcd396739e72ccd373eca7e575d50ba1438bd8022::eth::ETH --args 8`

## Usage

### PACKAGE
`0x76d673a3f7aa558016e692b4de02c71de11f00b7`

### Time Oracle (20s update)

1. unix_time: `0x80a77770cbd7415069636123b159ab4fa0619dbe`
   * Key: `0xee761eb5eb942c0b91bafb3465d040987e5993cc`

### Price Oracle (20s update)

1. BTC `0xa080bd22a0e5159b6d9a44d350dc0bfa08469e6f`
    * Token: `0xcd396739e72ccd373eca7e575d50ba1438bd8022::btc::BTC`
    * Key: `0x4804fc2b40d4383d35bc73e48c0107ad1b664ec5`
    * Data Source: https://api.binance.com/api/v3/ticker/price?symbol=BTCBUSD 


2. ETH `0xece3eac51d3d3871b88ec99397c4e93cdc1dd304`
    * Token: `0xcd396739e72ccd373eca7e575d50ba1438bd8022::eth::ETH`
    * Key: `0x566436d074c77e906b036d18ed6163c7dbf133a3`
    * Data Source: https://api.binance.com/api/v3/ticker/price?symbol=ETHBUSD 

Token: https://github.com/Typus-Lab/sui-dev-token

Usage: https://github.com/Typus-Lab/typus-dov

<!-- ## Supra Oracle
https://supraoracles.com

`sui client call --gas-budget 10000 --package $PACKAGE --module "supra" --function "retrieve_price" --args 0xc40820e20346809f11f0bd04e954792f897a84d0 btc_usdt` -->
