# frozen_string_literal: true

require 'test_helper'

class TestCoinHistory < Minitest::Test
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
