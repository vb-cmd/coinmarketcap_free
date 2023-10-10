# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'openssl'
require 'json'

module CoinmarketcapFree
  BASE_URI = 'https://api.coinmarketcap.com/data-api/'
  VERSION_API = 'v3'

  # Helper module for CoinmarketcapFree
  module Helper
    class << self
      def http_get(url, data = nil)
        uri = URI(generate_url(url, data))
        Net::HTTP.get(uri)
      end

      private

      def generate_url(url, data = nil)
        "#{url}#{data ? '?' : ''}#{data.map { |key, value| "#{key}=#{value}" }.join('&')}"
      end
    end
  end
end
