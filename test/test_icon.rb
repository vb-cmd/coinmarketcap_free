# frozen_string_literal: true

require 'test_helper'

class TestIcon < Minitest::Test
  def test_generate_url_to_access_coin_logo
    generate_img_url = CoinmarketcapFree::Icon.generate_url(1, 64)
    original_img_url = 'https://s2.coinmarketcap.com/static/img/coins/64x64/1.png'
    assert_equal generate_img_url, original_img_url

    assert_raises ArgumentError do
      CoinmarketcapFree::Icon.generate_url(1, 68)
    end
  end
end
