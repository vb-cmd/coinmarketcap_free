module CoinmarketcapFree
  class Coin
    FullName = Struct.new('FullName',
                          :name,
                          :symbol,
                          :slug) do
                            def self.convert_json(data)
                              FullName.new(data['name'],
                                           data['symbol'],
                                           data['slug'])
                            end
                          end

    Supply = Struct.new("Supply",
                        :circulating,
                        :total,
                        :maximum) do
                          def self.convert_json(data)
                            Supply.new(data['circulatingSupply'],
                                       data['totalSupply'],
                                       data['maxSupply'])
                          end
                        end

    State = Struct.new("State",
                       :last_updated,
                       :added) do
                         def self.convert_json(data)
                           State.new(DateTime.parse(data['lastUpdated']),
                                     DateTime.parse(data['dateAdded']))
                         end
                       end

    Quotes = Struct.new("Quotes",
                        :name,
                        :price,
                        :volume_24h,
                        :market_cap,
                        :percent_change_1h,
                        :percent_change_24h,
                        :percent_change_7d,
                        :percent_change_30d,
                        :percent_change_60d,
                        :percent_change_90d,
                        :percent_change_1y,
                        :last_updated) do
                          def self.convert_json(data)
                            Quotes.new(data['name'],
                                       data['price'],
                                       data['volume24h'],
                                       data['marketCap'],
                                       data['percentChange1h'],
                                       data['percentChange24h'],
                                       data['percentChange7d'],
                                       data['percentChange30d'],
                                       data['percentChange60d'],
                                       data['percentChange90d'],
                                       data['percentChange1y'],
                                       DateTime.parse(data['lastUpdated']))
                          end
                        end
  end
end
