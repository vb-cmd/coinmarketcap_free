# frozen_string_literal: true

# Get data from Coinmarketcap API without requiring an API key.
module CoinmarketcapFree
  MAJOR = 1
  MINOR = 0
  PATCH = 1

  private_constant :MAJOR, :MINOR, :PATCH

  VERSION = "#{MAJOR}.#{MINOR}.#{PATCH}"
end
