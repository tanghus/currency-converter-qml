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
import QtQuick.Layouts 1.1
import Sailfish.Silica 1.0
import '../components'

Page {
    id: frontPage;
    property bool isEnabled: true
    property var currentPair

    Binding {
        target: frontPage
        property: 'currentPair'
        value: app.currentPair
    }

    allowedOrientations: Orientation.All

    // This is triggered in App.provider.onRateReceived
    onCurrentPairChanged: {
        console.log('FrontPage.onCurrentPairChanged:', currentPair.from, currentPair.to)
        var from = Currencies.createCurrency(currentPair.from)
        var to = Currencies.createCurrency(currentPair.to)
        // Trigger the combos to adjust properties
        console.log('FrontPage.onCurrentPairChanged. isBusy?', Env.isBusy)
        //if(!Env.isBusy) {
            console.log('FrontPage.onCurrentPairChanged. isBusy?', Env.isBusy)
            fromCombo.setCurrentCurrency(from)
            toCombo.setCurrentCurrency(to)
        //}
    }

    onIsEnabledChanged: console.log('frontPage.isEnabled: ', isEnabled)

    Binding {
        target: frontPage
        property: 'isEnabled'
        value: Env.isReady
        // when: Env.isReady
        // delayed: true
    }

    Timer {
        // This is used to update result but only after a short delay
        id: inputTimer
        interval: 300
        running: false
        repeat: false
        property alias text: amountText.text
        onTriggered: {
            if(text.trim().length > 0 && !isNaN(text) && parseFloat(text) > 0.0) {
                multiplier = parseFloat(amountText.text)
                if(!Env.isBusy) { getRate() }
            } else {
                restart()
            }
        }
    }

    SilicaFlickable {
        anchors.fill: parent
        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        PullDownMenu {
            // TODO "Pulsate" menu when busy. Shouldn't 'busy' do that?
            visible: !Env.isBusy
            MenuItem {
                text: qsTr('Refresh cache for "%1"').arg(Currencies.nameFromCode(fromCode));
                truncationMode: TruncationMode.Fade
                onClicked: {
                    Remorse.popupAction(frontPage,
                                        qsTr('Refresh cache for "%1"')
                                        .arg(Currencies.nameFromCode(fromCode)),
                                        function() {
                    try {
                        // Force reload
                        provider.getAvailable(true)
                    } catch(e) {
                        // Show notification
                        notifier.notify(
                            qsTr('Error'),
                            qsTr('There was an error clearing the cache.')
                        )
                        enabled = true
                    }
                    })
                }
            }
            MenuItem {
                text: qsTr('Switch currencies')
                enabled: isEnabled
                onClicked: {
                    rotationAnimation.start()
                    switchCurrencies()
                }
            }

            MenuItem {
                text: qsTr('Update')
                enabled: isEnabled
                onClicked: {
                    console.log('FrontPage menu Update:')
                    storage.removeRate(fromCode, toCode,
                        function(rows) {
                            app.getRate()})
                }
            }
        }

        PushUpMenu {
            busy: Env.isBusy
            MenuItem {
                text: qsTr('Settings');
                onClicked: {
                    pageStack.push(Qt.resolvedUrl('SettingsDialog.qml'))
                }
            }
            MenuItem {
                text: workOffline ? qsTr('Work online') : qsTr('Work offline')
                onClicked: {
                    settings.workOffline = workOffline = !workOffline
                }
            }
            MenuItem {
                text: qsTr('About')
                onClicked: {
                    pageStack.push(Qt.resolvedUrl('AboutPage.qml'))
                }
            }
        }

        // Place the content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: Screen.width - (Theme.paddingLarge * 2)
            spacing: Theme.paddingLarge
            anchors.centerIn: parent
            PageHeader {
                id: pageHeader
                title: qsTr('Currency Converter')
            }
            CurrencyCombo {
                id: fromCombo
                //: The currency to convert from
                label: qsTr('From')
                enabled: isEnabled
                currentCurrencyCode: fromCode
                onActivated: {
                    console.log('FrontPage.fromCombo.onActivated:')
                    fromCode = currency.code
                    //fromSymbol = currency.symbol ? decodeURIComponent(currency.symbol) : currency.code
                    if(fromCode !== toCode && !Env.isBusy && Env.isReady) { app.getRate() }
                }
            }
            // The iconButton, including animations, is "borrowed"
            // from https://github.com/dgrr/harbour-translate/blob/master/qml/pages/MainPage.qml
            // Thanks, dgrr (:
            IconButton {
                id: iconButton
                enabled: isEnabled
                opacity: (enabled ? 1 : 0)
                rotation: 180
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
                icon.source: "image://theme/icon-m-transfer?"
                             + (pressed ? Theme.highlightColor : Theme.primaryColor)
                onClicked: {
                    rotationAnimation.start()
                    switchCurrencies()
                }
                RotationAnimator {
                    id: rotationAnimation
                    target: iconButton
                    from: 0
                    to: 180
                    duration: 300
                    running: false
                }
            }
            CurrencyCombo {
                id: toCombo
                //: The currency to convert to
                label: qsTr('To')
                enabled: isEnabled
                currentCurrencyCode: toCode
                onActivated: {
                    toCode = currency.code
                    //toSymbol = currency.symbol ? decodeURIComponent(currency.symbol) : currency.code
                    if(fromCode !== toCode && !Env.isBusy && Env.isReady) { app.getRate() }
                }
            }

            // TODO: Use this in KitchenTimer
            /*ParallelAnimation {
                id: hideAnimation
                running: false
                onStopped: {
                    //var v = box1.value
                    //box1.value = box2.value
                    //box2.value = v
                    pumpAnimation.start()
                }
                OpacityAnimator {
                    target: toCombo
                    from: 1
                    to: 0
                }
                OpacityAnimator {
                    target: toCombo
                    from: 1
                    to: 0
                }
            }
            ParallelAnimation {
                id: pumpAnimation
                running: false
                OpacityAnimator {
                    target: fromCombo
                    from: 0
                    to: 1
                }
                OpacityAnimator {
                    target: toCombo
                    from: 0
                    to: 1
                }
            }*/

            // https://doc.qt.io/qt-5/qml-qtquick-layouts-rowlayout.html ?
            Flow {
                id: resultItem
                padding: {
                    top: Theme.paddingLarge
                }

                anchors.horizontalCenter: parent.horizontalCenter
                Label {
                    id: fromSymbolLabel;
                    verticalAlignment: Text.AlignBottom
                    horizontalAlignment: Text.AlignRight
                    topPadding: Theme.paddingSmall
                    width: Theme.paddingMedium*3
                    rightPadding: 0
                    text: {
                        if(!Env.isReady || !currentPair) {
                            return ''
                        }

                        return currentPair.currencyFrom().getSymbol()
                    }
                }
                // https://doc.qt.io/qt-5/qml-qtquick-textinput.html ?
                TextField {
                    id: amountText
                    text: multiplier;
                    enabled: isEnabled
                    placeholderText: label
                    width: Math.round(frontPage.width/4) //resultLabel.width
                    //height: parent.height
                    horizontalAlignment: TextInput.AlignRight
                    //_editor.verticalAlignment: TextInput.AlignTop
                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                    validator: DoubleValidator {
                        bottom: 0.1
                        top: orientation === Orientation.Portrait
                             ? 999999 : 999999999
                        decimals: numDecimals
                        notation: DoubleValidator.StandardNotation
                    }
                    onClicked: {
                        if(!selectedText) {
                            selectAll()
                        }
                    }
                    onTextChanged: {
                        // Try not to refresh on every change.
                        if(text.trim().length > 0 && !isNaN(text) && parseFloat(text) > 0.0) {
                            inputTimer.restart();
                        }
                    }
                    EnterKey.enabled: text.length > 0 && !isNaN(text) && parseFloat(text) > 0.0
                    //EnterKey.iconSource: 'image://theme/icon-m-enter-next'
                    EnterKey.iconSource: "image://theme/icon-m-enter-accept"
                }
                Label {
                    leftPadding: 0
                    text: ' = '
                    horizontalAlignment: Text.AlignHCenter;
                    width: Theme.paddingMedium*3
                }
                Label {
                    id: resultLabel
                    topPadding: Theme.paddingSmall
                    color: Theme.highlightColor
                    horizontalAlignment: Text.AlignHCenter;
                    verticalAlignment: Text.AlignBottom;
                    truncationMode: TruncationMode.Fade
                    width: Math.round(frontPage.width/3)
                    //: Just localizing the result. NOT to be translated
                    text: {
                        if(!Env.isReady || !currentPair) {
                            return ' '
                        }
                        return currentPair.currencyTo().getSymbol() +
                               ' ' + qsTr("%L1").arg(result);
                    }
                }
            }
            // Show the time updated. Use Date().toLocaleString(Qt.locale())
            Label {
                property var now: new Date()
                property var then: new Date(dateReceived)
                property int interval: provider.updateInterval
                property double diffTime: Math.round((now.getTime() - then.getTime())/1000)
                property bool updateDay: provider.updateWeekdays.indexOf(now.getDay()) !== -1

                anchors.horizontalCenter: parent.horizontalCenter
                padding: {
                    top: 0
                }
                font.pixelSize: Theme.fontSizeExtraSmall;
                color: {
                    // TODO: Add a method to provider (or currentPair?), that returns a value
                    // indicating the validity of the rate based on the pairs
                    // date and update interval.
                    //var diffTime = Math.round((now.getTime() - then.getTime())/1000)
                    // If the provider updates rates today
                    //var updateDay = provider.updateWeekdays.indexOf(now.getDay()) !== -1
                    //console.log(diffTime, '>', interval*1.5)

                    // TODO: Check that this takes updateDay properly into account
                    if(diffTime > interval*2 && updateDay) {
                        return '#800000'
                    } else if(diffTime > interval*1.5 && updateDay) {
                        return '#B39500'
                    } else if(diffTime > interval*1.2 && updateDay) {
                        return '#158000'
                    }

                    return Theme.secondaryHighlightColor
                }
                text: {
                    var str = (workOffline || !Env.isOnline) ? qsTr('Offline') : qsTr('Online. ')
                    // Apparently Qt doesn't support UTC or I don't know how?
                    // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/toLocaleString
                    str += shortDate(then) + ' UTC'
                    return str
                }
            }
        }
    }

    function switchCurrencies() {
        console.log('frontPage.switchCurrencies:', fromCode, toCode)
        var from = fromCombo.currentCurrencyCode
        fromCombo.currentCurrencyCode = toCombo.currentCurrencyCode
        toCombo.currentCurrencyCode = from

        // NOTE: Trigger activation. Forget why I need this..?
        fromCombo.currentCurrencyCode = fromCombo.currentCurrency.code
        toCombo.currentCurrencyCode = toCombo.currentCurrency.code
        // And go
        app.getRate()
    }
}
