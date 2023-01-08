# frozen_string_literal: true

require 'coinmarketcap_free/helper'

module CoinmarketcapFree
  class BASE
    protected

    def request_to_read_data(url)
      response = Net::HTTP.get_response(url, {'Accept': '*/*'})

      raise HTTPBadResponse if response.code.match? /[45][0-9]{2}/

      response.read_body
    end

    def generate_uri_for_data
      raise NotImplementedError
    end

    public

    attr_reader :data
    def update
      begin
        url = generate_uri_for_data
        @data = request_to_read_data(url)
      rescue
        false
      else
        true
      end
    end
  end
end