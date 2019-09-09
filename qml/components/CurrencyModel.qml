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
import QtQml.Models 2.3
import Sailfish.Silica 1.0
import '.'

ListModel {
    id: currencyModel

    function listProperties(obj) {
       var propList = "";
       for(var propName in obj) {
          if(typeof(obj[propName]) != "undefined") {
              console.log('property:', propName, obj[propName])
          }
       }
    }

    function listElements() {
        for(var i = 0; i < rowCount(); i++) {
            console.log('Element:', objectName, get(i), typeof get(i))
        }
    }

    function update() {
        console.log('CurrencyModel.update. children:', typeof this)
        var currencies = []
        var currency
        var found
        var i

        for(i = 0; i < rowCount(); i++) {
            var elem = get(i)
            var c = {}
            c['code'] = elem['code']
            c['name'] = elem['name']
            c['symbol'] = elem['symbol']
            c['num'] = elem['num']
            console.log('currency:', JSON.stringify(c))
            currencies.push(c)
        }
        //listProperties(get(0))
        //listElements()
        var filteredCurrencies = currencies.filter(function (currency) { return currency.name.toLowerCase().indexOf(searchString) !== -1 })

        // helper objects that can be quickly accessed
        var filteredCurrencyObject = new Object
        for (i = 0; i < filteredCurrencies.length; ++i) {
            filteredCurrencyObject[filteredCurrencies[i]] = true
        }
        var existingCurrencyObject = new Object
        for (i = 0; i < count; ++i) {
            currency = get(i).text
            existingCurrencyObject[currency] = true
        }

        // remove items no longer in filtered set
        i = 0
        while (i < count) {
            currency = get(i).text
            found = filteredCurrencyObject.hasOwnProperty(currency)
            if (!found) {
                remove(i)
            } else {
                i++
            }
        }

        // add new items
        for (i = 0; i < filteredCurrencies.length; ++i) {
            currency = filteredCurrencies[i]
            found = existingCurrencyObject.hasOwnProperty(currency)
            if (!found) {
                // for simplicity, just adding to end instead of corresponding position in original list
                append(currency)
            }
        }
    }

    Component.onCompleted: {
        if(!Currencies.isReady) {
            console.log('CurrencyModel. Not ready')
            return
        }

        var allCurrencies = Currencies.all
        var availableCurrencies = Currencies.available

        /*for(var currency in availableCurrencies) {
            console.log(currency, availableCurrencies[currency])
        }*/

        if(Env.isReady) {
            // Begin populating
            console.log('CurrencyModel. Populating...', availableCurrencies.length)
            for(var currency in allCurrencies) {
                if (allCurrencies.hasOwnProperty(currency)) { // Of course it has???
                    allCurrencies[currency].code = currency
                    //console.log(currency + " -> " + JSON.stringify(availableCurrencies[currency]));
                    if(availableCurrencies[currency]) {
                        //console.log(currency + " -> " + JSON.stringify(availableCurrencies[currency]));
                        append(allCurrencies[currency])
                    }/* else {
                        console.log('Could not find:', currency,
                            ' in ', JSON.stringify(availableCurrencies[currency]))
                    }*/
                }
            }
        } else {
            console.error('One or both variables "allCurrencies" and "availableCurrencies" are empty.')
        }
    }
}
