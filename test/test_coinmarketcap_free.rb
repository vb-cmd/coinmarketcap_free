# frozen_string_literal: true

require 'test_helper'

class TestCoinmarketcapFree < TestBase
  def test_that_it_has_a_version_number
    refute_nil ::CoinmarketcapFree::VERSION
  end

  def test_generate_uri
    uri = CoinmarketcapFree::CoinHistory.const_get(:URI_API)

    original_uri = "#{uri}?id=1&range=1D"
    generate_uri = CoinmarketcapFree::Helper.send(:generate_url, uri, { id: 1, range: '1D' })

    assert_equal generate_uri, original_uri
  end
end
