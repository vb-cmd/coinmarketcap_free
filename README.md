# CoinmarketcapFree

Cryptocurrency information from the Coinmarketcap site without a key.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add coinmarketcap_free

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install coinmarketcap_free

## How to use?

``` Ruby
list = CoinmarketcapFree::Coin.list
```

or short

``` Ruby
list = CoinmarketcapFree::coins
```

Result:
``` JSON
{
    "data": {
        "cryptoCurrencyList": [
         {
            "id": 1,
            "name": "Bitcoin",
            "symbol": "BTC",
            "slug": "bitcoin",
            "tags": [
              "mineable",
              "pow",
              "sha-256",
              "store-of-value",
              "state-channel",
              "coinbase-ventures-portfolio",
              "three-arrows-capital-portfolio",
              "polychain-capital-portfolio",
              "binance-labs-portfolio",
              "blockchain-capital-portfolio",
              "boostvc-portfolio",
              "cms-holdings-portfolio",
              "dcg-portfolio",
              "dragonfly-capital-portfolio",
              "electric-capital-portfolio",
              "fabric-ventures-portfolio",
              "framework-ventures-portfolio",
              "galaxy-digital-portfolio",
              "huobi-capital-portfolio",
              "alameda-research-portfolio",
              "a16z-portfolio",
              "1confirmation-portfolio",
              "winklevoss-capital-portfolio",
              "usv-portfolio",
              "placeholder-ventures-portfolio",
              "pantera-capital-portfolio",
              "multicoin-capital-portfolio",
              "paradigm-portfolio"
            ],
            "cmcRank": 1,
            "marketPairCount": 9922,
            "circulatingSupply": 19256812.0,
            "selfReportedCirculatingSupply": 0,
            "totalSupply": 19256812.0,
            "maxSupply": 21000000.0,
            "isActive": 1,
            "lastUpdated": "2023-01-09T08:25:00.000Z",
            "dateAdded": "2013-04-28T00:00:00.000Z",
            "quotes": [
              {
                "name": "USD",
                "price": 17209.447088639048,
                "volume24h": 13652714044.770432,
                "marketCap": 331399087209.8695,
                "percentChange1h": -0.00692023,
                "percentChange24h": 1.50954046,
                "percentChange7d": 2.78181713,
                "lastUpdated": "2023-01-09T08:25:00.000Z",
                "percentChange30d": 0.30441134,
                "percentChange60d": 3.89490715,
                "percentChange90d": -9.99714982,
                "fullyDilluttedMarketCap": 361398388861.42,
                "marketCapByTotalSupply": 331399087209.8695,
                "dominance": 39.0828,
                "turnover": 0.0411972,
                "ytdPriceChangePercentage": 3.515
              }
            ],
            "isAudited": false
    }
        ...
        ],
        "totalCount": "8857"
        },
    "status": {
        "timestamp": "2023-01-08T15:33:30.271Z",
        "error_code": "0",
        "error_message": "SUCCESS",
        "elapsed": "2",
        "credit_count": 0
    }
}
```

If you want to sort in ascending, just write parameter:

``` Ruby
list = CoinmarketcapFree::Coin.list(limit: 100, start: 1, sort_type:'asc')
```

You can also adding sort by:

``` Ruby
list = CoinmarketcapFree::Coin.list(limit: 100, start: 1, sort_type:'asc', sort_by: 'name')
```

Convert all cryptocurrencies to USD,BTC,ETH:

``` Ruby
list = CoinmarketcapFree::Coin.list(limit: 100, 
                                         start: 1, 
                                         sort_type:'asc', 
                                         sort_by: 'name', 
                                         convert: 'USD,BTC,ETH')
```


Parameters for CoinmarketcapFree::Coin.list:

