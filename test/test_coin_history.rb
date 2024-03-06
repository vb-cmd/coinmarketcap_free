require_relative 'test_base'

class TestCoinHistory < TestBase
  def setup
    @id_coin = 1 # Is ID coin Bitcoin from Coinmarketcap
    @histories = CoinHistory.custom_time(@id_coin, '1D')
    @history = @histories.first
  end

  def test_get_histories
    refute_empty @histories

    assert(@histories.is_a?(Array))
  end

  def test_check_if_return_correct_class
    assert @history.is_a?(CoinHistory)
  end

  def test_check_if_methods_exist
    names = %w[one_day seven_days one_month three_months one_year current_year all]
            .map { |name| "CoinHistory.#{name}(@id_coin);" }

    eval <<~RUBY
      #{names.join}
    RUBY
  end
end
