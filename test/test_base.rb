$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require './lib/coinmarketcap_free'

require 'minitest/autorun'

Coin = CoinmarketcapFree::Coin
CoinHistory = CoinmarketcapFree::CoinHistory
Helper = CoinmarketcapFree::Helper

class TestBase < Minitest::Test
end
