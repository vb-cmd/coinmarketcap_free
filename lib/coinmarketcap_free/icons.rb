# frozen_string_literal: true

module CoinmarketcapFree
  # Get coin logo from coinmarketcap.com
  module Icons
    class << self
      # Get coin logo URI from coinmarketcap
      #
      #   logo = CoinmarketcapFree.img_coin(1, 64)
      #
      # Result:
      #   "https://s2.coinmarketcap.com/static/img/coins/64x64/1.png"
      #
      # @param [Integer] id_coin Identify coin. For example, bitcoin has 1
      # @param [Integer] size Choose one size: 64, 128, 200
      # @return [String] Return URI from coinmarketcap
      def get_coin_logo_uri(id_coin, size)
        size_x_size = case size
                      when 64, 128, 200
                        "#{size}x#{size}"
                      else
                        raise ArgumentError, "Can't find this value: #{size}"
                      end
        "https://s2.coinmarketcap.com/static/img/coins/#{size_x_size}/#{id_coin}.png"
      end
    end
  end
end
