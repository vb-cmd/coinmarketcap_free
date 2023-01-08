require 'test_helper'

class TestCoin < Minitest::Test
  def setup
    @coin = CoinmarketcapFree::Coin.new 1, '1D'
  end

  def test_generate_uri
    string_uri = CoinmarketcapFree::Coin.const_get(:URL_API) + "?id=1&range=1D"
    generate_uri = @coin.send(:generate_uri_for_data).to_s
    assert_equal generate_uri, string_uri
  end

  def test_get_data
    assert_equal true, @coin.update
    data = JSON.parse(@coin.data)
    assert_equal data['status']['error_message'], "SUCCESS"
  end
end
