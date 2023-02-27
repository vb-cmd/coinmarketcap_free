# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'openssl'
require 'json'

module CoinmarketcapFree
  # Helper module for CoinmarketcapFree
  module Helper
    class << self
      def request_to_read_data(uri_string)
        uri = URI(uri_string)
        Net::HTTP.get(uri)
      end

      def generate_uri_for_data(url, data)
        "#{url}?#{data.map { |key, value| "#{key}=#{value}" }.join('&')}"
      end
    end
  end
end
