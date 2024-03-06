require_relative 'test_base'

class TestCoinHistory < TestBase
  def setup
    @id_coin = 1 # Is ID coin Bitcoin from Coinmarketcap
    @histories = CoinHistory.custom_time(@id_coin, '1D')
  end

  def test_get_histories
    histories = CoinHistory.custom_time(@id_coin, '1D')

    refute_empty histories

    assert(histories.is_a?(Array))
    assert(histories.first.is_a?(CoinHistory))
  end

  def test_check_return_class
    first_coin = CoinHistory.custom_time(@id_coin, '1D').first
    assert first_coin.is_a?(CoinHistory)
  end

  def test_check_if_exists_methods
    names = %w[one_day seven_days one_month three_months one_year current_year all]
            .map { |name| "CoinHistory.#{name}(@id_coin);" }

    eval <<~RUBY
      #{names.join}
    RUBY
  end
end
