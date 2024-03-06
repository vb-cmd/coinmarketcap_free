module CoinmarketcapFree
  class Coin
    # Create all methods for each time interval
    CoinHistory::INTERVAL_TIME.each do |key, value|
      class_eval("def #{key}; histories('#{value}'); end", __FILE__, __LINE__)
    end

    # Get the full history of cryptocurrencies and their prices.
    #
    #     coin = CoinmarketcapFree::Coin.list.first
    #     histories = coin.histories('1D')
    #
    # or
    #
    #     histories = coin.one_day
    #     histories = coin.seven_days
    #     histories = coin.one_month
    #     histories = coin.three_months
    #     histories = coin.one_year
    #     histories = coin.current_year
    #     histories = coin.all
    #
    # @param interval [String] Select time interval. ('1D', '7D', '1M', '3M', '1Y', 'YTD', 'ALL' or custom '1668981600~1671659999')
    # @return [Array<CoinmarketcapFree::CoinHistory>] Return CoinHistory object
    def histories(interval)
      CoinHistory.custom_time(@id, interval)
    end
  end
end
