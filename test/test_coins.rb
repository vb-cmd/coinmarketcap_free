require 'test_helper'

class TestCoins < Minitest::Test
  def test_generate_uri
    uri = CoinmarketcapFree::Coins.const_get(:URL_API)
    original_uri = uri + '?limit=10&start=1'
    generate_uri = CoinmarketcapFree::Helper.generate_uri_for_data(uri, { limit: 10, start: 1 })

    assert_equal original_uri, generate_uri
  end

  def test_get_data
    data = CoinmarketcapFree::Coins.get_list
    refute_empty data
    parse = JSON.parse(data)
    assert(parse.key?('data'))
    assert(parse['data'].key?('cryptoCurrencyList'))
    assert_equal(parse['data']['cryptoCurrencyList'].size, 100)
    assert(parse['data']['cryptoCurrencyList'].is_a?(Array))
    assert(parse.key?('status'))
  end
end
