# frozen_string_literal: true

require_relative 'helper'
require_relative 'coin/icon'
require_relative 'coin/model'
require_relative 'coin_history'

module CoinmarketcapFree
  # Model for Cryptocurrency
  class Coin
    attr_accessor :id,
                  :name,
                  :tags,
                  :cmc_rank,
                  :market_pair_count,
                  :supply,
                  :state,
                  :quotes

    def initialize(id, name, tags, cmc_rank, market_pair_count, supply, state, quotes)
      @id = id
      @name = name
      @tags = tags
      @cmc_rank = cmc_rank
      @market_pair_count = market_pair_count
      @supply = supply
      @state = state
      @quotes = quotes
    end

    # Get all history cryptocurrency and their prices.
    # @param interval [String] Select time interval. ('1D', '7D', '1M', '3M', '1Y', 'YTD', 'ALL' or custom '1668981600~1671659999')
    # @return [Array<CoinmarketcapFree::CoinHistory>] Return CoinHistory object
    def histories(interval)
      CoinHistory.custom_time(@id, interval)
    end

    class << self
      # Get a list of cryptocurrencies
      #
      #   list = CoinmarketcapFree::Coin.list(limit: 100, start: 1)
      #
      # If you want to sort in ascending, just write parameter:
      #
      #   list = CoinmarketcapFree::Coin.list(limit: 100, start: 1, sort_type:'asc')
      #
      # or in descending
      #
      #   list = CoinmarketcapFree::Coin.list(limit: 100, start: 1, sort_type:'desc')
      #
      # Or sort by name with ascending:
      #
      #   list = CoinmarketcapFree::Coin.list(limit: 100, start: 1, sort_type:'asc', sort_by: 'name')
      #
      # Convert cryptocurrency to USD:
      #
      #   list = CoinmarketcapFree::Coin.list(limit: 100, start: 1, convert: 'USD')
      #
      # or combine
      #
      #   list = CoinmarketcapFree::Coin.list(limit: 100, start: 1, convert: 'USD,BTC,ETH')
      #
      # Also you can get all histories of cryptocurrency:
      #
      #   coin = CoinmarketcapFree::Coin.list(limit: 100, start: 1).first
      #   coin.histories('1D')
      #
      # Result json data:
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
      # @param start [Integer] Optionally offset the start (1-based index) of the paginated list of items to return.
      # @param limit [Integer] Optionally specify the number of results to return. Use this parameter and the 'start' parameter to determine your own pagination size.
      # @param sort_by [String] What field to sort the list of cryptocurrencies by. ('rank', 'name', 'symbol', 'date_added', 'market_cap', 'market_cap_strict', 'price', 'circulating_supply', 'total_supply', 'max_supply', 'num_market_pairs', 'volume_24h', 'percent_change_1h', 'percent_change_24h', 'percent_change_7d', 'market_cap_by_total_supply_strict', 'volume_7d', 'volume_30d")
      # @param sort_type [String] The direction in which to order cryptocurrencies against the specified sort. ('asc', 'desc')
      # @param convert [String] Select cryptocurrencies to exchange ('AUD', 'BRL', 'CAD', 'CHF', 'CLP', 'CNY', 'CZK', 'DKK', 'EUR', 'GBP', 'HKD', 'HUF', 'IDR', 'ILS', 'INR', 'JPY', 'KRW', 'MXN', 'MYR', 'NOK', 'NZD', 'PHP', 'PKR', 'PLN', 'RUB', 'SEK', 'SGD', 'THB', 'TRY', 'TWD', 'ZAR'). For example, many 'USD,BTC,ETH' to convert or only one 'USD'
      # @param crypto_type [String] The type of cryptocurrency to include. ('all', 'coins', 'tokens')
      # @param tag_type [String] The tag of cryptocurrency to include. ('all', 'defi', 'filesharing')
      # @param audited [TrueClass, FalseClass] Show audited 'true' or not 'false'
      # @param tags [String] If you want to see cryptocurrencies that can be mined, just type 'mineable'.
      # @param volume24h_range [String] Optionally specify a threshold 24 hour USD volume to filter results by. For example, '0~100000000000000000'
      # @param percent_change24h_range [String] Optionally specify a threshold 24 hour percent change to filter results by. For example, '0~100' or '-10~100'
      # @param circulating_supply_range [String] Optionally specify a threshold circulating supply to filter results by. For example, '0~100000000000000000'
      # @param price_range [String] Optionally specify a threshold USD price to filter results by. For example, '0~100000000000000000'
      # @param market_cap_range [String] Optionally specify a threshold market cap to filter results by. For example, '0~100000000000000000'
      # @return [CoinmarketcapFree::Coin] Return Coin object
      def list(**params)
        options = generate_options(params)
        json = Helper.get_cryptocarencies(options)

        @total_count = json['data']['totalCount'].to_i # update total count

        json['data']["cryptoCurrencyList"].map { |coin| Coin.convert_json(coin) }
      end

      def total_count
        @total_count || 0
      end

      # Convert json data to Coin
      # @param data [Hash] Data
      # @return [CoinmarketcapFree::Coin] Return Coin object
      def convert_json(data)
        id = data['id']
        name = FullName.convert_json(data)
        tags = data['tags'] || []
        cmc_rank = data['cmcRank']
        market_pair_count = data['marketPairCount']
        supply = Supply.convert_json(data)
        state = State.convert_json(data)
        quotes = data['quotes'].nil? ? [] : data['quotes'].map { |quote| Quotes.convert_json(quote) }

        Coin.new(id, name, tags, cmc_rank, market_pair_count, supply, state, quotes)
      end

      private

      # Generate options for method list
      # @param params [Hash]
      # @return [Hash] Return options
      def generate_options(params)
        options = {}

        options[:start] = params[:start] || 1 # Integer
        options[:limit] = params[:limit] || 100 # Integer
        options[:sortBy] = params[:sort_by] || 'market_cap' # String
        options[:sortType] = params[:sort_type] || 'desc' # String
        options[:convert]  = params[:convert] || 'USD' # String
        options[:cryptoType] = params[:crypto_type] || 'all' # String
        options[:tagType] = params[:tag_type] || 'all' # String
        options[:audited] = params[:audited] || false # Boolean
        options[:tags] = params[:tags] # String
        options[:volume24hRange] = params[:volume24h_range] # String
        options[:percentChange24hRange] = params[:percent_change24h_range] # String
        options[:circulatingSupplyRange] = params[:circulating_supply_range] # String
        options[:priceRange] = params[:price_range] # String
        options[:marketCapRange] = params[:market_cap_range] # String

        options
      end
    end
  end
end
