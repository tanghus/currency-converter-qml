/*
  Copyright (C) 2013-2019 Thomas Tanghus
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
            if(messageObject.request && messageObject.response ) {
                if(messageObject.request.args.requestType) {
                    var _data
                    if(messageObject.request.args.requestType === 'rate') {
                        // 'parseRateResponse' must be implemented by subclasses.
                        _data = provider.parseRateResponse(
                                    messageObject.request,
                                    messageObject.response)
                        console.log('ExchangeProvider.rateFetcher.onMessage:', JSON.stringify(_data))
                        cache.setRate(_data.from, _data.to, _data.rate, _data.date)
                        // Signal received
                        provider.rateReceived(Currencies.createPair(_data))
                    } else if(messageObject.request.args.requestType === 'available') {
                        // Signal received
                        provider.availableReceived(messageObject.response)
                        console.log('ExchangeProvider.rateFetcher. available:', messageObject.length,
                                    JSON.stringify(messageObject.response).substring(0, 100))
                        // 'parseAvailableResponse' must be implemented by subclasses.
                        _data = provider.parseAvailableResponse(
                                    messageObject.request,
                                    messageObject.response)
                        for(var currency in _data) {
                            console.log('rateFetcher.cache.setRate:', JSON.stringify(_data[currency]))
                            cache.setRate(_data[currency].from, _data[currency].to,
                                          _data[currency].rate, _data[currency].date)
                        }
                    } else {
                        var str = qsTr('No "requestType" set in request. Use "rate" or "available"')
                        console.error(str)
                        throw new Error(qsTr('Error'), str)
                    }
                }
            } else {
                provider.error(messageObject.error, messageObject.message)
                console.warn(messageObject.error, messageObject.message)
            }
        }
    }

    // Fetch a list of available currencies either from cache or from
    // the current provider.
    function getAvailable(base, force) {
        var response, doUpdate = false // NOTE: Set to false in production.

        rateFetcher.url = availableURL

        // Try to get it from the cache
        if(force) {
            doUpdate = true
        } else {
            cache.getAvailable(base, function(response) {
                if(response.length > 0) {
                    var rates = {}
                    for(var i = 0; i < response.length; i++) {
                        var code = response[i].code
                        rates[code] = parseFloat(response[i].rate)
                        //console.log('ExchangeProvider.getAvailable. rate:', code,
                        //JSON.stringify(rates[code]))
                    }
                    console.log('ExchangeProvider.getAvailable. rates:', JSON.stringify(rates))
                    console.log('ExchangeProvider.getAvailable. Fetching "' + base + '" OFFLINE')
                    doUpdate = false
                    // Signal received
                    provider.availableReceived(rates)
                } else {
                    doUpdate = true
                }
            })
        }

        if(doUpdate) {
            if(Env.isOnline && !workOffline) {
                console.log('ExchangeProvider.getAvailable. Fetching "' + base + '" ONLINE')
                rateFetcher.request( {'from': fromCode, 'requestType': 'available'} )
            } else {
                // TODO: Notify that the user has to get online
                console.log('ExchangeProvider.getAvailable() NOT ONLINE!!')
            }
        }

    }

    function getRate(fromCode, toCode) {
        // FIXME: Using global var 'workOffline' :/
        var response, doUpdate = false

        rateFetcher.url = rateURL
        console.log('ExchangeProvider.getRate(', fromCode, toCode, ')')
        // Try to get it from the cache
        // TODO: The cache validation needs cleanup if possible.
        cache.getRate(fromCode, toCode, function(response) {
            console.log('ExchangeProvider.getRate()', JSON.stringify(response))
            if(response && response.rate) {
                var now, then

                now = new Date()
                then = new Date(response['date'])

                // Is it older than a updateInterval'?
                console.log('getRate:',
                            Math.round(now.getTime()/1000), '-',
                            Math.round(then.getTime()/1000), '>', updateInterval)
                if(now.getTime() - then.getTime() > updateInterval*1000) {
                    console.log('getRate: expired. Weekday?', JSON.stringify(updateWeekdays), now.getDay())
                    if (updateWeekdays.indexOf(now.getDay()) !== -1) {
                        // NOTE: workOffline shouldn't be used here
                        doUpdate = workOffline ? false : true
                        console.log('getRate: weekday. workOffline?', workOffline, 'Update?',  doUpdate)
                    } else {
                        console.log('Not weekday. Update?', doUpdate)
                    }
                } else {
                    console.log('getRate(). Not expired')
                }

                if(!doUpdate) {
                    console.log('ExchangeProvider.getRate. OFFLINE response:', response.rate)
                    // The response is OK. Format it to fit with the required format
                    var pair = Currencies.createPair(response)
                    // Signal received
                    // is caught in App.onRateReceived
                    provider.rateReceived(pair)
                }
            } else {
                console.log('ExchangeProvider.getRate(). Nothing cached')
                // Nothing cached
                doUpdate = true
            }

            // NOTE: workOffline shouldn't be here
            if(doUpdate) {
                if(Env.isOnline && !workOffline) {
                    rateFetcher.request( {'from': fromCode, 'to': toCode, 'requestType': 'rate'} )
                } else if(doUpdate) {
                    var str = qsTr("You have chosen to work offline, but the currency combination \
     %1 => %2 is not in the cache.").arg(fromCode).arg(toCode);
                    provider.error(qsTr('Error'), str)

                    //pageStack.push(Qt.resolvedUrl('pages/SettingsDialog.qml'), {info: str})
                }
            }
        })
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
