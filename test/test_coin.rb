require_relative 'test_base'

class TestCoin < TestBase
  def setup
    @coins = Coin.list(limit: 50, start: 1)
  end

  def test_get_coins
    refute_empty @coins
    assert_equal(@coins.count, 50)
  end

  def test_check_return_class
    first_coin = @coins.first
    assert first_coin.is_a?(Coin)
  end

  def test_check_if_coin_get_total_count_when_list_is_called
    refute_equal(Coin.total_count, 0)
  end

  def test_get_coin_histories
    coin = @coins.first
    histories = coin.histories('1D')

    refute_empty histories
    assert(histories.first.is_a?(CoinHistory))
  end
end
