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

ExchangeProvider {
    id: provider
    updateInterval: 36*60*60 // 36 hours
    // Monday thru Friday
    updateWeekdays: [1,2,3,4,5] // The rates are only updated on week days.
    url: 'https://api.exchangeratesapi.io/latest?base={from}&symbols={to}'

    // TODO: Move this to ExchangeProvider when properly tested
    Requester {
        id: rateFetcher
        url: parent.url
        onMessage: {
            console.log('rateFetcher.onMessage:', JSON.stringify(messageObject))
            console.log('rateFetcher.onMessage. response:', JSON.stringify(messageObject.response))
            if(messageObject.request && messageObject.response ) {
                var _data = provider.parseResponse(messageObject.request, messageObject.response)
                cache.setRate(_data.from, _data.to, _data.rate, _data.date)
                provider.rateRecieved(_data.from, _data.to, _data.rate)
            } else {
                provider.error(messageObject.error, messageObject.message)
                console.warn(messageObject.error, messageObject.message)
            }
        }
    }

    // Parse response from rateFetcher and return an object:
    //      {rate, date}
    function parseResponse(request, response) {
        var _f = request.args.from
        var _t = request.args.to
        var _r = parseFloat(response.rates[_t])
        var _d = response.date ? response.date : _lastUpdated.toISOString()

        return {from: _f, to: _t, rate: _r, date: _d}
    }

    // TODO: Probably move this to ExchangeProvider when properly tested
    function getRate() {
        // Using global vars 'isOnline' and 'workOffline' :/
        var response, doUpdate = false

        // Try to get it from the cache
        // NOTE: Maybe the Storage cache should be instantiated in ExchangeProvider?
        cache.getRate(fromCode, toCode, function(response) {
            //console.log('App.getRate()', response)
            if(response.rate) {
                //console.log('App.getRate(). rate:', response.rate)
                var now, then

                now = new Date()
                then = new Date(response['date'])

                // Is it older than a updateInterval?'
                if(now.getTime() - then.getTime() > updateInterval*1000) {
                    //if(updateWeekdays.includes(now.getDay())) {
                    if (updateWeekdays.indexOf(now.getDay()) != -1) {
                        console.log("It's a WEEKDAY")
                        // NOTE: workOffline shouldn't be here
                        doUpdate = workOffline ? false : true
                    } else {
                        console.log("It's WEEKEND")
                    }
                }
                if(!doUpdate) {
                    provider.rateRecieved(
                        fromCode,
                        toCode,
                        parseFloat(response['rate'])
                    )
                }
            } else {
                console.log('App.getRate(). Nothing cached')
                // Nothing cached
                doUpdate = true
            }

            // NOTE: isOnline and workOffline shouldn't be here
            if(doUpdate && !workOffline) {
                if(isOnline) {
                    rateFetcher.request( {'from': fromCode, 'to': toCode} )
                } else {
                    console.log('Network is down')
                    provider.error(qsTr('Error'), qsTr('Network is down'))
                }
            } else if(doUpdate) {
                var str = qsTr("You have chosen to work offline, but the currency combination \
 %1 => %2 is not in the cache.").arg(fromCode).arg(toCode);
                provider.error(qsTr('Error'), str)

                //pageStack.push(Qt.resolvedUrl('pages/SettingsDialog.qml'), {info: str})
            }
        })

        // NOTE: This should be set in app after rateRecieved() signal, not here
        settings.fromCode = fromCode
        settings.toCode = toCode
        settings.multiplier = multiplier
    }
}
