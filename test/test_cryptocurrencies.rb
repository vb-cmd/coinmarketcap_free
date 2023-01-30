require 'test_helper'

class TestCryptocurrencies < Minitest::Test
  def setup
    @cryptocurrencies = CoinmarketcapFree::Cryptocurrencies.new(limit: 10, start: 1)
  end

  def test_get_data
    assert @cryptocurrencies.update
    parse = JSON.parse(@cryptocurrencies.get_data)
    assert(parse.key?('data'))
    assert(parse['data'].key?('cryptoCurrencyList'))
    assert_equal(parse['data']['cryptoCurrencyList'].size, 10)
    assert(parse['data']['cryptoCurrencyList'].is_a? Array)
    assert(parse.key?('status'))
  end

  def test_generate_uri
    string_uri = CoinmarketcapFree::Cryptocurrencies.const_get(:URL_API) + "?limit=10&start=1"
    generate_uri = @cryptocurrencies.send(:generate_uri_for_data).to_s
    assert_equal generate_uri, string_uri
  end
end
