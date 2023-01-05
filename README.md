# Typus Oracle

## Deploy

`sui client publish  --gas-budget 10000`

`export ORACLE_PACKAGE=0x0d4b13cc0467c0620ce54abf703faa3b419d967b`

`sui client call --gas-budget 10000 --package $ORACLE_PACKAGE --module "unix_time" --function "new_time"`

`sui client call --gas-budget 10000 --package $ORACLE_PACKAGE --module "oracle" --function "new_oracle" --type-args  0x2c9a10117599e2d3232495a525b10f679691c9ae::btc::BTC --args 0x8`

`sui client call --gas-budget 10000 --package $ORACLE_PACKAGE --module "oracle" --function "new_oracle" --type-args  0x2c9a10117599e2d3232495a525b10f679691c9ae::eth::ETH --args 0x8`

## Usage

### PACKAGE
`0x0d4b13cc0467c0620ce54abf703faa3b419d967b`

### Time Oracle (20s update)

1. unix_time: `0xd94e21d9d51916a6a66775449368dcceea97b128`
   * Key: `0xab0f780ff8bec45120d935f613dc9fa24eb4e0c1`

### Price Oracle (20s update)

1. BTC `0xa7b469c36c8bd2a082acd2bbae2ac7e8a4b2f454`
    * Token: `0x2c9a10117599e2d3232495a525b10f679691c9ae::btc::BTC`
    * Key: `0xbf2854214f4ea82c60e1e144ac27c50bb208f165`
    * Data Source: https://api.binance.com/api/v3/ticker/price?symbol=BTCBUSD 


2. ETH `0x0ca00212cdc76eb310b61fa887ad9cb0b7be2146`
    * Token: `0x2c9a10117599e2d3232495a525b10f679691c9ae::eth::ETH`
    * Key: `0xdfae144241b0bb5269025426b5a921f15e3b9318`
    * Data Source: https://api.binance.com/api/v3/ticker/price?symbol=ETHBUSD 

Token: https://github.com/Typus-Lab/sui-dev-token

Usage: https://github.com/Typus-Lab/typus-dov

<!-- ## Supra Oracle
https://supraoracles.com

`sui client call --gas-budget 10000 --package $PACKAGE --module "supra" --function "retrieve_price" --args 0xc40820e20346809f11f0bd04e954792f897a84d0 btc_usdt` -->
