# frozen_string_literal: true

require 'coinmarketcap_free/helper'
require 'coinmarketcap_free/base'

module CoinmarketcapFree
  # Returns an interval of historic market quotes for any cryptocurrency based on time and interval parameters.
  #
  # For example, result json:
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
  class Coin < BASE
    URL_API = 'https://api.coinmarketcap.com/data-api/v3/cryptocurrency/detail/chart'.freeze
    private_constant :URL_API

    attr_accessor :id,
                  :range_time

    # @param id [Integer] Cryptocurrency identifier from coinmarketcap. For example, Bitcoin has the number 1
    # @param range_time [String] Range time. For example, '1D', '7D', '1M', '3M', '1Y', 'YTD', 'ALL' or custom range '1668981600~1671659999'
    def initialize(id = 1, range_time = '1D')
      @id = id
      @range_time = range_time
    end

    private
    def generate_uri_for_data
      query = "#{URL_API}?id=#{id}&range=#{range_time}"
      URI(query)
    end
  end
end
