# frozen_string_literal: true

module CoinmarketcapFree
  class Coin
    # Generate a URI icon of a coin
    #
    #   coin = CoinmarketcapFree::Coin.list.first
    #   logo = coin.get_icon(64) # size 64x64
    #
    # Result:
    #
    #   "https://s2.coinmarketcap.com/static/img/coins/64x64/1.png"
    #
    # @param [Integer] id_coin Identify coin. For example, bitcoin has 1
    # @param [Integer] size Choose one size: 64, 128, 200
    # @return [String] Return URI from coinmarketcap
    def get_icon(size)
      size_x_size = case size
                    when 64, 128, 200
                      "#{size}x#{size}"
                    else
                      raise ArgumentError, "Can't find this value: #{size}"
                    end
      "https://s2.coinmarketcap.com/static/img/coins/#{size_x_size}/#{@id}.png"
    end
  end
end
