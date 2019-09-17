/*
  Originally from ValueButton.qml
  Copyright (C) 2013 Jolla Ltd.
  Contact: Bea Lam <bea.lam@jollamobile.com>
  All rights reserved.

  Heavily modified by:
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

    Binding {
        target: currencyCombo
        property: 'allCurrencies'
        value: Currencies.all
    }

    ParallelAnimation {
        id: changeAnimation
        PropertyAnimation {
            id: nameAnimation
            target: currencyCombo
            properties: 'value'
            to: ''
            duration: 300
        }

        PropertyAnimation {
            id: flagAnimation
            target: flag
            properties: 'source'
            to: ''
            duration: 300
        }
    }

    function animateChange(currency) {
        // Apparently the name in combination with the flag causes memory corruption
        // due to missing garbage collection. Let's hope this fixes it.
        // https://forum.qt.io/topic/52203/help-windows-qml-image-corruption-crash-problem/2
        gc()
        nameAnimation.to = currency.name + ' (' + currency.code + ')'
        flagAnimation.to = Qt.resolvedUrl('../../flags/' + currency.code.toLowerCase() + '.png')
        changeAnimation.start()
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
            }

            Label {
                id: valueText
                width: Math.min(Math.round(parent.width*0.6))
                color: Theme.highlightColor
                truncationMode: TruncationMode.Fade
            }
        }
    }

    /*onAllCurrenciesChanged: {
        currentCurrency = allCurrencies[currentCurrencyCode]
        setCurrentCurrency(currentCurrency)
    }*/

    onClicked: {
        console.log('CurrencyCombo.onClicked. currentCurrencyCode:', currentCurrencyCode)
        list = pageStack.push(Qt.resolvedUrl('CurrencyList.qml'),
                              {currentCurrencyCode: currentCurrencyCode})
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
        if(!currency) {
            console.log('CurrencyCombo.setCurrentCurrency. Empty currency!!!', typeof currency)
            console.trace()
            return
        }

        console.log('CurrencyCombo.setCurrentCurrency', JSON.stringify(currency))
        if(currentCurrencyCode && currentCurrencyCode !== currency.code) {
            currentCurrencyCode = currency.code
        }
        animateChange(currency)
        if(!Env.isBusy && Env.isReady && currentCurrencyCode) {
            currencyCombo.activated(currency)
        }
    }
}
