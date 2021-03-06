/*
  Copyright (C) 2019 Thomas Tanghus <thomas@tanghus.net>
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
import '.'

// A Currency Pair is the combination of two currencies and their current
// exchange rate. A Currency pair can be e.g. EUR/USD, where in this case
// USD is the Base Currency.
// In this context a pair is an object with the properties:
//     'from', 'to', 'rate', and 'date'
// where 'from' is the three-letter Base Currency, and 'to' is
// the Minor Currency. 'rate' is of course the exchange rate, and 'date'
// is the date(time) the service reports the rate has been updated.

QtObject {
    readonly property string objectType: 'CurrencyPair'
    objectName: from + '/' + to + '=' + rate
    property string from: ''
    property string to: ''
    property double rate: 0.0
    property string date: ''

    function init(dict) {
        from = dict.from
        to = dict.to
        rate = dict.rate
        date = dict.date
    }

    function currencyFrom() {
        return Currencies.createCurrency(from)
    }

    function currencyTo() {
        return Currencies.createCurrency(to)
    }

    function toString() {
        return objectName
    }
}