| Name                          | Type     | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                        | Examples                                     |
|:------------------------------|:---------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------|
| ```limit:```                  | Integer. | Optionally specify the number of results to return. Use this parameter and the "start" parameter to determine your own pagination size.                                                                                                                                                                                                                                                                                                                            ||
| ```start:```                  | Integer. | Optionally offset the start (1-based index) of the paginated list of items to return.                                                                                                                                                                                                                                                                                                                                                                              ||
| ```sort_by:```                 | String.  | Default: ```market_cap```. (```rank```, ```name```, ```symbol```, ```date_added```, ```market_cap```, ```market_cap_strict```, ```price```, ```circulating_supply```, ```total_supply```, ```max_supply```, ```num_market_pairs```, ```volume_24h```, ```percent_change_1h```, ```percent_change_24h```, ```percent_change_7d```, ```market_cap_by_total_supply_strict```, ```volume_7d```, ```volume_30d```). What field to sort the list of cryptocurrencies by. ||
| ```sort_type:```               | String.  | Default: ```desc```. (```asc``` or ```desc```). The direction in which to order cryptocurrencies against the specified sort.                                                                                                                                                                                                                                                                                                                                       ||
| ```convert:```                | String.  | Default: ```USD,BTC,ETH``` . Select cryptocurrencies to exchange (```AUD```, ```BRL```, ```CAD```, ```CHF```, ```CLP```, ```CNY```, ```CZK```, ```DKK```, ```EUR```, ```GBP```, ```HKD```, ```HUF```, ```IDR```, ```ILS```, ```INR```, ```JPY```, ```KRW```, ```MXN```, ```MYR```, ```NOK```, ```NZD```, ```PHP```, ```PKR```, ```PLN```, ```RUB```, ```SEK```, ```SGD```, ```THB```, ```TRY```, ```TWD```, ```ZAR```).                                            | ```USD``` or ```USD,BTC,ETH```               |
| ```crypto_type:```             | String.  | Default: ```all```. (```all```, ```coins```, ```tokens```). The type of cryptocurrency to include.                                                                                                                                                                                                                                                                                                                                                                 ||
| ```tag_type:```                | String.  | Default: ```all```. (```all```, ```defi```, ```filesharing```). The tag of cryptocurrency to include.                                                                                                                                                                                                                                                                                                                                                              ||
| ```audited:```                | Boolean. | Show audited (true) or not (false)                                                                                                                                                                                                                                                                                                                                                                                                                                 ||
| ```aux:```                    | String.  | Optionally specify a comma-separated list of supplemental data fields to return. Pass ```ath, atl, high24h, low24h, num_market_pairs, cmc_rank, date_added, max_supply, circulating_supply, total_supply, volume_7d, volume_30d, self_reported_circulating_supply, self_reported_market_cap``` to include all auxiliary fields.                                                                                                                                    | ```ath``` or ```ath, atl, high24h, low24h``` |
| ```tags:```                   | string.  | If you want to see cryptocurrencies that can be mined, just type ```mineable```.                                                                                                                                                                                                                                                                                                                                                                                   ||
| ```volume24h_range:```         | String.  | Optionally specify a threshold 24 hour USD volume to filter results by.                                                                                                                                                                                                                                                                                                                                                                                            | ```0~100000000000000000```                   |
| ```percent_change24h_range:```  | String.  | Optionally specify a threshold 24 hour percent change to filter results by.                                                                                                                                                                                                                                                                                                                                                                                        | ```0~100``` or ```-10~100```                 |
| ```circulating_supply_range:``` | String.  | Optionally specify a threshold circulating supply to filter results by.                                                                                                                                                                                                                                                                                                                                                                                            | ```0~100000000000000000```                   |
| ```price_range:```             | String.  | Optionally specify a threshold USD price to filter results by.                                                                                                                                                                                                                                                                                                                                                                                                     | ```0~100000000000000000```                   |
| ```market_cap_range:```         | String.  | Optionally specify a threshold market cap to filter results by.                                                                                                                                                                                                                                                                                                                                                                                                    | ```0~100000000000000000```                   |

### Returns an interval of historic market quotes:

``` Ruby
coin = CoinmarketcapFree::CoinHistory.custom_time(1, '1D')
coin = CoinmarketcapFree::CoinHistory.custom_time(1, '1668981600~1671659999')
```

or short

``` Ruby
coin = CoinmarketcapFree.coin_history(1, '1D')
coin = CoinmarketcapFree.coin_history(1, '1668981600~1671659999')
```

or

``` Ruby
coin = CoinmarketcapFree::CoinHistory.interval_day(1)
coin = CoinmarketcapFree::CoinHistory.interval_seven_days(1)
coin = CoinmarketcapFree::CoinHistory.interval_one_month(1)
coin = CoinmarketcapFree::CoinHistory.interval_three_months(1)
coin = CoinmarketcapFree::CoinHistory.interval_one_year(1)
coin = CoinmarketcapFree::CoinHistory.interval_current_year(1)
coin = CoinmarketcapFree::CoinHistory.interval_all_time(1)
```

Result:
``` JSON
 {
     "data": {
         "points": {
             "1673192010": {
               "v": [
                     16953.771282696678,
                     7609543976.45,
                     326457581376.786557398500,
                     1,
                     19255750.00000000000000000000
                 ],
                 "c": [
                     16953.771282696678,
                     7609543976.45,
                     326457581376.786557398500
                 ]
             },
           ...
         }
     },
     "status": {
         "timestamp": "2023-01-08T15:33:30.271Z",
         "error_code": "0",
         "error_message": "SUCCESS",
         "elapsed": "2",
         "credit_count": 0
     }
 }
 
```

Parameters for CoinmarketcapFree::CoinHistory.custom_time:

| Name             | Type     | Description                                   | Examples                                                                                                           |
|:-----------------|:---------|:----------------------------------------------|:-------------------------------------------------------------------------------------------------------------------|
| ```id```         | Integer. | Cryptocurrency identifier from coinmarketcap. | Bitcoin has the number 1                                                                                           |
| ```range_time``` | String.  | Range time.                                   | ```1D```, ```7D```, ```1M```, ```3M```, ```1Y```, ```YTD```, ```ALL``` or custom range ```1668981600~1671659999``` |

### Generation a link to access the picture:

``` Ruby
logo_coin_url = CoinmarketcapFree::Icon.generate_url(1, 64)
```

``` Ruby
"https://s2.coinmarketcap.com/static/img/coins/64x64/1.png"
```

| Name             | Type     | Description                                   | Examples                                                                                                           |
|:-----------------|:---------|:----------------------------------------------|:-------------------------------------------------------------------------------------------------------------------|
| ```id```         | Integer. | Cryptocurrency identifier from coinmarketcap. | Bitcoin has the number 1                                                                                           |
| ```size``` | Integer.  | Choose one size: 64, 128, 200.                                 | If choose 64, it means 64x64 |


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cosmic-1/coinmarketcap_free.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
