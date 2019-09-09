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

pragma Singleton

import QtQuick 2.6

QtObject {
    readonly property bool isReady: Boolean(all && available)
    property var all
    property var available

    //onAllChanged: isReady = Boolean(all && available)
    //onAvailableChanged: isReady = Boolean(all && available)

    function createPair(pair) {
        //console.log('Currencies.createPair:', JSON.stringify(pair))

        if(!isReady) {
            error('Cannot create CurrencyPairs at this moment:', pair)
            return
        }

        if(typeof pair !== 'object') {
            error("I don't know what to do with", pair)
            console.trace()
        } else {
            if(pair.length) {
                // Can't do nothin' with an array
                error('Cannot create a "CurrencyPair" from an "array":', pair)
                return
            } else if(pair.objectType && pair.objectType === 'Currency') {
                error('Cannot create a "CurrencyPair" from a "Currency"')
                return
            } else if(pair.objectType && pair.objectType === 'CurrencyPair') {
                // Return a new object to make sure it's initialized properly
                return _createFromPair(pair)
            } else {
                // Try anyway
                //console.warn('Creating "CurrencyPair" from unknown object!')
                return _createFromPair(pair)
            }
        }
    }

    function _createFromPair(pair) {
        if(pair.hasOwnProperty('toCode') && pair.hasOwnProperty('fromCode')) {
            // Then it's from the cache
            pair['from'] = pair.fromCode
            pair['to'] = pair.toCode
        }
        if(!pair.hasOwnProperty('from') || !pair.hasOwnProperty('to')) {
            error('Not a CurrencyPair:' + JSON.stringify(pair))
            return
        }
        if(pair.objectType && pair.objectType === 'CurrencyPair') {
            return pair.init(pair)
        }
        var component = Qt.createComponent(Qt.resolvedUrl('CurrencyPair.qml'));

        if (component.status === Component.Error) {
            error(component.errorString())
            return
        }

        var newPair = component.createObject()
        newPair.init(pair)
        return newPair
    }

    function createCurrency(currency) {
        //console.log('Currencies.createCurrency:', currency)

        if(!isReady) {
            error('Cannot create Currencies at this moment:', currency)
            return
        }

        if(typeof currency === 'string') {
            return _createFromCode(currency)
        } else if(typeof currency === 'object') {
            if(currency.length) {
                // Can't do nothin' with an array
                error('Cannot create a "Currency" from an "array":', currency)
                return
            } else if(currency.objectType && currency.objectType === 'CurrencyPair') {
                error('Cannot create a "Currency" from a "CurrencyPair"')
                return
            } else if(currency.objectType && currency.objectType === 'Currency') {
                    // Return a new object to make sure it's initialized properly
                    return _createFromCurrency(currency)
            } else {
                // Try something else
                console.warn('Creating "Currency" from unknown object!')
                return _createFromProperties(currency)
            }
        } else {
            error("I don't know what to do with", currency)
            console.trace()
        }
    }

    function _createFromProperties(currency) {
        var props = ['code', 'num', 'name', 'symbol']

        for(var i = 0; i < props.length; i++) {
            if(!currency.hasOwnProperty(props[i])) {
                error('Not a Currency. No property:' + props[i] + ' ' + JSON.stringify(currency))
                return
            }
        }
        return _createFromCode(currency.code)
    }

    function _createFromCurrency(currency) {
        if(!currency.hasOwnProperty('code')) {
            error('Not a Currency:' + JSON.stringify(currency))
            return
        }
        return currency.init(currency)
    }

    function _createFromCode(code) {
        if(code.trim().length !== 3) {
            error('Not a Currency Code:' + code)
            return
        }
        if(!all.hasOwnProperty(code)) {
            error('Currency Code not found:' + code)
            return
        }

        var tmp = all[code]
        var component = Qt.createComponent(Qt.resolvedUrl('Currency.qml'));

        if (component.status === Component.Error) {
            error(component.errorString())
            return
        }

        var newCurrency = component.createObject()
        newCurrency.init(tmp)
        return newCurrency
    }

    function error(msg) {
        console.error(msg)
        console.trace()
    }
}
