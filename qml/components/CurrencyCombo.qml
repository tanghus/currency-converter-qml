/*
  Originally from ValueButton.qml
  Copyright (C) 2013 Jolla Ltd.
  Contact: Bea Lam <bea.lam@jollamobile.com>
  All rights reserved.

  Modifications by:
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
import '.'

BackgroundItem {
    id: currencyCombo;

    signal activated(var currency)

    property alias label: titleText.text
    property alias value: valueText.text
    property var allCurrencies
    property string currentCurrencyCode
    property var currentCurrency
    property var list
    property alias _imagePath: flag.source
    property int _duration: 200

    Binding {
        target: currencyCombo
        property: 'allCurrencies'
        value: Currencies.all
    }

    Column {
        id: column

        anchors {
            left: parent.left; right: parent.right; verticalCenter: parent.verticalCenter
            leftMargin: currencyCombo.leftMargin; rightMargin: currencyCombo.rightMargin
        }
        Flow {
            id: row

            spacing: Theme.paddingMedium
            width: parent.width
            move: Transition {
                NumberAnimation {
                    properties: 'x,y'; easing.type: Easing.InOutQuad; duration: currencyCombo._duration
                }
            }

            Label {
                id: titleText
                color: currencyCombo.down ? Theme.highlightColor : Theme.primaryColor
                width: Math.min(Math.round(parent.width*0.3) - Theme.paddingMedium)
                height: text.length ? implicitHeight : 0
                horizontalAlignment: Text.AlignRight
                fontSizeMode: Text.HorizontalFit
                minimumPixelSize: Theme.fontSizeSmallBase
                truncationMode: TruncationMode.Fade
            }

            Image {
                id: flag
                source: ''
                fillMode: Image.PreserveAspectFit
                visible: source !== ''
                height: parent.height
                width: height
                verticalAlignment: Image.AlignVCenter
            }

            Label {
                id: valueText
                color: Theme.highlightColor
                truncationMode: TruncationMode.Fade
            }
        }
    }

    onAllCurrenciesChanged: {
        currentCurrency = allCurrencies[currentCurrencyCode]
        setCurrentCurrency(currentCurrency)
    }

    onClicked: {
        list = pageStack.push(Qt.resolvedUrl('CurrencyList.qml'))
        list.currencySelected.connect(setCurrentCurrency)
    }

    onCurrentCurrencyCodeChanged: {
        var allCurrencies = Currencies.all

        if(Env.isReady) {
            currentCurrency = allCurrencies[currentCurrencyCode]
            setCurrentCurrency(currentCurrency)
        }
    }

    function setCurrentCurrency(currency) {
        console.log('CurrencyCombo.setCurrentCurrency', currency)
        if(!currency) {
            console.log('CurrencyCombo.setCurrentCurrency. Empty currency!!!', typeof currency)
            console.trace()
            return
        }

        if(currentCurrencyCode && currentCurrencyCode !== currency.code) {
            currentCurrencyCode = currency.code
        }
        value = currency.name + ' (' + currency.code + ')'
        _imagePath = Qt.resolvedUrl("../../flags/" + currency.code.toLowerCase() + ".png")
        if(!Env.isBusy && Env.isReady && currentCurrencyCode) {
            currencyCombo.activated(currency)
        }
    }
}
