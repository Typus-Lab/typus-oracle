# typus-oracle
 
## Typus Oracle

### Deploy

`sui client publish  --gas-budget 10000`

`sui client call --gas-budget 10000 --package $PACKAGE --module "unix_time" --function "new_time"`

`sui client call --gas-budget 10000 --package $PACKAGE --module "oracle" --function "new_oracle" --type-args  0xa4b7e129d2ca3dae2fdf2e22d8d03e0fa26d157c::token_btc::BTC --args 8`

### Usage

**PACKAGE**
`0xe07600a0b7782a9e6900cb09ed9ed7b33b025934`

**unix_time** (20s update)
`0xadc0c9a8bec650241c9dc80de7a19dc907e94e3f`

**oracle** (20s update)
* BTC `0x96f2858f39b3965435f536bacf558f7036a4c47d`
    >Data Source: https://api.binance.com/api/v3/ticker/price?symbol=BTCBUSD 
    
    >Token: `0xa4b7e129d2ca3dae2fdf2e22d8d03e0fa26d157c::token_btc::BTC` (https://github.com/Typus-Lab/sui-dev-token)


Usage: https://github.com/Typus-Lab/typus-dov

## Supra Oracle
https://supraoracles.com

`sui client call --gas-budget 10000 --package $PACKAGE --module "supra" --function "retrieve_price" --args 0xc40820e20346809f11f0bd04e954792f897a84d0 btc_usdt`