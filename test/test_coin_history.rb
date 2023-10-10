# frozen_string_literal: true

require 'test_helper'

CoinHistory = CoinmarketcapFree::CoinHistory

class TestCoinHistory < TestBase
  def test_get_data
    data = CoinHistory.custom_time(1, '1D')

    refute_empty data

    parse_data = JSON.parse(data)

    assert(parse_data.key?('data'))
    assert(parse_data['data'].key?('points'))
    assert(parse_data['data']['points'].is_a?(Hash))
    assert(parse_data.key?('status'))

    assert_equal(parse_data['status']['error_message'], 'SUCCESS')
  end
end
