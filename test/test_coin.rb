require 'test_helper'

class TestCoin < Minitest::Test
  def test_generate_uri
    uri = CoinmarketcapFree::CoinHistory.const_get(:URL_API)
    original_uri = uri + '?id=1&range=1D'
    generate_uri = CoinmarketcapFree::Helper.generate_uri_for_data(uri, { id: 1, range: '1D' })
    assert_equal generate_uri, original_uri
  end

  def test_get_data
    data = CoinmarketcapFree::CoinHistory.custom_time(1, '1D')
    refute_empty data
    parse_data = JSON.parse(data)
    assert(parse_data.key?('data'))
    assert(parse_data['data'].key?('points'))
    assert(parse_data['data']['points'].is_a?(Hash))
    assert(parse_data.key?('status'))
    assert_equal(parse_data['status']['error_message'], 'SUCCESS')
  end
end
