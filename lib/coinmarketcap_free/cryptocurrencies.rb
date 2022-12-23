# frozen_string_literal: true

require 'coinmarketcap_free/helper'
require 'coinmarketcap_free/base'

module CoinmarketcapFree
  class Cryptocurrencies < CoinmarketcapFree::BASE
    SORT_BY = %w[market_cap rank]
    SORT_TYPE = %w[desc asc]
    CONVERT = %w[USD BTC ETH]
    CRYPTO_TYPE = %w[all coins tokens]
    TAG_TYPE = 'all'
    AUX = %w[ath atl high24h low24h num_market_pairs cmc_rank date_added max_supply circulating_supply total_supply volume_7d volume_30d self_reported_circulating_supply self_reported_market_cap]
    TAGS = 'mineable'

    URL_API = 'https://api.coinmarketcap.com/data-api/v3/cryptocurrency/listing'.freeze
    private_constant :URL_API

    # Get a list of information about cryptocurrencies
    #    start: Integer. Which one to start with.
    #    limit: Integer. How many cryptocurrencies do you want to take.
    #    sort_by: String. Select market cap or rank | SORT_BY
    #    sort_type: String. Descending and ascending | SORT_TYPE
    #    convert: String. Select cryptocurrencies to exchange, for example 'USD,BTC,ETH' or 'USD' | CONVERT
    #    crypto_type: String. Select all, only coins or tokens only | CRYPTO_TYPE
    #    tag_type: String. Select all | TAG_TYPE
    #    audited: Boolean. false or true
    #    aux: String. Select more information about cryptocurrencies | AUX
    #    tags: String. Usually choose 'mineable' | TAGS
    #
    # Range from and to, for example '100~1000'
    #    volume_24h_range: String.
    #    percent_change_24h_range: String.
    #    circulating_supply_range: String.
    #    price_range: String.
    #    market_cap_range: String.
    def initialize(**options)
      @limit = options[:limit]
      @start = options[:start]
      @sort_by = options[:sort_by] # SORT_BY
      @sort_type = options[:sort_type] # SORT_TYPE
      @convert = options[:convert] # CONVERT
      @crypto_type = options[:crypto_type] # CRYPTO_TYPE
      @tag_type = options[:tag_type] # TAG_TYPE
      @audited = options[:audited] # boolean
      @aux = options[:aux] # AUX
      @tags = options[:tags] # TAGS
      # range, for example '1~100' or '-10~100'
      @volume_24h_range = options[:volume_24h_range]
      @percent_change_24h_range = options[:percent_change_24h_range]
      @circulating_supply_range = options[:circulating_supply_range]
      @price_range = options[:price_range]
      @market_cap_range = options[:market_cap_range]
    end

    attr_accessor :limit,
                  :start,
                  :sort_by,
                  :sort_type,
                  :convert,
                  :crypto_type,
                  :tag_type,
                  :audited,
                  :aux,
                  :tags,
                  :volume_24h_range,
                  :percent_change_24h_range,
                  :circulating_supply_range,
                  :price_range,
                  :market_cap_range

    def generate_uri_for_data
      options = self.instance_variables.filter_map do |name_var|
        "#{name_var.to_s.delete('@')}=#{self.instance_variable_get(name_var)}" unless self.instance_variable_get(name_var).nil?
      end

      query = "#{URL_API}?#{options.join('&')}"
      URI(query)
    end
  end
end