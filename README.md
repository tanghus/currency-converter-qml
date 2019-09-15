![Icon](https://raw.githubusercontent.com/tanghus/currency-converter-qml/master/harbour-currencyconverter.png) Currency Converter for SailfishOS
=================================

Convert currencies using data from configurable currency rates providers.

Currency Converter per default uses [ExchangeRatesAPI.io](https://exchangeratesapi.io/)
that offers daily exchange rates for a limited set of currencies (currently 33) published by
the [European Central Bank](https://www.ecb.europa.eu/stats/policy_and_exchange_rates/euro_reference_exchange_rates/html/index.en.html).

With Currency Converter you can select different Exchange Rates Providers to get
faster updates, more options, and a wider set of currencies.
Most commercial providers also offers a free version, but with some caveats, as for
example not being able to request a base currency, with the result that each time you
request one new currency pair, all of them will be downloaded.
So unless you *really* need to, I strongly recommend sticking with the default.

For the average traveller or businessperson the default selection should be more than enough.

Currency Converter keeps an internal list of registered, legal currencies, which is
used together with a list of the currencies offered by the chosen provider. The latter
is refreshed when the app is loaded, except if there is no network connection, or if
you have explicitly chosen to work offline.
For this Currency Converter uses an effective caching mechanism. Based on the update interval
of the current provider, and timestamps on each currency pair (e.g. EUR/USD) it only fetches
online rates when needed - or, again, when explicitly told to.

You can choose to force refresh for one pair or all the rates for the currently selected "From" currency.

The list of available currencies is generated from the 'From Currency' you had selected when
the app is loaded or when you chose to refresh the cache.
This means, that if you change the 'From Currency' right after you go offline, there is
no guarantee that a list of the available currencies can be generated from the cache.
To remedy this, change to the 'From Currency' you need to be cached, and select "Refresh cache
for <Current Currency>".
In theory you can cache the currencies you need, and use the app offline for as long as you trust
the cached exchange rate.


