# frozen_string_literal: true

require "test_helper"

class TestCoinmarketcapFree < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::CoinmarketcapFree::VERSION
  end

  def test_coin_history
    parse = JSON.parse CoinmarketcapFree.coin_history 1, "1D"
    assert(parse.key?('data'))
    assert(parse['data'].key?('points'))
    assert(parse['data']['points'].is_a? Hash)
    assert(parse.key?('status'))
    assert_equal(parse['status']['error_message'], 'SUCCESS')
  end

  def test_coins
    parse = JSON.parse CoinmarketcapFree.coins limit: 100, start: 1
    assert(parse.key?('data'))
    assert(parse['data'].key?('cryptoCurrencyList'))
    assert(parse['data']['cryptoCurrencyList'].is_a? Array)
    assert(parse.key?('status'))
    assert_equal(parse['data']['cryptoCurrencyList'].size, 100)
  end
end
