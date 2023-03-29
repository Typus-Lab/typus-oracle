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
    "ORACLE_PACKAGE": "0xa95c782f521d321b984f38fdbc0536a962fc795460ceba28c508048ceab14bfd",
    "BTC_ORACLE": "0xde0b5a5279fb9cb1da76c148e969cded48299c2d6f08574584f3bd8532fd4509",
    "BTC_ORACLE_KEY": "0x7149bdd3bf35f93424c401c98331076ae0684dd2c8c9a43a6931db1b32484ca7",
    "ETH_ORACLE": "0x9f9658c86bae409f16907076f9c99a1f33044325d34bfb3c4a096000801b3c6d",
    "ETH_ORACLE_KEY": "0xd7ef341c6a20fb0985c2268794b7184b3bd5c25cdee078b4b36a4e215f922afa",
    "SUI_ORACLE": "0xf5e969446aeb3a612a6b060a988d01ba08be32597d80522fe662cb5243ef8efc",
    "SUI_ORACLE_KEY": "0x71abd86cbb57bc6b3679e6a7ad9c8353efc6da0362290ab4250a3a47e6ed1475",
    "APT_ORACLE": "0x35a53edad98b4fff702b0e90a5377aa6ff8f829b68de177a2245af95659d8cad",
    "APT_ORACLE_KEY": "0x326886de4ada48500a2bdd10e0a65be9f0d061fd0bb401a75c417090f23ab213",
    "DOGE_ORACLE": "0x3affaed19e4c5975d12c8532844c955df495feb080dd8d629b02d0cac9979639",
    "DOGE_ORACLE_KEY": "0xbb678d200850db441d7159165da228f7c4faabb14245fa6222b99171d2ae3505"
```