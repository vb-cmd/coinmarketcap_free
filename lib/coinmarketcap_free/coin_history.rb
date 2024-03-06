require_relative 'helper'

module CoinmarketcapFree
  # Model for Cryptocurrency History
  class CoinHistory
    INTERVAL_TIME = {
      one_day: '1D',
      seven_days: '7D',
      one_month: '1M',
      three_months: '3M',
      one_year: '1Y',
      current_year: 'YTD',
      all: 'ALL'
    }.freeze

    attr_accessor :time,
                  :price,
                  :volume_24h,
                  :market_cap,
                  :totaly_supply

    def initialize(date, price, volume_24h, market_cap, totaly_supply)
      @time = date
      @price = price
      @volume_24h = volume_24h
      @market_cap = market_cap
      @totaly_supply = totaly_supply
    end

    class << self
      # Returns an interval of historic market quotes for any cryptocurrency based on time and interval parameters.
      #
      # You can use one of the following intervals: 1D, 7D, 1M, 3M, 1Y, YTD, ALL or custom range '1668981600~1671659999'
      # or call the method by its full name: one_day, seven_days, one_month, three_months, one_year, current_year, all
      #
      #   history = CoinmarketcapFree::CoinHistory.custom_time(id_coin, '1D')
      #
      # or
      #
      #   histories = CoinmarketcapFree::CoinHistory.one_day(id_coin)
      #   histories = CoinmarketcapFree::CoinHistory.seven_days(id_coin)
      #   histories = CoinmarketcapFree::CoinHistory.one_month(id_coin)
      #   histories = CoinmarketcapFree::CoinHistory.three_months(id_coin)
      #   histories = CoinmarketcapFree::CoinHistory.one_year(id_coin)
      #   histories = CoinmarketcapFree::CoinHistory.current_year(id_coin)
      #   histories = CoinmarketcapFree::CoinHistory.all(id_coin)
      #
      #
      # Result json:
      #
      #   {
      #     "data": {
      #         "points": {
      #             "1673192010": { # time in seconds
      #               "v": [
      #                     16953.771282696678, # price
      #                     7609543976.45, # volume 24h
      #                     326457581376.786557398500, # market cap
      #                     1,
      #                     19255750.00000000000000000000 # total supply
      #                 ],
      #                 "c": [
      #                     16953.771282696678, # price
      #                     7609543976.45, # volume 24h
      #                     326457581376.786557398500 # market cap
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
      #
      # 'data' - Results of your query returned as an object map.
      # 'points' - Price range history
      # 'status' - Standardized status object for API calls.
      #
      # @param id [Integer] Cryptocurrency identifier from coinmarketcap. For example, Bitcoin has the number 1
      # @param range_time [String] Range time. For example, '1D', '7D', '1M', '3M', '1Y', 'YTD', 'ALL' or custom range '1668981600~1671659999'
      # @return [Array<CoinmarketcapFree::CoinHistory] Return CoinHistory object
      def custom_time(id, range_time)
        json = Helper.get_cryptocurrency_histories({ id: id, range: range_time })

        json['data']['points'].map { |key, value| CoinHistory.convert_json(key, value['v']) }
      end

      # Create interval methods
      INTERVAL_TIME.each do |key, value|
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{key}(id)
            custom_time(id, '#{value}')
          end
        RUBY
      end

      # Convert json data to CoinHistory
      # @param utc_timestamp [Integer] Time in seconds
      # @param data [Array] Data
      # @return [CoinmarketcapFree::CoinHistory] Return CoinHistory object
      def convert_json(utc_timestamp, data)
        timestamp = utc_timestamp.is_a?(String) ? utc_timestamp.to_i : utc_timestamp

        CoinHistory.new(Time.at(timestamp), # convert time utc
                        data[0],  # price
                        data[1],  # volume 24h
                        data[2], # market cap
                        data[4]) # total supply
      end
    end
  end
end
