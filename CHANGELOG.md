## Change Log

### 0.5.0

1. Breaking Change:
   - Create oracle folder
   - add pyth oracle
   - remove type args

### 0.4.1

1. Function Args Change:
   - ts_ms: u64 -> clock: &Clock

### 0.4.0

1. Breaking Change:

   - rename oracle to public_oracle
   - add a new (private) oracle module

2. Function Change about private Oracle:
   - replace Key with ManagerCap

### 0.3.1

1. Struct Change:

   - Oracle: add quote_token, base_token

2. Function Change:
   - new_oracle add quote_token, base_token
   - add price check in update
   - add get_twap_price

### 0.3.0

1. Struct Change:

   - Oracle: twap_price_1h rename twap_price

2. Function Args Change:
   - twap_price_1h rename twap_price
   - ts_ms: u64 -> clock: &Clock
