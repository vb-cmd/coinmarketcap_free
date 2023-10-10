# frozen_string_literal: true

require_relative 'helper'

module CoinmarketcapFree
  # All history cryptocurrency and their prices.
  module CoinHistory
    URI_API = "#{BASE_URI}#{VERSION_API}/cryptocurrency/detail/chart"

    INTERVAL_TIME = {
      one_day: '1D',
      seven_days: '7D',
      one_month: '1M',
      three_months: '3M',
      one_year: '1Y',
      current_year: 'YTD',
      all: 'ALL'
    }.freeze

    class << self
      # Returns an interval of historic market quotes for any cryptocurrency based on time and interval parameters.
      #
      # You can use one of the following intervals: 1D, 7D, 1M, 3M, 1Y, YTD, ALL
      #
      #   history = CoinmarketcapFree::CoinHistory.custom_time(1, '1D')
      #
      # Also you can use this method like this:
      #
      #   history = CoinmarketcapFree::CoinHistory.interval_one_day(1)
      #
      # Just add a prefix to the method: interval_(one_day, seven_days, one_month, three_months, one_year, current_year, all)
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
      #
      # 'data' - Results of your query returned as an object map.
      # 'points' - Price range history
      # 'status' - Standardized status object for API calls.
      #
      # @param id [Integer] Cryptocurrency identifier from coinmarketcap. For example, Bitcoin has the number 1
      # @param range_time [String] Range time. For example, '1D', '7D', '1M', '3M', '1Y', 'YTD', 'ALL' or custom range '1668981600~1671659999'
      # @return [String]
      def custom_time(id, range_time)
        Helper.http_get(URI_API, { id: id, range: range_time })
      end

      # Creating interval methods
      INTERVAL_TIME.each do |key, value|
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def interval_#{key}
            custom_time(id, '#{value}')
          end
        RUBY
      end
    end
  end
end
