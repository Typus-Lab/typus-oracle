# Typus Oracle

## Deploy

`sui client publish  --gas-budget 10000`

`export PACKAGE=0xe85eabdada216e470344b2e70cdc8155a4007a2a`

`sui client call --gas-budget 10000 --package $PACKAGE --module "unix_time" --function "new_time"`

`sui client call --gas-budget 10000 --package $PACKAGE --module "oracle" --function "new_oracle" --type-args  0x0a7a15d173690ac676b03eb8285a615a8982cb27::btc::BTC --args 8`

## Usage

### PACKAGE
`0xe85eabdada216e470344b2e70cdc8155a4007a2a`

### Time Oracle (20s update)
unix_time: `0xf1166158630aa5d650fd178ff96190f55e81c912`

### Price Oracle (20s update)

1. BTC `0x4d5695468f455b1e4e6e5a6c55b90fa25b9473c4`
    * Token: `0x0a7a15d173690ac676b03eb8285a615a8982cb27::btc::BTC`
    * Key: `0x89a1b98ea081f0403232dce17b1b7f16f33dbb59`
    * Data Source: https://api.binance.com/api/v3/ticker/price?symbol=BTCBUSD 


2. ETH `0x81810cfe4efe6f7ae9bb26547eb9d4b76fd066f9`
    * Token: `0x0a7a15d173690ac676b03eb8285a615a8982cb27::eth::ETH`
    * Key: `0x4b8cb609467a6db4045b530965fff5c3f7f448ae`
    * Data Source: https://api.binance.com/api/v3/ticker/price?symbol=ETHBUSD 

Token: https://github.com/Typus-Lab/sui-dev-token

Usage: https://github.com/Typus-Lab/typus-dov

<!-- ## Supra Oracle
https://supraoracles.com

`sui client call --gas-budget 10000 --package $PACKAGE --module "supra" --function "retrieve_price" --args 0xc40820e20346809f11f0bd04e954792f897a84d0 btc_usdt` -->