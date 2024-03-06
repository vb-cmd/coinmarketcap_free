require_relative 'test_base'

class TestCoin < TestBase
  def setup
    @coins = Coin.list
    @coin = @coins.first
  end

  def test_get_coins
    refute_empty @coins
    assert_equal(@coins.count, 100)
  end

  def test_check_if_return_correct_class
    assert @coin.is_a?(Coin)
  end

  def test_check_if_coin_get_total_count_when_list_is_called
    refute_equal(Coin.total_count, 0)
  end

  def test_get_coin_histories
    histories = @coin.histories('1D')

    refute_empty histories
    assert histories.is_a?(Array)
    assert(histories.first.is_a?(CoinHistory))
  end

  def test_check_if_methods_exist
    names = %w[one_day seven_days one_month three_months one_year current_year all]
            .map { |name| "@coin.#{name}();" }

    eval <<~RUBY
      #{names.join}
    RUBY
  end

  def test_parameter_start_and_limit
    coins = Coin.list(start: 1, limit: 10)
    assert_equal(coins.count, 10)
    assert_equal(@coins.first.name.name, coins.first.name.name)
  end

  def test_parameter_sort_by
    coins = Coin.list(sort_by: 'name')
    refute_equal(@coins.first.name.name, coins.first.name.name)
  end

  def test_parameter_sort_type
    coins = Coin.list(sort_type: 'asc')
    refute_equal(@coins.first.name.name, coins.first.name.name)
  end

  def test_parameter_convert
    coins = Coin.list(convert: 'USD')
    names = coins.first.quotes.map(&:name)
    assert_includes(names, 'USD')

    coins = Coin.list(convert: 'USD,BTC,ETH')
    names = coins.first.quotes.map(&:name)
    assert_includes(names, 'USD')
    assert_includes(names, 'BTC')
    assert_includes(names, 'ETH')
  end
end
