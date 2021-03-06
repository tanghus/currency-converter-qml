/*
  Copyright (C) 2013-2011 Thomas Tanghus <thomas@tanghus.net>
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

    signal populated()

    Component.onCompleted: {
        if(!Currencies.isReady) {
            console.log('CurrencyModel. Not ready')
            return
        }

        var allCurrencies = Currencies.all
        var availableCurrencies = Currencies.available

        if(Env.isReady) {
            // Begin populating
            console.log('CurrencyModel. Populating...', JSON.stringify(allCurrencies).substring(0, 200))
            for(var currency in allCurrencies) {
                if (allCurrencies.hasOwnProperty(currency)) { // Of course it has???
                    allCurrencies[currency].code = currency
                    if(availableCurrencies[currency]) {
                        //console.log('Appending:', JSON.stringify(allCurrencies[currency]))
                        append(allCurrencies[currency])
                    }
                }
            }
            console.log('Populated')
            populated()
        } else {
            console.error('One or both variables "allCurrencies" and "availableCurrencies" are empty.')
        }
    }
}
