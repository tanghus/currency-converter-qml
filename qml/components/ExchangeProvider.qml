/*
  Copyright (C) 2019 Thomas Tanghus
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.6
import "."

Item {
    id: provider
    property string name: 'Generic Exchange Rate Provider'
    property string rateURL: ''
    property string availableURL: ''
    property string url: rateURL
    property bool _availableTriggered: false
    // Holds the Cache component.
    property var cache
    // The update interval the provider supports in minutes.
    // www.exchangerate-api.com - daily
    // api.openrates.io (similar to fixer.io free)
    // For currencystack.io it's hourly or 10 minutes.
    // For exchangeratesapi.com it's daily.
    // For Fixer.io/currencylayer.com it's daily, hourly, 10 minutes, 60 seconds.
    property int updateInterval: 24*60*60 // 24 hours.

    property var updateWeekdays: [0,1,2,3,4,5,6]

    signal rateReceived(var pair)
    signal availableReceived(var availableCurrencies)
    signal error(string error, string message)

    Requester {
        id: rateFetcher
        url: provider.url
        onMessage: {
            // This handler receives responses from request on either
            // one rate, e.g. EUR/USD, or for all available currencies
            // from the current provider. It uses the 'requestType'
            // argument to determine how to parse the response
            // The results are either from the cache or online
            // TODO: This method should really be split up.
            //console.log('ExchangeProvider.rateFetcher.onMessage:', JSON.stringify(messageObject).substring(0, 50))
            var result = messageObject.result
            var request = messageObject.request
            var requestType = request.args.requestType
            console.log('ExchangeProvider.rateFetcher.onMessage. status:', messageObject.status)
            console.log('ExchangeProvider.rateFetcher.onMessage. requestType:', requestType)
            console.log('ExchangeProvider.rateFetcher.onMessage. request:', JSON.stringify(request))
            //console.log('ExchangeProvider.rateFetcher.onMessage. result:', JSON.stringify(result))

            if(messageObject.status !== 'success') {
                if(messageObject.status === 'error') {
                    provider.error(messageObject.error, messageObject.message)
                    console.warn(messageObject.error, messageObject.message)
                } else {
                    provider.error(qsTr('Error'), JSON.stringify(messageObject))
                    console.warn(JSON.stringify(messageObject))
                }
                return
            }

            if(request && result ) {
                var str
                if(!requestType) {
                    str = qsTr('No "requestType" set in request. Use "rate" or "available"')
                    console.error(str)
                    provider.error(qsTr('Error'), str)
                } else {
                    var _data
                    if(requestType === 'rate') {
                        // 'parseRateResponse' must be implemented by subclasses.
                        _data = provider.parseRateResponse(request, result)
                        console.log('ExchangeProvider.rateFetcher. RATE:', JSON.stringify(_data))
                        cache.setRate(_data.from, _data.to, _data.rate, _data.date)
                        // Send signal received
                        provider.rateReceived(Currencies.createPair(_data))
                    } else if(messageObject.request.args.requestType === 'available') {
                        console.log('ExchangeProvider.rateFetcher. AVAILABLE:',
                                    JSON.stringify(result).substring(0, 200))
                        // 'parseAvailableResponse' must be implemented by subclasses.
                        _data = provider.parseAvailableResponse(request, result)
                        // Send signal received
                        provider.availableReceived(_data)
                        // Save to cache
                        for(var currency in _data) {
                            cache.setRate(_data[currency].from, _data[currency].to,
                                          _data[currency].rate, _data[currency].date)
                        }
                    } else {
                        str = qsTr('Request type" %1 is not known. Use "rate" or "available"')
                            .arg(requestType)
                        console.error(str)
                        provider.error(qsTr('Error'), str)
                    }
                }
            } else {
                console.log('FALLTHRU!!!!')
                console.trace()
            }
        }
    }

    // Fetch a list of available currencies either from cache or from
    // the current provider.
    function getAvailable(base, force) {
        var response, doUpdate = false, reasons = []

        rateFetcher.url = availableURL
        console.log('ExchangeProvider.getAvailable. Fetching available from base "' + base + '". Work offline?', workOffline, 'is online?', isOnline)

        // Double triggered?
        if(_availableTriggered) {
            console.error('ExchangeProvider.getAvailable triggered twice')
        } else {
            console.trace()
            _availableTriggered = true
        }

        // Try to get it from the cache
        if(force) {
            console.log('ExchangeProvider.getAvailable. force update of', base)
            doUpdate = true
        } else {
            cache.getAvailable(base, function(response) {
                if(response.status !== 'success') {
                    provider.error(qsTr('Error'), response.message)
                    reasons.push(response.message)
                    console.error(response.message)
                    console.trace()
                    doUpdate = true
                } else if(response.result.length <= 0) {
                    console.log('ExchangeProvider.getAvailable. ', base, 'not cached',
                                JSON.stringify(response))
                    doUpdate = true
                    reasons.push(qsTr('Available Exchange Rates are not cached yet'))
                } else {
                    console.log('ExchangeProvider.cache.getAvailable. Length:', response.result.length)
                    //console.log('ExchangeProvider.cache.getAvailable. result:',
                    //            JSON.stringify(response.result))
                    var result = response.result
                    var rates = {}
                    for(var i = 0; i < result.length; i++) {
                        var code = result[i].code
                        rates[code] = parseFloat(result[i].rate)
                    }
                    console.log('ExchangeProvider.getAvailable. Fetched "' + base + '" OFFLINE')
                    doUpdate = false
                    // Send signal received
                    provider.availableReceived(rates)
                }
            })
        }

        if(doUpdate) {
            if(Env.isOnline) {
                if(!workOffline) {
                    console.log('ExchangeProvider.getAvailable. Fetching "' + base + '" ONLINE')
                    rateFetcher.request( {'from': fromCode, 'requestType': 'available'} )
                } else {
                    reasons.push(qsTr('You have chosen to work offline'))
                    console.log('ExchangeProvider.getAvailable() NOT ONLINE!!', reasons.join('. '))
                    provider.error(qsTr('Error'), reasons.join('. '))
                }
            } else {
                if(workOffline) {
                    reasons.push(qsTr('You have chosen to work offline'))
                    console.log('ExchangeProvider.getAvailable() NOT ONLINE!!', reasons.join('. '))
                    provider.error(qsTr('Error'), reasons.join('. '))
                } else {
                    // Trigger network dialog. This is coupled strongly with App :/
                    // TODO: Add signal to request network
                    networkIFace.openConnection()
                }
            }
        }
    }

    function getRate(fromCode, toCode) { // force?
        // FIXME: Using global var 'workOffline' :/
        var doUpdate = false, isCached = false, expired = false, reasons = []

        rateFetcher.url = rateURL
        console.log('ExchangeProvider.getRate(', fromCode, toCode, ')')
        // Try to get it from the cache
        cache.getRate(fromCode, toCode, function(response) {
            console.log('ExchangeProvider.getRate()', JSON.stringify(response))
            if(response && response.status === 'success') {
                if(response.result > 0) { // && response.result.length > 0) {
                    isCached = true
                    var now, then

                    now = new Date()
                    then = new Date(response.result[0].date)

                    // TODO: This cache validation needs cleanup if possible.
                    // Move to new method
                    console.log('getRate:',
                                Math.round(now.getTime()/1000), '-',
                                Math.round(then.getTime()/1000), '>', updateInterval)
                    // Is it older than a updateInterval'?
                    if(now.getTime() - then.getTime() > updateInterval*1000) {
                        // Apparently so
                        expired = true
                        console.log('getRate: expired.', expired)
                        reasons.push(qsTr('The currency pair %1 => %2 has expired in cache'))
                    } else {
                        // It's not expired. Is it a day where the rates are updated?
                        console.log('Weekday?', JSON.stringify(updateWeekdays), now.getDay())
                        if (updateWeekdays.indexOf(now.getDay()) === -1) {
                            expired = true
                            reasons.push(qsTr('The currency pair %1 => %2 has expired in cache'))
                            // Is it set to work offline?
                            // NOTE: workOffline shouldn't be used here
                            console.log('getRate: expired.', expired)
                            console.log('getRate: weekday. workOffline?', workOffline, 'Update?',  doUpdate)
                        }
                    }
                }

                if(!isCached || expired) {
                    doUpdate = true
                }
                doUpdate = workOffline ? false : true

                // If there's no need to fetch a fresh rate, just use the cached one
                if(!doUpdate) {
                    var pair = Currencies.createPair(response.result[0])
                    provider.rateReceived(pair)
                }
            } else {
                isCached = false
                doUpdate = true
            }
        })

        if(doUpdate) {
            reasons.push(qsTr("You have chosen to work offline, but the currency combination %1 => %2 is not in the cache.").arg(fromCode).arg(toCode))
            if(Env.isOnline) {
                if(workOffline) {
                    provider.error(qsTr('Error'), reasons.join('. '))
                } else {
                    rateFetcher.request( {'from': fromCode, 'to': toCode, 'requestType': 'rate'} )
                }
            } else {
                if(workOffline) {
                    provider.error(qsTr('Error'), reasons.join('. '))
                } else {
                    // TODO: Add signal to request network
                    networkIFace.openConnection()
                }
            }
        }
    }

    // Parse response from rateFetcher and return an object: {from, to, rate, date}
    // This MUST be implemented by subclasses
    function parseRateResponse(request, response) {
        // This should never get called
        console.error('ExchangeProvider.parseRateResponse. This should never get called!')
        throw new Error(qsTr('ExchangeProvider.parseRateResponse. Must be implemented by subclass'))
    }

    // Parse response from rateFetcher and return an object: {from, to, rate, date}
    // This MUST be implemented by subclasses
    function parseAvailableResponse(request, response) {
        // This should never get called
        console.error('ExchangeProvider.parseAvailableResponse. This should never get called!')
        throw new Error(qsTr('ExchangeProvider.parseAvailableResponse. Must be implemented by subclass'))
    }
}
