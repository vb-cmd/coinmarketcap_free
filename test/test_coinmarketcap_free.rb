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

  def test_img_coin_url
    generate_img_url = CoinmarketcapFree.img_coin_url(1, 64)
    original_img_url = "https://s2.coinmarketcap.com/static/img/coins/64x64/1.png"
    assert_equal generate_img_url, original_img_url

    assert_raises ArgumentError do
      CoinmarketcapFree.img_coin_url(1, 68)
    end
  end
end
