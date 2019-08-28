/*
  Copyright (C) 2013-2018 Thomas Tanghus <thomas@tanghus.net>
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
import Sailfish.Silica 1.0
import org.freedesktop.contextkit 1.0
import Nemo.DBus 2.0
//import harbour.currencyconverter.fileproxy 1.0
import "cover"
import "pages"
import "components"
//import "components/utils.js" as Utils

ApplicationWindow {

    id: app

    // E.g. USD, EUR, DKK
    property string fromCode
    property string toCode

    // Usually the same as above, but can be e.g. £ or $
    property string fromSymbol
    property string toSymbol

    // The amount to multiply the rate with
    property double multiplier

    // The number of decimals to show the result with
    property int numDecimals

    // The last result before multiplication
    // NOTE: Changed from string.
    property double rate: 1.0

    // The multiplied result
    // The reason for having two variables, is to avoid double multiplication
    property double tmpResult: 1.0
    property double result: 1.0

    property bool isBusy: true
    property bool workOffline: false
    property bool isOnline: false
    // An object containing all current currencies
    property variant currencies
    property string locale: Qt.locale().name

    // The final result: amount * rate
    onTmpResultChanged: result = Number(tmpResult * multiplier).toFixed(numDecimals)
    onNumDecimalsChanged: result = Number(tmpResult * multiplier).toFixed(numDecimals)
    onLocaleChanged: {
        console.log('App.onLocaleChanged:', locale)
        if(!locale || locale === 'C') {
            locale = 'en_GB'
        }
    }

    allowedOrientations: Orientation.Portrait | Orientation.Landscape //defaultAllowedOrientations

    initialPage: Component {
        id: frontPage;
        FrontPage {}
    }

    /*
    initialPage: config.isFirstStart()
                     ? Qt.resolvedUrl("common/wizard/Welcome.qml")
                     : Qt.resolvedUrl("tablet/pages/MainPage.qml")
    */

    cover: CoverBackground {
        CoverPage {}
    }

    Settings {
        id: settings
    }

    /*FileProxy {
        name: StandardPaths.data + '/currencyconverter.conf'
        Component.onCompleted: {
            //console.log('FileProxy.name:', exists)
            //console.log('FileProxy.writeable:', writeable)
            //console.log('FileProxy.exists:', exists)
            //console.log('FileProxy.error:', error)
            //console.log('StandardPaths.data:', StandardPaths.data)
            //var jsd = JSON.parse('{"result":true, "count":42}')
            //data: jsd
            //console.log('.data:', data)
        }
    }*/

    ContextProperty {
        // `cat /run/state/namespaces/Internet/NetworkState`
        id: networkOnline
        key: 'Internet.NetworkState'
        onValueChanged: {
            isOnline = value === 'connected' ? true : false
            console.log('Connected', isOnline)
        }
    }

    // Popup the network selection dialogue
    DBusInterface {
         id: networkIFace
         service: 'com.jolla.lipstick.ConnectionSelector'
         path: '/'
         iface: 'com.jolla.lipstick.ConnectionSelectorIf'

        function openConnection() {
            console.log('DBusInterface.openConnection')
            console.trace()
            call('openConnectionNow', 'wifi')
        }
    }

    Notification {
        id: notifier
        body: 'Test body'
        summary: 'Test summary'
    }

    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        size: BusyIndicatorSize.Large
        running: isBusy
    }

    Storage {
        id: storage
        // TODO: This creates some weird path.
        dbName: StandardPaths.data
        tblName: 'rates'
        // Use Map? https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Map
        columns: ({
            fromCurrency: 'TEXT',
            toCurrency: 'TEXT',
            rate: 'TEXT',
            date: 'TEXT'
        })
        key: ['fromCurrency', 'toCurrency']

        function setRate(fromCurrency, toCurrency, rate, date) {
            try {
                set(['fromCurrency', 'toCurrency', 'rate', 'date'],
                    [fromCurrency, toCurrency, rate, date])
            } catch(e) {
                console.error(e)
            }
        }

        function getRate(from, to, cb) {
            try {
                get(['rate'], {'fromCurrency': fromCode, 'toCurrency': toCode},
                    function(row) {cb(row)})
            } catch(e) {
                console.log(e)
            }
        }

        function getAll(from, cb) {
            try {
                get(['rate'], {'fromCurrency': fromCode, 'toCurrency': ''},
                    function(row) {cb(row)})
            } catch(e) {
                console.log(e)
            }
        }
    }

    // Used for instantiating object with all currencies.
    Requester {
        id: currenciesFetcher
        url: Qt.resolvedUrl('../data/currencies_{locale}.json'.replace('{locale}', locale))
        onMessage: {
            console.log('currenciesFetcher.onMessage:') //, JSON.stringify(messageObject))
            currencies = messageObject.response
        }
    }

    // https://doc.qt.io/qt-5/qml-qtquick-loader.html
    /*
      Loader {
          source: 'ExchangeProviderXXX'
      }
    */
    Requester {
        id: rateFetcher
        url: 'https://api.exchangeratesapi.io/latest?base={from}&symbols={to}'
        onMessage: {
            console.log('rateFetcher.onMessage:', JSON.stringify(messageObject))
            console.log('rateFetcher.onMessage. response:', JSON.stringify(messageObject.response))
            if(messageObject.request && messageObject.response ) {
                // TODO: This part needs to be generalized
                var _f = messageObject.request.args.from
                var _t = messageObject.request.args.to
                var _r = messageObject.response.rates[_t]
                var _d = messageObject.response.date
                tmpResult = parseFloat(_r)
                storage.setRate(_f, _t, _r, _d)
            } else {
                notifier.notify(messageObject.error, messageObject.message)
                console.warn(messageObject.error, messageObject.message)
            }

            setBusy(false)
        }
    }

    Component.onCompleted: {
        setBusy(true)
        fromCode = settings.value('fromCode', 'USD')
        toCode = settings.value('toCode', 'EUR')
        multiplier = settings.value('multiplier', 1)
        numDecimals = settings.value('numDecimals', 4)
        rate = settings.value('rate', 1.0)
        workOffline = settings.value('workOffline', false)
        if(!isOnline && !workOffline) {
            networkIFace.openConnection()
        }
        // NOTE: Is 'locale' used?
        currenciesFetcher.request({'locale': locale})
        getRate()
        console.log('App.Ready', fromCode, toCode)
        setBusy(false)
    }

    // TODO: This method needs to be generalized to allow for
    // other providers
    function getRate() {
        var response, doUpdate = false

        if(isBusy) return

        setBusy(true)

        // Try to get it from the cache
        storage.getRate(fromCode, toCode, function(response) {
            //console.log('App.getRate()', response)
            if(response.rate) {
                //console.log('App.getRate(). rate:', response.rate)
                var now, then
                tmpResult = parseFloat(response['rate']).toFixed(numDecimals)
                now = new Date()
                then = new Date(response['date'])

                // Is it older than a 36 hrs?'
                // Using 36 instead of 24 to avoid too many requests.
                if(now.getTime() - then.getTime() > 129600000) {
                    // Also test if it's weekend, as the rates aren't updated then.
                    if(0 < now.getDay() < 6) {
                        console.log("It's a WEEKDAY")
                        doUpdate = workOffline ? false : true
                    } else {
                        console.log("It's WEEKEND")
                    }
                }
                setBusy(false)
            } else {
                console.log('App.getRate(). Nothing cached')
                // Nothing cached
                doUpdate = true
            }

            if(doUpdate && !workOffline) {
                if(isOnline) {
                    rateFetcher.request( {'from': fromCode, 'to': toCode} )
                } else {
                    console.log('Network is down')
                    notifier.notify(qsTr('Network is down'))
                    setBusy(false)
                }
            } else if(doUpdate) {
                setBusy(false)
                var str = qsTr("You have chosen to work offline, but the currency combination \
 %1 => %2 is not in the cache.").arg(fromCode).arg(toCode);

                pageStack.push(Qt.resolvedUrl('pages/SettingsDialog.qml'), {info: str})
            }
        })

        settings.fromCode = fromCode
        settings.toCode = toCode
        settings.multiplier = multiplier
    }

    function setBusy(state) {
        isBusy = state;
    }
}


