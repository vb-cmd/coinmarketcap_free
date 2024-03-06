require_relative 'test_base'

class TestVerion < TestBase
  def test_that_it_has_a_version_number
    refute_nil ::CoinmarketcapFree::VERSION
  end
end
