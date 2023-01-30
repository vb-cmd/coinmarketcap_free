# frozen_string_literal: true

require 'coinmarketcap_free/helper'
require 'coinmarketcap_free/base'

module CoinmarketcapFree
  # Get a list of cryptocurrencies.
  #
  #   list = CoinmarketcapFree::Cryptocurrencies.new(limit: 100, start: 1)
  #   list.update
  #   list.get_data
  #
  # Result json:
  #
  #   {
  #     "data": {
  #         "cryptoCurrencyList": [
  #          {
  #             "id": 1,
  #             "name": "Bitcoin",
  #             "symbol": "BTC",
  #             "slug": "bitcoin",
  #             "tags": [
  #               "mineable",
  #               "pow",
  #               "sha-256",
  #               "store-of-value",
  #               "state-channel",
  #               "coinbase-ventures-portfolio",
  #               "three-arrows-capital-portfolio",
  #               "polychain-capital-portfolio",
  #               "binance-labs-portfolio",
  #               "blockchain-capital-portfolio",
  #               "boostvc-portfolio",
  #               "cms-holdings-portfolio",
  #               "dcg-portfolio",
  #               "dragonfly-capital-portfolio",
  #               "electric-capital-portfolio",
  #               "fabric-ventures-portfolio",
  #               "framework-ventures-portfolio",
  #               "galaxy-digital-portfolio",
  #               "huobi-capital-portfolio",
  #               "alameda-research-portfolio",
  #               "a16z-portfolio",
  #               "1confirmation-portfolio",
  #               "winklevoss-capital-portfolio",
  #               "usv-portfolio",
  #               "placeholder-ventures-portfolio",
  #               "pantera-capital-portfolio",
  #               "multicoin-capital-portfolio",
  #               "paradigm-portfolio"
  #             ],
  #             "cmcRank": 1,
  #             "marketPairCount": 9922,
  #             "circulatingSupply": 19256812.0,
  #             "selfReportedCirculatingSupply": 0,
  #             "totalSupply": 19256812.0,
  #             "maxSupply": 21000000.0,
  #             "isActive": 1,
  #             "lastUpdated": "2023-01-09T08:25:00.000Z",
  #             "dateAdded": "2013-04-28T00:00:00.000Z",
  #             "quotes": [
  #               {
  #                 "name": "USD",
  #                 "price": 17209.447088639048,
  #                 "volume24h": 13652714044.770432,
  #                 "marketCap": 331399087209.8695,
  #                 "percentChange1h": -0.00692023,
  #                 "percentChange24h": 1.50954046,
  #                 "percentChange7d": 2.78181713,
  #                 "lastUpdated": "2023-01-09T08:25:00.000Z",
  #                 "percentChange30d": 0.30441134,
  #                 "percentChange60d": 3.89490715,
  #                 "percentChange90d": -9.99714982,
  #                 "fullyDilluttedMarketCap": 361398388861.42,
  #                 "marketCapByTotalSupply": 331399087209.8695,
  #                 "dominance": 39.0828,
  #                 "turnover": 0.0411972,
  #                 "ytdPriceChangePercentage": 3.515
  #               }
  #             ],
  #             "isAudited": false
  #           }
  #         ...
  #         ],
  #         "totalCount": "8857"
  #         },
  #      "status": {
  #         "timestamp": "2023-01-08T15:33:30.271Z",
  #         "error_code": "0",
  #         "error_message": "SUCCESS",
  #         "elapsed": "2",
  #         "credit_count": 0
  #       }
  #   }
  #
  # 'data' - Results of your query returned as an object map.
  # 'cryptoCurrencyList' - Array of cryptocurrency objects matching the list options.
  # 'totalCount' - Total number of cryptocurrencies
  # 'status' - Standardized status object for API calls.
  #
  # If you want to sort in ascending, just write parameter:
  #
  #   list = CoinmarketcapFree::Cryptocurrencies.new(limit: 100, start: 1, sortType:'asc')
  #
  # or
  #
  #   list = CoinmarketcapFree::Cryptocurrencies.new(limit: 100, start: 1)
  #   list.sortType = 'asc'
  #
  # Also see other parameters.
  class Cryptocurrencies < BASE

    URL_API = 'https://api.coinmarketcap.com/data-api/v3/cryptocurrency/listing'.freeze
    private_constant :URL_API

    # Returns the CoinmarketcapFree::Cryptocurrencies that's dictated by the options hash. The primary options are:
    #
    # @param [Hash] options the parameters for creating a request to the server
    # @option options [Integer] :start (1) Optionally offset the start (1-based index) of the paginated list of items to return.
    # @option options [Integer] :limit (100) Optionally specify the number of results to return. Use this parameter and the 'start' parameter to determine your own pagination size.
    # @option options [String] :sortBy ('market_cap') What field to sort the list of cryptocurrencies by. ('rank', 'name', 'symbol', 'date_added', 'market_cap', 'market_cap_strict', 'price', 'circulating_supply', 'total_supply', 'max_supply', 'num_market_pairs', 'volume_24h', 'percent_change_1h', 'percent_change_24h', 'percent_change_7d', 'market_cap_by_total_supply_strict', 'volume_7d', 'volume_30d")
    # @option options [String] :sortType ('desc') The direction in which to order cryptocurrencies against the specified sort. ('asc', 'desc')
    # @option options [String] :convert ('USD') Select cryptocurrencies to exchange ('AUD', 'BRL', 'CAD', 'CHF', 'CLP', 'CNY', 'CZK', 'DKK', 'EUR', 'GBP', 'HKD', 'HUF', 'IDR', 'ILS', 'INR', 'JPY', 'KRW', 'MXN', 'MYR', 'NOK', 'NZD', 'PHP', 'PKR', 'PLN', 'RUB', 'SEK', 'SGD', 'THB', 'TRY', 'TWD', 'ZAR'). For example, many 'USD,BTC,ETH' to convert or only one 'USD'
    # @option options [String] :cryptoType ('all') The type of cryptocurrency to include. ('all', 'coins', 'tokens')
    # @option options [String] :tagType ('all') The tag of cryptocurrency to include. ('all', 'defi', 'filesharing')
    # @option options [false, true] :audited Show audited 'true' or not 'false'
    # @option options [String] :aux Optionally specify a comma-separated list of supplemental data fields to return. Pass 'ath, atl, high24h, low24h, num_market_pairs, cmc_rank, date_added, max_supply, circulating_supply, total_supply, volume_7d, volume_30d, self_reported_circulating_supply, self_reported_market_cap' to include all auxiliary fields.
    # @option options [String] :tags If you want to see cryptocurrencies that can be mined, just type 'mineable'.
    # @option options [String] :volume24hRange Optionally specify a threshold 24 hour USD volume to filter results by. For example, '0~100000000000000000'
    # @option options [String] :percentChange24hRange Optionally specify a threshold 24 hour percent change to filter results by. For example, '0~100' or '-10~100'
    # @option options [String] :circulatingSupplyRange Optionally specify a threshold circulating supply to filter results by. For example, '0~100000000000000000'
    # @option options [String] :priceRange Optionally specify a threshold USD price to filter results by. For example, '0~100000000000000000'
    # @option options [String] :marketCapRange Optionally specify a threshold market cap to filter results by. For example, '0~100000000000000000'
    def initialize(options = {})
      @limit = options[:limit].nil? ? 100 : options[:limit] # Integer
      @start = options[:start].nil? ? 1 : options[:start] # Integer
      @sortBy = options[:sortBy] # String
      @sortType = options[:sortType] # String
      @convert = options[:convert] # String
      @cryptoType = options[:cryptoType] # String
      @tagType = options[:tagType] # String
      @audited = options[:audited] # Boolean
      @aux = options[:aux] # String
      @tags = options[:tags] # String
      @volume24hRange = options[:volume24hRange] # String
      @percentChange24hRange = options[:percentChange24hRange] # String
      @circulatingSupplyRange = options[:circulatingSupplyRange] # String
      @priceRange = options[:priceRange] # String
      @marketCapRange = options[:marketCapRange] # String
    end

    attr_accessor :limit,
                  :start,
                  :sortBy,
                  :sortType,
                  :convert,
                  :cryptoType,
                  :tagType,
                  :audited,
                  :aux,
                  :tags,
                  :volume24hRange,
                  :percentChange24hRange,
                  :circulatingSupplyRange,
                  :priceRange,
                  :marketCapRange

    private
    def generate_uri_for_data
      options = self.instance_variables
                    .select { |name_var| not self.instance_variable_get(name_var).nil? }
                    .map {|name_var| "#{name_var.to_s.delete('@')}=#{self.instance_variable_get(name_var)}"}

      query = "#{URL_API}?#{options.join('&')}"
      URI(query)
    end
  end
end