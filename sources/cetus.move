module typus_oracle::cetus {
    use sui::event::emit;

    use cetus_clmm::pool::{Self, Pool, CalculatedSwapResult};

    struct CetusPoolConfig {
        pool_address: address,
        a2b: bool,
        by_amount_in: bool,
        amount: u64,
    }

    public fun new_cetus_pool_config(
        pool_address: address,
        a2b: bool,
        by_amount_in: bool,
        amount: u64,
    ): CetusPoolConfig {
        CetusPoolConfig {
            pool_address,
            a2b,
            by_amount_in,
            amount,
        }
    }

    public fun get_price<CoinTypeA, CoinTypeB>(
        pool: &Pool<CoinTypeA, CoinTypeB>,
        cetus_pool_config: &CetusPoolConfig,
    ) {

        let result = calculate_swap_result(pool, cetus_pool_config.a2b, cetus_pool_config.by_amount_in, cetus_pool_config.amount);
    }


    public fun calculate_swap_result<CoinTypeA, CoinTypeB>(
        pool: &Pool<CoinTypeA, CoinTypeB>,
        a2b: bool,
        by_amount_in: bool,
        amount: u64,
    ): u64 {
        let result: CalculatedSwapResult = pool::calculate_swap_result(pool, a2b, by_amount_in, amount);
        let amount_out: u64 = pool::calculated_swap_result_amount_out(&result);
        let is_exceed: bool = pool::calculated_swap_result_is_exceed(&result);
        emit(SwapResult{amount_out, is_exceed});
        amount_out
    }

    struct SwapResult has copy, drop {
        amount_out: u64,
        is_exceed: bool
    }
}