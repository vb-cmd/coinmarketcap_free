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
    #   list = CoinmarketcapFree.coins(limit: 100, start: 1, sort_type:'asc')
    #
    # Also see other parameters:
    #
    # * <tt> start: </tt> - [Integer] Default: 1. Optionally offset the start (1-based index) of the paginated list of items to return.
    # * <tt> limit: </tt> - [Integer] Default: 100. Optionally specify the number of results to return.
    #   Use this parameter and the "start" parameter to determine your own pagination size.
    # * <tt> sort_by: </tt> - [String] Default: "market_cap". ("rank", "name", "symbol", "date_added", "market_cap", "market_cap_strict", "price", "circulating_supply", "total_supply", "max_supply", "num_market_pairs", "volume_24h", "percent_change_1h", "percent_change_24h", "percent_change_7d", "market_cap_by_total_supply_strict", "volume_7d", "volume_30d").
    #   What field to sort the list of cryptocurrencies by.
    # * <tt> sort_type: </tt> - [String] Default: "desc". ("asc" or "desc"). The direction in which to order cryptocurrencies against the specified sort.
    # * <tt> convert: </tt> - [String] Default: 'USD'. Default: 'USD'. Select cryptocurrencies to exchange
    #   ("AUD", "BRL", "CAD", "CHF", "CLP", "CNY", "CZK", "DKK", "EUR", "GBP", "HKD", "HUF", "IDR", "ILS", "INR", "JPY", "KRW", "MXN", "MYR", "NOK", "NZD", "PHP", "PKR", "PLN", "RUB", "SEK", "SGD", "THB", "TRY", "TWD", "ZAR").
    #   For example, many 'USD,BTC,ETH' to convert or only one 'USD'
    # * <tt> crypto_typ: </tt> - [String] Default: "all". ("all", "coins", "tokens"). The type of cryptocurrency to include.
    # * <tt> tag_type: </tt> - [String] Default: "all". ("all", "defi", "filesharing"). The tag of cryptocurrency to include.
    # * <tt> audited: </tt> - [FalseClass, TrueClass] Show audited (true) or not (false)
    # * <tt> aux: </tt> - [String] Optionally specify a comma-separated list of supplemental data fields to return.
    #   Pass 'ath, atl, high24h, low24h, num_market_pairs, cmc_rank, date_added, max_supply, circulating_supply, total_supply, volume_7d, volume_30d, self_reported_circulating_supply, self_reported_market_cap' to include all auxiliary fields.
    # * <tt> tags: </tt> - [String] If you want to see cryptocurrencies that can be mined, just type 'mineable'.
    # * <tt> volume_24h_range: </tt> - [String] Optionally specify a threshold 24 hour USD volume to filter results by.
    #   For example, For example, '0~100000000000000000'
    # * <tt> percent_change_24h_range: </tt> - [String] Optionally specify a threshold 24 hour percent change to filter results by.
    #   For example, '0~100' or '-10~100'
    # * <tt> circulating_supply_range: </tt> - [String] Optionally specify a threshold circulating supply to filter results by. For example, '0~100000000000000000'
    # * <tt> price_range: </tt> - [String] Optionally specify a threshold USD price to filter results by. For example, '0~100000000000000000'
    # * <tt> market_cap_range: </tt> - [String] Optionally specify a threshold market cap to filter results by. For example, '0~100000000000000000'
    #
    # @param [Hash] options
    # @return [String, nil]
    def coins(**options)
      @@cryptocurrencies.instance_variables.each do |var_name|
        value = options[var_name.to_s.delete('@').to_sym]
        @@cryptocurrencies.instance_variable_set(var_name, value) unless value.nil?
      end

      @@cryptocurrencies.update ? @@cryptocurrencies.get_data : nil
    end

    # Get coin logo URL from coinmarketcap
    #
    #   logo = CoinmarketcapFree.img_coin(1, '64x64')
    #
    # Result:
    #   "https://s2.coinmarketcap.com/static/img/coins/64x64/1.png"
    #
    # @return [String] Return URL from coinmarketcap
    # @param [Integer] id_coin Identify coin. For example, bitcoin has 1
    # @param [String] size Choose one size: 64x64, 128x128, 200x200
    def img_coin(id_coin, size)
      "https://s2.coinmarketcap.com/static/img/coins/#{size}/#{id_coin}.png"
    end
  end
end
