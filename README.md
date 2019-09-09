![Icon](https://raw.githubusercontent.com/tanghus/currency-converter-qml/master/harbour-currencyconverter.png) Currency Converter for SailfishOS
=================================

Convert currencies using data configurable currency rates providers.

Currency Converter per default uses [https://ExchangeRatesAPI.io](https://exchangeratesapi.io/)
that offers daily exchange rates for a limited set of currencies (currently 33) published by
the [European Central Bank](https://www.ecb.europa.eu/stats/policy_and_exchange_rates/euro_reference_exchange_rates/html/index.en.html).

With Currency Converter you can select different Exchange Rates Providers to get
faster updates, more options, and a wider set of currencies.
Most commercial providers also offers a free version, but with some caveats, as for
example not being able to request a base currency, with the result that each time you
request one new currency pair, all of them will be downloaded.
So unless you *really* need to, I strongly recommend sticking with the default.

For the average traveller or businessperson the default selection should be more than enough.

If you - like me - have a combination of lousy math skills and bad short-time memory,
the quick switch of currencies comes in handy ;)

Currency Converter keeps an internal list of registered, legal currencies, which is
used together with a list of the currencies offered by the chosen provider. The latter
is refreshed when the app is loaded, except if there is no network connection, or if
you have explicitly chosen to work offline.
For this Currency Converter uses an effective caching mechanism. Based on the update interval
of the current provider, and timestamps on each currency pair (e.g. EUR/USD) it only fetches
online rates when needed - or, again, when explicitly told to.

You can chose to delete the cache for one pair or the entire cache.

**Be aware**, that if you delete the entire cache, the list of available currencies will
have to be downloaded once again. It's not a very big payload, though, but if you're offline
it could be problematic.

**Also be aware**, that the list of available currencies is dependant on which 'From Currency'
you had selected selected when the app is loaded.
That means, that if you change the 'From Currency' right after you go offline, there is
no guarantee that a list of the available currencies can be generated from the cache.
To remedy this, change to the 'From Currency' you need to be cached, close the app, and
launch it again. I'll put an option in to load them on demand if I get that request.


