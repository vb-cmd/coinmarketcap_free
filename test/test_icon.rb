# frozen_string_literal: true

require 'test_helper'

Icon = CoinmarketcapFree::Icon

class TestIcon < TestBase
  def setup
    @original_img_uri = 'https://s2.coinmarketcap.com/static/img/coins/64x64/1.png'
  end

  def test_generate_url_to_access_coin_logo
    generate_img_uri = Icon.generate_url(1, 64)

    assert_equal generate_img_uri, @original_img_uri

    assert_raises ArgumentError do
      Icon.generate_url(1, 68)
    end
  end
end
