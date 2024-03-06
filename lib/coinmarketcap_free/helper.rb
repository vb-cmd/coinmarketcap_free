require 'uri'
require 'net/http'
require 'openssl'
require 'json'
require 'date'

module CoinmarketcapFree
  # Helper module
  module Helper
    BASE_URI = 'https://api.coinmarketcap.com/data-api/'
    VERSION_API = 'v3'

    URI_API_CRYPTOCURRENCIES = "#{BASE_URI}#{VERSION_API}/cryptocurrency/listing"
    URI_API_CRYPTOCURRENCY_HISTORIES = "#{BASE_URI}#{VERSION_API}/cryptocurrency/detail/chart"

    class << self
      # Get cryptocurrency of histories
      # @param data [Hash] Parameters for Coinmarketcap API
      # @return [Hash] Return coin histories
      def get_cryptocurrency_histories(data)
        str = http_get(URI_API_CRYPTOCURRENCY_HISTORIES, data)
        JSON.parse(str)
      end

      # Get cryptocurrencies
      # @param data [Hash] Parameters for Coinmarketcap API
      # @return [Hash] Return cryptocurrencies
      def get_cryptocarencies(data)
        str = http_get(URI_API_CRYPTOCURRENCIES, data)
        JSON.parse(str)
      end

      private

      def http_get(url, data = nil)
        uri = URI(generate_url(url, data))
        Net::HTTP.get(uri)
      end

      def generate_url(url, data = nil)
        "#{url}#{data ? '?' : ''}#{data.map { |key, value| "#{key}=#{value}" }.join('&')}"
      end
    end
  end
end
