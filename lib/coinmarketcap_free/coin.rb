# frozen_string_literal: true

require 'coinmarketcap_free/helper'
require 'coinmarketcap_free/base'

module CoinmarketcapFree
  class Coin < CoinmarketcapFree::BASE
    URL_API = 'https://api.coinmarketcap.com/data-api/v3/cryptocurrency/detail/chart'
    private_constant :URL_API

    RANGE_TIME = %w[1D 7D 1M 3M 1Y YTD ALL]
    attr_accessor :id, :range_time
    # Get information about cryptocurrency
    # @param id Integer. Id cryptocurrency
    # @param range_time Range time, for example '1D' or custom range '1668981600~1671659999'
    def initialize(id, range_time)
      @id = id
      @range_time = range_time
    end

    def generate_uri_for_data
      query = "#{URL_API}?id=#{id}&range=#{range_time}"
      URI(query)
    end
  end
end
