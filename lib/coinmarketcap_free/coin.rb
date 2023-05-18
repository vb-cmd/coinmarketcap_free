# frozen_string_literal: true

require_relative 'helper'

module CoinmarketcapFree
  # All about cryptocurrencies and their prices.
  module Coin
    URL_API = 'https://api.coinmarketcap.com/data-api/v3/cryptocurrency/listing'
    private_constant :URL_API

    class << self
      # Get a list of cryptocurrencies
      #
      #   list = CoinmarketcapFree::Coin.list(limit: 100, start: 1)
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
      #     "status": {
      #         "timestamp": "2023-01-08T15:33:30.271Z",
      #         "error_code": "0",
      #         "error_message": "SUCCESS",
      #         "elapsed": "2",
      #         "credit_count": 0
      #     }
      #   }
      #
      # 'data' - Results of your query returned as an object map.
      # 'cryptoCurrencyList' - Array of cryptocurrency objects matching the list options.
      # 'totalCount' - Total number of cryptocurrencies
      # 'status' - Standardized status object for API calls.
      #
      # If you want to sort in ascending, just write parameter:
      #
      #   list = CoinmarketcapFree::Coin.list(limit: 100, start: 1, sort_type:'asc')
      #
      # or
      #
      #   list = CoinmarketcapFree::Coin.list(limit: 100, start: 1, sort_type:'desc')
      #
      # You can also adding sort by:
      #
      #   list = CoinmarketcapFree::Coin.list(limit: 100, start: 1, sort_type:'asc', sort_by: 'name')
      #
      # Convert cryptocurrency to::
      #
      #   list = CoinmarketcapFree::Coin.list(limit: 100, start: 1, convert: 'USD,BTC,ETH')
      #
      #
      # @return [String]
      # @param [Integer] start Optionally offset the start (1-based index) of the paginated list of items to return.
      # @param [Integer] limit Optionally specify the number of results to return. Use this parameter and the 'start' parameter to determine your own pagination size.
      # @param [String] sort_by What field to sort the list of cryptocurrencies by. ('rank', 'name', 'symbol', 'date_added', 'market_cap', 'market_cap_strict', 'price', 'circulating_supply', 'total_supply', 'max_supply', 'num_market_pairs', 'volume_24h', 'percent_change_1h', 'percent_change_24h', 'percent_change_7d', 'market_cap_by_total_supply_strict', 'volume_7d', 'volume_30d")
      # @param [String] sort_type The direction in which to order cryptocurrencies against the specified sort. ('asc', 'desc')
      # @param [String] convert Select cryptocurrencies to exchange ('AUD', 'BRL', 'CAD', 'CHF', 'CLP', 'CNY', 'CZK', 'DKK', 'EUR', 'GBP', 'HKD', 'HUF', 'IDR', 'ILS', 'INR', 'JPY', 'KRW', 'MXN', 'MYR', 'NOK', 'NZD', 'PHP', 'PKR', 'PLN', 'RUB', 'SEK', 'SGD', 'THB', 'TRY', 'TWD', 'ZAR'). For example, many 'USD,BTC,ETH' to convert or only one 'USD'
      # @param [String] crypto_type The type of cryptocurrency to include. ('all', 'coins', 'tokens')
      # @param [String] tag_type The tag of cryptocurrency to include. ('all', 'defi', 'filesharing')
      # @param [TrueClass, FalseClass] audited Show audited 'true' or not 'false'
      # @param [String] aux Optionally specify a comma-separated list of supplemental data fields to return. Pass 'ath, atl, high24h, low24h, num_market_pairs, cmc_rank, date_added, max_supply, circulating_supply, total_supply, volume_7d, volume_30d, self_reported_circulating_supply, self_reported_market_cap' to include all auxiliary fields.
      # @param [String] tags If you want to see cryptocurrencies that can be mined, just type 'mineable'.
      # @param [String] volume24h_range Optionally specify a threshold 24 hour USD volume to filter results by. For example, '0~100000000000000000'
      # @param [String] percent_change24h_range Optionally specify a threshold 24 hour percent change to filter results by. For example, '0~100' or '-10~100'
      # @param [String] circulating_supply_range Optionally specify a threshold circulating supply to filter results by. For example, '0~100000000000000000'
      # @param [String] price_range Optionally specify a threshold USD price to filter results by. For example, '0~100000000000000000'
      # @param [String] market_cap_range Optionally specify a threshold market cap to filter results by. For example, '0~100000000000000000'
      def list(**params)
        options = {}

        options[:start] = params[:start] || 1 # Integer
        options[:limit] = params[:limit] || 100 # Integer
        options[:sortBy] = params[:sort_by] || 'market_cap' # String
        options[:sortType] = params[:sort_type] || 'desc' # String
        options[:convert]  = params[:convert] || 'USD' # String
        options[:cryptoType] = params[:crypto_type] || 'all' # String
        options[:tagType] = params[:tag_type] || 'all' # String
        options[:audited] = params[:audited] || false # Boolean
        options[:aux] = params[:aux] # String
        options[:tags] = params[:tags] # String
        options[:volume24hRange] = params[:volume24h_range] # String
        options[:percentChange24hRange] = params[:percent_change24h_range] # String
        options[:circulatingSupplyRange] = params[:circulating_supply_range] # String
        options[:priceRange] = params[:price_range] # String
        options[:marketCapRange] = params[:market_cap_range] # String

        Helper.http_get(URL_API, options)
      end
    end
  end
end
