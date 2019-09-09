/*
  Copyright (C) 2013-2019 Thomas Tanghus <thomas@tanghus.net>
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
//import harbour.currencyconverter.environment 0.1
//import harbour.currencyconverter.fileproxy 1.0
import "cover"
import "pages"
import "components"
//import "components/utils.js" as Utils

ApplicationWindow {

    id: app

    // A Currency Pair is the combination of two currencies and their current
    // exchange rate. A Currency pair can be e.g. EUR/USD, where in this case
    // USD is the Base Currency.
    // In this context a pair is an object with the properties:
    //     'from', 'to', 'rate', and 'date'
    // where 'from' is the three-letter Base Currency, and 'to' is
    // the Minor Currency. 'rate' is of course the exchange rate, and 'date'
    // is the date(time) the service reports the rate has changed.

    property var currentPair

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
    property double rate: 1.0

    // The multiplied result
    // The reason for having two variables, is to avoid double multiplication
    property double tmpResult: 1.0
    property double result: 1.0
    property string dateRecieved: ''

    property bool workOffline: false
    property bool isOnline: Env.isOnline
    property var allCurrencies: Currencies.all
    property var availableCurrencies: Currencies.available
    property string locale: Qt.locale().name

    // https://doc.qt.io/qt-5/qtqml-syntax-objectattributes.html#object-list-property-attributes
    // https://doc.qt.io/qt-5/qml-list.html
    //property list<ExchangeRatesProvider> providers

    // The final result: amount * rate
    onTmpResultChanged: updateResult('tmpResult', tmpResult)
    onNumDecimalsChanged: updateResult('numDecimals', numDecimals)
    onMultiplierChanged: updateResult('multiplier', multiplier)

    function updateResult(field, value) {
        // This triggers an update in frontPage
        result = Number(tmpResult * multiplier).toFixed(numDecimals)
    }

    onLocaleChanged: {
        //console.log('App.onLocaleChanged:', locale)
        if(!locale || locale === 'C') {
            locale = 'en_GB'
        }
    }

    onCurrentPairChanged: {
        console.log('App.currentPair:', JSON.stringify(currentPair))
    }

    Timer {
        id: kickOff
        interval: 300; running: true; repeat: true
        onTriggered: {
            if(Currencies.isReady) {
                console.log('KICKOFF!!!!!!!')
                stop()
                repeat = false
                if(!Env.isOnline && !workOffline) {
                    networkIFace.openConnection()
                }
                getRate()
            } else {
                restart()
            }
        }
    }

    onIsOnlineChanged: {
        fromCode = settings.value('fromCode', 'USD')
        toCode = settings.value('toCode', 'EUR')
        multiplier = settings.value('multiplier', 1)
        numDecimals = settings.value('numDecimals', 2)
        rate = settings.value('rate', 1.0)
        workOffline = settings.value('workOffline', false)
        console.log('App.isOnline:', Env.isOnline)  //, fromCode, '=>', toCode)

        if(settings.firstRun) {
            // TODO: Use for first time loaded
            // Use a 'Loader' to load a 'Requester' to execute DB schema(s).
            // When DB is created, signal to Currencies/Env.
        }

        allCurrenciesFetcher.request({})
        provider.getAvailable(toCode)
        //storage.getAvailable(fromCode)
        //storage.getRaw('SELECT * FROM rates WHERE fromCode="CZK"')
        // Start timer to monitor when Currencies data is ready.
        kickOff.start()
    }

    Binding {
        target: app
        property: 'isOnline'
        value: Env.isOnline
    }

    Binding {
        target: app
        property: 'allCurrencies'
        value: Currencies.all
    }

    allowedOrientations: Orientation.Portrait | Orientation.Landscape //defaultAllowedOrientations

    initialPage: Component {
        FrontPage {
            id: frontPage;
        }
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
        Component.onCompleted: {
            // TODO: Check if 'version' matches current version.
        }
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

    // Popup the network selection dialogue
    // Maybe move this to Env.network?
    DBusInterface {
         id: networkIFace
         service: 'com.jolla.lipstick.ConnectionSelector'
         path: '/'
         iface: 'com.jolla.lipstick.ConnectionSelectorIf'

        function openConnection() {
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
        running: Env.isBusy
        //onRunningChanged: console.log('busyIndicator.running', busyIndicator.running)
    }

    // TODO: Move 'storage' to separate file 'Cache.qml'
    // Used for instantiating object with all currencies.
    Requester {
        id: allCurrenciesFetcher
        url: Qt.resolvedUrl('../data/currencies.json')
        //url: Qt.resolvedUrl('../data/currencies_{locale}.json'.replace('{locale}', locale))
        onMessage: {
            console.log('allCurrenciesFetcher.onMessage:', JSON.stringify(messageObject).substring(0, 200))
            var all = messageObject.response
            for(var currency in all) {
                // 'code' is the key, but not in the object itself.
                all[currency]['code'] = currency
                //console.log('currency:', JSON.stringify(all[currency]['code']))
            }

            Currencies.all = all
        }
    }

    // https://doc.qt.io/qt-5/qml-qtquick-loader.html
    /*
      Loader {
          source: 'ExchangeProviderXXX'
      }
    */

    Cache {
        id: storage
    }

    ExchangeRatesAPIProvider {
        id: provider
        url: 'https://api.exchangeratesapi.io/latest?base={from}&symbols={to}'
        cache: storage

        // The signal is sent from ExchangeProvider.getRate()
        onRateRecieved: {
            // This triggers frontPage.onCurrentPairChanged
            if(!pair) {
                console.error('App.provider.onRateRecieved: Got empty pair!')
                console.trace()
                Env.setBusy(false)
                return
            }

            currentPair = pair
            // This is recieved in onTmpResultChanged where it is formatted and assigned to 'result'
            tmpResult = parseFloat(pair.rate)
            dateRecieved = pair.date
            Env.setBusy(false)
        }
        onAvailableRecieved: {
            console.log('App.provider.onAvailableRecieved:', JSON.stringify(availableCurrencies))

            /*var available = {}
            for(var i = 0; i < availableCurrencies.length; i++) {
                //console.log('Available:', JSON.stringify(availableCurrencies[i]))
                available[availableCurrencies[i].toCode] = { rate: availableCurrencies[i].rate }
            }*/

            Currencies.available = availableCurrencies
            //Currencies.available = available
        }
        onError: {
            console.log('App.provider.onError:', error, message)
            Env.setBusy(false)
        }
    }

    /*Component.onCompleted: {
    }*/

    function getRate() {
        var response, doUpdate = false

        //console.log('App.getRate. Busy or !Ready?', (Env.isBusy || !Env.isReady))
        if(Env.isBusy || !Env.isReady) {
            console.log('App.GetRate. Returning!!!!')
            return
        }

        console.log('App.getRate(' + fromCode + ', ' + toCode + ')')
        settings.fromCode = fromCode
        settings.toCode = toCode
        settings.multiplier = multiplier
        Env.setBusy(true)
        provider.getRate(fromCode, toCode)
    }
}


