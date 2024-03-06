require_relative 'coinmarketcap_free/coin_history'
require_relative 'coinmarketcap_free/coin'
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
    # or in descending
    #
    #   list = CoinmarketcapFree.coins(limit: 100, start: 1, sort_type:'desc')
    #
    # Or sort by name with ascending:
    #
    #   list = CoinmarketcapFree.coins(limit: 100, start: 1, sort_type:'asc', sort_by: 'name')
    #
    # Convert cryptocurrency to USD:
    #
    #   list = CoinmarketcapFree.coins(limit: 100, start: 1, convert: 'USD')
    #
    # or together
    #
    #   list = CoinmarketcapFree.coins(limit: 100, start: 1, convert: 'USD,BTC,ETH')
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
    # @return [Array<CoinmarketcapFree::Coin>] Return CoinmarketcapFree::Coin object
    def coins(**params)
      Coin.list(**params)
    end

    # Returns an interval of historic market quotes for any cryptocurrency based on time and interval parameters.
    #
    # You can use one of the following intervals: 1D, 7D, 1M, 3M, 1Y, YTD, ALL or custom range like this '1668981600~1671659999'
    # or call the method by its full name: one_day, seven_days, one_month, three_months, one_year, current_year, all
    #
    #   history = CoinmarketcapFree::CoinHistory.custom_time(id_coin, '1D')
    #
    # OR
    #
    #   history = CoinmarketcapFree::CoinHistory.one_day(id_coin)
    #
    # @param id [Integer] Cryptocurrency identifier from coinmarketcap. For example, Bitcoin has the number 1
    # @param range_time [String] Range time. For example, '1D', '7D', '1M', '3M', '1Y', 'YTD', 'ALL' or custom range like this '1668981600~1671659999'
    # @return [Array<CoinmarketcapFree::CoinHistory] Return CoinHistory object
    def coin_histories(id, range_time)
      CoinHistory.custom_time(id, range_time)
    end
  end
end
