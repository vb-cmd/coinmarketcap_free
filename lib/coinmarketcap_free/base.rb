# frozen_string_literal: true

require 'coinmarketcap_free/helper'

module CoinmarketcapFree
  class BASE
    protected

    def request_to_read_data(url)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(url)
      request["Accept"] = '*/*'

      response = http.request(request)

      response.read_body
    end

    def generate_uri_for_data
      raise NotImplementedError
    end

    public

    def get_json
      url = generate_uri_for_data
      data = request_to_read_data(url)
      JSON.parse data
    end
  end
end