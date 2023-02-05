# frozen_string_literal: true

require_relative "coinmarketcap_free/coin"
require_relative "coinmarketcap_free/cryptocurrencies"
require_relative "coinmarketcap_free/base"
require_relative "coinmarketcap_free/version"

module CoinmarketcapFree
  class << self
    @@cryptocurrencies = Cryptocurrencies.new
    @@coin = Coin.new

    # Returns an interval of historic market quotes for any cryptocurrency based on time and interval parameters.
    #
    #   history = CoinmarketcapFree.coins(1, '1D')
    #
    # Result json:
    #
    #   {
    #     "data": {
    #         "points": {
    #             "1673192010": {
    #               "v": [
    #                     16953.771282696678,
    #                     7609543976.45,
    #                     326457581376.786557398500,
    #                     1,
    #                     19255750.00000000000000000000
    #                 ],
    #                 "c": [
    #                     16953.771282696678,
    #                     7609543976.45,
    #                     326457581376.786557398500
    #                 ]
    #             },
    #           ...
    #         }
    #     },
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
    # 'points' - Price range history
    # 'status' - Standardized status object for API calls.
    #
    # @param id [Integer] Cryptocurrency identifier from coinmarketcap. For example, Bitcoin has the number 1
    # @param range_time [String] Range time. For example, '1D', '7D', '1M', '3M', '1Y', 'YTD', 'ALL' or custom range '1668981600~1671659999'
    # @return [String, nil]
    def coin_history(id, range_time)
      @@coin.id = id
      @@coin.range_time = range_time
      @@coin.update ? @@coin.get_data : nil
    end

    # Returns an interval of historic for the day
    #
    # @param [Integer] id Cryptocurrency identifier
    def coin_history_day(id)
      coin_history(id, '1D')
    end

    # Returns an interval of historic for the seven days
    #
    # @param [Integer] id Cryptocurrency identifier
    def coin_history_seven_days(id)
      coin_history(id, '7D')
    end

    # Returns an interval of historic for the one month
    #
    # @param [Integer] id Cryptocurrency identifier
    def coin_history_one_month(id)
      coin_history(id, '1M')
    end

    # Returns an interval of historic for the three months
    #
    # @param [Integer] id Cryptocurrency identifier
    def coin_history_three_months(id)
      coin_history(id, '3M')
    end

    # Returns an interval of historic for the one year
    #
    # @param [Integer] id Cryptocurrency identifier
    def coin_history_one_year(id)
      coin_history(id, '1Y')
    end

    # Returns an interval of historic for the current year
    #
    # @param [Integer] id Cryptocurrency identifier
    def coin_history_current_year(id)
      coin_history(id, 'YTD')
    end

    # Returns an interval of historic for the current year
    #
    # @param [Integer] id Cryptocurrency identifier
    def coin_history_all(id)
      coin_history(id, 'ALL')
    end

    # Returns an interval of historic market quotes for any cryptocurrency based on time and interval parameters.
    #
    # Unix Epoch. (SECONDS SINCE JAN 01 1970 (UTC))
    #
    #   CoinmarketcapFree.coin_history_custom_time(1, 1675085165, 1675105165)
    #
    # @param [Integer] id Cryptocurrency identifier
    # @param [Integer] from Enter a Timestamp
    # @param [Integer] to Enter a Timestamp
    def coin_history_custom_time(id, from, to)
      coin_history(id, "#{from}~#{to}")
    end

    # Get a list of cryptocurrencies
    #
    #   list = CoinmarketcapFree.coins(limit: 100, start: 1)
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
    #   list = CoinmarketcapFree.coins(limit: 100, start: 1, sortType:'asc')
    #
    # or
    #
    #   list = CoinmarketcapFree.coins(limit: 100, start: 1, sortType:'desc')
    #
    # You can also adding sort by:
    #
    #   list = CoinmarketcapFree.coins(limit: 100, start: 1, sortType:'asc', sortBy: 'name')
    #
    # Convert cryptocurrency to::
    #
    #   list = CoinmarketcapFree.coins(limit: 100, start: 1, convert: 'USD,BTC,ETH')
    #
    #
    # @return [String, nil]
    # @param [Integer] start Optionally offset the start (1-based index) of the paginated list of items to return.
    # @param [Integer] limit Optionally specify the number of results to return. Use this parameter and the 'start' parameter to determine your own pagination size.
    # @param [String (frozen)] sortBy What field to sort the list of cryptocurrencies by. ('rank', 'name', 'symbol', 'date_added', 'market_cap', 'market_cap_strict', 'price', 'circulating_supply', 'total_supply', 'max_supply', 'num_market_pairs', 'volume_24h', 'percent_change_1h', 'percent_change_24h', 'percent_change_7d', 'market_cap_by_total_supply_strict', 'volume_7d', 'volume_30d")
    # @param [String (frozen)] sortType The direction in which to order cryptocurrencies against the specified sort. ('asc', 'desc')
    # @param [String (frozen)] convert Select cryptocurrencies to exchange ('AUD', 'BRL', 'CAD', 'CHF', 'CLP', 'CNY', 'CZK', 'DKK', 'EUR', 'GBP', 'HKD', 'HUF', 'IDR', 'ILS', 'INR', 'JPY', 'KRW', 'MXN', 'MYR', 'NOK', 'NZD', 'PHP', 'PKR', 'PLN', 'RUB', 'SEK', 'SGD', 'THB', 'TRY', 'TWD', 'ZAR'). For example, many 'USD,BTC,ETH' to convert or only one 'USD'
    # @param [String (frozen)] cryptoType The type of cryptocurrency to include. ('all', 'coins', 'tokens')
    # @param [String (frozen)] tagType The tag of cryptocurrency to include. ('all', 'defi', 'filesharing')
    # @param [TrueClass, FalseClass] audited Show audited 'true' or not 'false'
    # @param [String (frozen)] aux Optionally specify a comma-separated list of supplemental data fields to return. Pass 'ath, atl, high24h, low24h, num_market_pairs, cmc_rank, date_added, max_supply, circulating_supply, total_supply, volume_7d, volume_30d, self_reported_circulating_supply, self_reported_market_cap' to include all auxiliary fields.
    # @param [String (frozen)] tags If you want to see cryptocurrencies that can be mined, just type 'mineable'.
    # @param [String (frozen)] volume24hRange Optionally specify a threshold 24 hour USD volume to filter results by. For example, '0~100000000000000000'
    # @param [String (frozen)] percentChange24hRange Optionally specify a threshold 24 hour percent change to filter results by. For example, '0~100' or '-10~100'
    # @param [String (frozen)] circulatingSupplyRange Optionally specify a threshold circulating supply to filter results by. For example, '0~100000000000000000'
    # @param [String (frozen)] priceRange Optionally specify a threshold USD price to filter results by. For example, '0~100000000000000000'
    # @param [String (frozen)] marketCapRange Optionally specify a threshold market cap to filter results by. For example, '0~100000000000000000'
    def coins(start: 1,
              limit: 100,
              sortBy: 'market_cap',
              sortType: 'desc',
              convert: 'USD',
              cryptoType: 'all',
              tagType: 'all',
              audited: false,
              aux: nil,
              tags: nil,
              volume24hRange: nil,
              percentChange24hRange: nil,
              circulatingSupplyRange: nil,
              priceRange: nil,
              marketCapRange: nil)
      @@cryptocurrencies.limit = limit # Integer
      @@cryptocurrencies.start = start # Integer
      @@cryptocurrencies.sortBy = sortBy # String
      @@cryptocurrencies.sortType = sortType # String
      @@cryptocurrencies.convert = convert # String
      @@cryptocurrencies.cryptoType = cryptoType # String
      @@cryptocurrencies.tagType = tagType # String
      @@cryptocurrencies.audited = audited # Boolean
      @@cryptocurrencies.aux = aux # String
      @@cryptocurrencies.tags = tags # String
      @@cryptocurrencies.volume24hRange = volume24hRange # String
      @@cryptocurrencies.percentChange24hRange = percentChange24hRange # String
      @@cryptocurrencies.circulatingSupplyRange = circulatingSupplyRange # String
      @@cryptocurrencies.priceRange = priceRange # String
      @@cryptocurrencies.marketCapRange = marketCapRange # String

      @@cryptocurrencies.update ? @@cryptocurrencies.get_data : nil
    end

    # Get coin logo URL from coinmarketcap
    #
    #   logo = CoinmarketcapFree.img_coin(1, 64)
    #
    # Result:
    #   "https://s2.coinmarketcap.com/static/img/coins/64x64/1.png"
    #
    # @return [String] Return URL from coinmarketcap
    # @param [Integer] id_coin Identify coin. For example, bitcoin has 1
    # @param [Integer] size Choose one size: 64, 128, 200
    def img_coin_url(id_coin, size)
      size_x_size = case size
                    when 64, 128, 200
                      "#{size}x#{size}"
                    else
                      raise ArgumentError, "Can't find this value: #{size}"
                    end
      "https://s2.coinmarketcap.com/static/img/coins/#{size_x_size}/#{id_coin}.png"
    end
  end
end