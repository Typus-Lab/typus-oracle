# Typus Oracle

## Deploy

`sui client publish  --gas-budget 10000`

`export ORACLE_PACKAGE=0x0a55a6dfa713f83cb3be5e3ca8a8435ccdbb500d`

`sui client call --gas-budget 10000 --package $ORACLE_PACKAGE --module "unix_time" --function "new_time"`

`sui client call --gas-budget 10000 --package $ORACLE_PACKAGE --module "oracle" --function "new_oracle" --type-args  0xa1d0cdb1b41c786d53a03d30340ab05718010e04::btc::BTC --args 0x8`

`sui client call --gas-budget 10000 --package $ORACLE_PACKAGE --module "oracle" --function "new_oracle" --type-args  0xa1d0cdb1b41c786d53a03d30340ab05718010e04::eth::ETH --args 0x8`

## Usage

### PACKAGE
`0x0a55a6dfa713f83cb3be5e3ca8a8435ccdbb500d`

### Time Oracle (20s update)

1. unix_time: `0x31ce3e644e13dcb241d68bdba2783b1d6ab72a6c`
   * Key: `0xdc99399ec8f5a1888eed19fe17e945a1196df15b`

### Price Oracle (20s update)

1. BTC `0x379cf4a0b69012736feeb64302c4d6ce0a29fca7`
    * Token: `0xa1d0cdb1b41c786d53a03d30340ab05718010e04::btc::BTC`
    * Key: `0xd48b60fed34e7ab93f5a65ef5b6805e453e4d40e`
    * Data Source: https://api.binance.com/api/v3/ticker/price?symbol=BTCBUSD 


2. ETH `0x14af45e8938c39e845ca189fa898f1e569ea2ced`
    * Token: `0xa1d0cdb1b41c786d53a03d30340ab05718010e04::eth::ETH`
    * Key: `0xca4037ffae6006e2e7ce1db1ac74b1d25e5d0b3a`
    * Data Source: https://api.binance.com/api/v3/ticker/price?symbol=ETHBUSD 

3. SUI `0xb2a281264d928622999103afa27fceead0cb2b86`
    * Token: `0xa1d0cdb1b41c786d53a03d30340ab05718010e04::sui::SUI`
    * Key: `0x69e764b55e7dfcf5604da8cf5571e5e8501f294f`

Token: https://github.com/Typus-Lab/sui-dev-token

Usage: https://github.com/Typus-Lab/typus-dov

<!-- ## Supra Oracle
https://supraoracles.com

`sui client call --gas-budget 10000 --package $PACKAGE --module "supra" --function "retrieve_price" --args 0xc40820e20346809f11f0bd04e954792f897a84d0 btc_usdt` -->

### Updated
```
    "ORACLE_PACKAGE": "0x09f44378771672533b36fbe5d92c4fbf1aee548d",
    "TIME_ORACLE": "0x36729d3aaba1c20414cc5a19f80632bfbdb4099b",
    "TIME_ORACLE_KEY": "0x13af709836e8d6745026eed7cc6007d74e6fad3e",
    "BTC_ORACLE": "0x6d90225a4cd43510d141f3b27a2eaeb9e88e115a",
    "BTC_ORACLE_KEY": "0x0b6467006e2944f7c6b210d84ba13bd7a9fa6b99",
    "ETH_ORACLE": "0xe3b13478238f53d2eb9078568d5f80ee354f4c86",
    "ETH_ORACLE_KEY": "0x55a9ff4a3a0ab6f3a43189606b89fb88f9bcad0a",
    "SUI_ORACLE": "0x0b8212a98925f52379dea40cab0b5760c596aaf4",
    "SUI_ORACLE_KEY": "0xef9597c32f1ab883e66adda5e93414e2e1dc8dde",
    "APT_ORACLE_KEY": "0x47759a9f7770e44a144617228bd8a6a0f26f9e74",
    "APT_ORACLE": "0x587be89ff0dec3a1b28e75c50af4c17c3fd1797e",
    "DOGE_ORACLE_KEY": "0x2a81bf87b4800e3b19fa25c76318783f16a4ffc6",
    "DOGE_ORACLE": "0xe08a33db82b288a642ce6f4df1ab6bbbcb3c2aba"
```