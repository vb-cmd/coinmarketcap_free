# frozen_string_literal: true

require_relative 'coinmarketcap_free/coin_history'
require_relative 'coinmarketcap_free/coin'
require_relative 'coinmarketcap_free/icon'
require_relative 'coinmarketcap_free/version'

# Get data from Coinmarketcap API without requiring an API key.
module CoinmarketcapFree
  class << self
    # Get a list of cryptocurrencies
    #
    #   list = CoinmarketcapFree.coins(limit: 100, start: 1)
    #
    # If you want to sort in ascending, just write parameter:
    #
    #   list = CoinmarketcapFree.coins(limit: 100, start: 1, sort_type:'asc')
    #
    # or
    #
    #   list = CoinmarketcapFree.coins(limit: 100, start: 1, sort_type:'desc')
    #
    # You can also adding sort by:
    #
    #   list = CoinmarketcapFree.coins(limit: 100, start: 1, sort_type:'asc', sort_by: 'name')
    #
    # Convert cryptocurrency to::
    #
    #   list = CoinmarketcapFree.coins(limit: 100, start: 1, convert: 'USD,BTC,ETH')
    #
    # Also you can use this method like this:
    #
    #   list = CoinmarketcapFree.coins(limit: 100, start: 1, convert: 'USD,BTC,ETH') do |data|
    #       JSON.parse(data)
    #   end
    #
    #
    # @param start [Integer] Optionally offset the start (1-based index) of the paginated list of items to return.
    # @param limit [Integer] Optionally specify the number of results to return. Use this parameter and the 'start' parameter to determine your own pagination size.
    # @param sort_by [String] What field to sort the list of cryptocurrencies by. ('rank', 'name', 'symbol', 'date_added', 'market_cap', 'market_cap_strict', 'price', 'circulating_supply', 'total_supply', 'max_supply', 'num_market_pairs', 'volume_24h', 'percent_change_1h', 'percent_change_24h', 'percent_change_7d', 'market_cap_by_total_supply_strict', 'volume_7d', 'volume_30d")
    # @param sort_type [String] The direction in which to order cryptocurrencies against the specified sort. ('asc', 'desc')
    # @param convert [String] Select cryptocurrencies to exchange ('AUD', 'BRL', 'CAD', 'CHF', 'CLP', 'CNY', 'CZK', 'DKK', 'EUR', 'GBP', 'HKD', 'HUF', 'IDR', 'ILS', 'INR', 'JPY', 'KRW', 'MXN', 'MYR', 'NOK', 'NZD', 'PHP', 'PKR', 'PLN', 'RUB', 'SEK', 'SGD', 'THB', 'TRY', 'TWD', 'ZAR'). For example, many 'USD,BTC,ETH' to convert or only one 'USD'
    # @param crypto_type [String] The type of cryptocurrency to include. ('all', 'coins', 'tokens')
    # @param tag_type [String] The tag of cryptocurrency to include. ('all', 'defi', 'filesharing')
    # @param audited [TrueClass, FalseClass] Show audited 'true' or not 'false'
    # @param aux [String] Optionally specify a comma-separated list of supplemental data fields to return. Pass 'ath, atl, high24h, low24h, num_market_pairs, cmc_rank, date_added, max_supply, circulating_supply, total_supply, volume_7d, volume_30d, self_reported_circulating_supply, self_reported_market_cap' to include all auxiliary fields.
    # @param tags [String] If you want to see cryptocurrencies that can be mined, just type 'mineable'.
    # @param volume24h_range [String] Optionally specify a threshold 24 hour USD volume to filter results by. For example, '0~100000000000000000'
    # @param percent_change24h_range [String] Optionally specify a threshold 24 hour percent change to filter results by. For example, '0~100' or '-10~100'
    # @param circulating_supply_range [String] Optionally specify a threshold circulating supply to filter results by. For example, '0~100000000000000000'
    # @param price_range [String] Optionally specify a threshold USD price to filter results by. For example, '0~100000000000000000'
    # @param market_cap_range [String] Optionally specify a threshold market cap to filter results by. For example, '0~100000000000000000'
    # @return [Hash]
    def coins(**params)
      data = Coin.list(params)

      return yield data if block_given?

      JSON.parse(data)
    end

    # Returns an interval of historic market quotes for any cryptocurrency based on time and interval parameters.
    #
    # You can use one of the following intervals: 1D, 7D, 1M, 3M, 1Y, YTD, ALL
    #
    #   history = CoinmarketcapFree.coin_history(1, '1D')
    #
    # Also you can use this method like this:
    #
    #   history = CoinmarketcapFree.coin_history(1, '1668981600~1671659999') do |data|
    #       JSON.parse(data)
    #   end
    #
    # 'data' - Results of your query returned as an object map.
    # 'points' - Price range history
    # 'status' - Standardized status object for API calls.
    #
    # @param id [Integer] Cryptocurrency identifier from coinmarketcap. For example, Bitcoin has the number 1
    # @param range_time [String] Range time. For example, '1D', '7D', '1M', '3M', '1Y', 'YTD', 'ALL' or custom range '1668981600~1671659999'
    # @return [Hash]
    def coin_history(id, range_time)
      data = CoinHistory.custom_time(id, range_time)

      return yield data if block_given?

      JSON.parse(data)
    end

    # Generate URI image of a coin
    #
    #   logo = CoinmarketcapFree.coin_icon(1, 64)
    #
    # Result:
    #   "https://s2.coinmarketcap.com/static/img/coins/64x64/1.png"
    #
    # @param [Integer] id_coin Identify coin. For example, bitcoin has 1
    # @param [Integer] size Choose one size: 64, 128, 200
    # @return [String] Return URI from coinmarketcap
    def coin_icon(id_coin, size)
      Icon.generate_url(id_coin, size)
    end
  end
end