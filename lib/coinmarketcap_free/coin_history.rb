# frozen_string_literal: true

require_relative 'helper'

module CoinmarketcapFree
  # Returns an interval of historic market quotes for any cryptocurrency based on time and interval parameters.
  module CoinHistory
    URL_API = 'https://api.coinmarketcap.com/data-api/v3/cryptocurrency/detail/chart'
    private_constant :URL_API

    class << self
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
      # @return [String]
      def custom_time(id, range_time)
        uri = Helper.generate_uri_for_data(URL_API, { id: id, range: range_time })
        Helper.request_to_read_data(uri)
      end

      # Returns an interval of historic for the day
      #
      # @param [Integer] id Cryptocurrency identifier
      def interval_day(id)
        custom_time(id, '1D')
      end

      # Returns an interval of historic for the seven days
      #
      # @param [Integer] id Cryptocurrency identifier
      def interval_seven_days(id)
        custom_time(id, '7D')
      end

      # Returns an interval of historic for the one month
      #
      # @param [Integer] id Cryptocurrency identifier
      def interval_one_month(id)
        custom_time(id, '1M')
      end

      # Returns an interval of historic for the three months
      #
      # @param [Integer] id Cryptocurrency identifier
      def interval_three_months(id)
        custom_time(id, '3M')
      end

      # Returns an interval of historic for the one year
      #
      # @param [Integer] id Cryptocurrency identifier
      def interval_one_year(id)
        custom_time(id, '1Y')
      end

      # Returns an interval of historic for the current year
      #
      # @param [Integer] id Cryptocurrency identifier
      def interval_current_year(id)
        custom_time(id, 'YTD')
      end

      # Returns an interval of historic for the current year
      #
      # @param [Integer] id Cryptocurrency identifier
      def interval_all_time(id)
        custom_time(id, 'ALL')
      end
    end
  end
end
