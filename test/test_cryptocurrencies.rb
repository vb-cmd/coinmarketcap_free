require 'test_helper'

class TestCryptocurrencies < Minitest::Test
  def setup
    @cryptocurrencies = CoinmarketcapFree::Cryptocurrencies.new(10, 1)
  end

  def test_get_data
    cryptocurrencies = CoinmarketcapFree::Cryptocurrencies.new(10, 1)
    assert_equal true, cryptocurrencies.update
    data = JSON.parse(cryptocurrencies.data)
    assert_equal(data['status']['error_message'], 'SUCCESS')
  end

  def test_generate_uri
    string_uri = CoinmarketcapFree::Cryptocurrencies.const_get(:URL_API) + "?limit=10&start=1"
    generate_uri = @cryptocurrencies.send(:generate_uri_for_data).to_s
    assert_equal generate_uri, string_uri
  end
end
