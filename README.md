# typus-oracle
 
## Typus Oracle

**PACKAGE**
`0x0870508caaa0859321f3f5c8335243bd79356230`

**unix_time** (20s update)
`0xcd32d05699d0dd5132f8c014acde0e5cb21f73b0`

**oracle** (20s update)
* BTC `0x004e185b4a9ae90491f6aeeae380b27a0c377f3b`
    >Data Source: https://api.binance.com/api/v3/ticker/price?symbol=BTCBUSD 
    
    >Token: `0xa4b7e129d2ca3dae2fdf2e22d8d03e0fa26d157c::token_btc::BTC` (https://github.com/Typus-Lab/sui-dev-token)


Usage: https://github.com/Typus-Lab/typus-dov

## Supra Oracle
https://supraoracles.com

`sui client call --gas-budget 10000 --package $PACKAGE --module "supra" --function "retrieve_price" --args 0xc40820e20346809f11f0bd04e954792f897a84d0 btc_usdt`