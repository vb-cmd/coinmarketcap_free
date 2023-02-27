# frozen_string_literal: true

require 'test_helper'

class TestIcons < Minitest::Test
  def test_img_coin_url
    generate_img_url = CoinmarketcapFree::Icons.get_coin_logo_uri(1, 64)
    original_img_url = 'https://s2.coinmarketcap.com/static/img/coins/64x64/1.png'
    assert_equal generate_img_url, original_img_url

    assert_raises ArgumentError do
        CoinmarketcapFree::Icons.get_coin_logo_uri(1, 68)
    end
  end
end
