# frozen_string_literal: true

require 'coinmarketcap_free/helper'
require 'coinmarketcap_free/base'

module CoinmarketcapFree
  # Get a list of cryptocurrencies
  #
  # For example, result json data
  #{
  #   "data": {
  #     "cryptoCurrencyList": [...],
  #     "totalCount": "8857"
  #   },
  #   "status": {...}
  # }
  #
  # 'data' - Results of your query returned as an object map.
  #   'cryptoCurrencyList' - Array of cryptocurrency objects matching the list options.
  #   'totalCount' - Total number of cryptocurrencies
  # 'status' - Standardized status object for API calls.
  class Cryptocurrencies < BASE

    URL_API = 'https://api.coinmarketcap.com/data-api/v3/cryptocurrency/listing'.freeze
    private_constant :URL_API

    #   start: Integer. Default: 1 | Optionally offset the start (1-based index) of the paginated list of items to return.
    #   limit: Integer. Default: 100 | Optionally specify the number of results to return. Use this parameter and the "start" parameter to determine your own pagination size.
    #   sort_by: String. Default: "market_cap". ("rank", "name", "symbol", "date_added", "market_cap", "market_cap_strict", "price", "circulating_supply", "total_supply", "max_supply", "num_market_pairs", "volume_24h", "percent_change_1h", "percent_change_24h", "percent_change_7d", "market_cap_by_total_supply_strict", "volume_7d", "volume_30d"). What field to sort the list of cryptocurrencies by.
    #   sort_type: String. Default: "desc". ("asc" or "desc"). The direction in which to order cryptocurrencies against the specified sort.
    #   convert: String. Default: 'USD'. Select cryptocurrencies to exchange. For example, many 'USD,BTC,ETH' to convert or only one 'USD'
    #   crypto_type: String. Default: "all". ("all", "coins", "tokens"). The type of cryptocurrency to include.
    #   tag_type: String. Default: "all". ("all", "defi", "filesharing"). The tag of cryptocurrency to include.
    #   audited: Boolean. false or true
    #   aux: String. Optionally specify a comma-separated list of supplemental data fields to return. Pass 'ath, atl, high24h, low24h, num_market_pairs, cmc_rank, date_added, max_supply, circulating_supply, total_supply, volume_7d, volume_30d, self_reported_circulating_supply, self_reported_market_cap' to include all auxiliary fields.
    #   tags: String. Usually choose 'mineable'.
    #   volume_24h_range: String. Optionally specify a threshold 24 hour USD volume to filter results by. For example, For example, '0~100000000000000000'
    #   percent_change_24h_range: String. Optionally specify a threshold 24 hour percent change to filter results by. For example, '0~100' or '-10~100'
    #   circulating_supply_range: String. Optionally specify a threshold circulating supply to filter results by. For example, '0~100000000000000000'
    #   price_range: String. Optionally specify a threshold USD price to filter results by. For example, '0~100000000000000000'
    #   market_cap_range: String. Optionally specify a threshold market cap to filter results by. For example, '0~100000000000000000'
    def initialize(limit = 100, start = 1, **options)
      @limit = limit # Integer
      @start = start # Integer
      @sort_by = options[:sort_by] # String
      @sort_type = options[:sort_type] # String
      @convert = options[:convert] # String
      @crypto_type = options[:crypto_type] # String
      @tag_type = options[:tag_type] # String
      @audited = options[:audited] # Boolean
      @aux = options[:aux] # String
      @tags = options[:tags] # String
      @volume_24h_range = options[:volume_24h_range] # String
      @percent_change_24h_range = options[:percent_change_24h_range] # String
      @circulating_supply_range = options[:circulating_supply_range] # String
      @price_range = options[:price_range] # String
      @market_cap_range = options[:market_cap_range] # String
    end

    attr_accessor :limit,
                  :start,
                  :sort_by,
                  :sort_type,
                  :convert,
                  :crypto_type,
                  :tag_type,
                  :audited,
                  :aux,
                  :tags,
                  :volume_24h_range,
                  :percent_change_24h_range,
                  :circulating_supply_range,
                  :price_range,
                  :market_cap_range

    def generate_uri_for_data
      options = self.instance_variables.filter_map do |name_var|
        "#{name_var.to_s.delete('@')}=#{self.instance_variable_get(name_var)}" unless self.instance_variable_get(name_var).nil?
      end

      query = "#{URL_API}?#{options.join('&')}"
      URI(query)
    end
  end
end