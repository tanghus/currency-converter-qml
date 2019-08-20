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
//import QtQml 2.13
import QtQml 2.2
import Sailfish.Silica 1.0
import "../components"

Page {
    id: frontPage;
    allowedOrientations: Orientation.Portrait | Orientation.Landscape //defaultAllowedOrientations

    Timer {
        // This is used to update result
        // but only after a short delay
        id: inputTimer;
        interval: 300;
        running: false;
        repeat: false;
        onTriggered: {
            multiplier = parseFloat(amountText.text);
            //Qt.callLater(getRate);
            getRate();
        }
    }

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent
        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr('Test');
                onClicked: {
                    pageStack.push(Qt.resolvedUrl('SearchPage.qml'));
                }
            }
            MenuItem {
                text: qsTr('About');
                onClicked: {
                    pageStack.push(Qt.resolvedUrl('AboutPage.qml'));
                }
            }
            /*MenuItem {
                text: qsTr('Open website');
                onClicked: Qt.openUrlExternally('http://finance.yahoo.com/currency-converter');
            }*/
            MenuItem {
                text: qsTr('Settings');
                onClicked: {
                    pageStack.push(Qt.resolvedUrl('SettingsDialog.qml'));
                }
            }
            MenuItem {
                text: qsTr('Switch currencies');
                onClicked: {
                    setBusy(true);
                    var from = fromCombo.currentIndex;
                    fromCombo.currentIndex = toCombo.currentIndex;
                    toCombo.currentIndex = from;

                    // Trigger activation
                    fromCombo.currentCurrency = fromCombo.currentItem.code
                    toCombo.currentCurrency = toCombo.currentItem.code
                    setBusy(false);
                    // And go
                    getRate();
                }
            }
            MenuItem {
                text: qsTr('Update');
                onClicked: getRate
            }
        }

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: Screen.width - (Theme.paddingLarge * 2)
            spacing: Theme.paddingLarge
            anchors.centerIn: parent
            PageHeader {
                title: qsTr('Currency Converter')
            }
            CurrencyCombo {
                id: fromCombo
                label: qsTr('From')
                currentCurrency: fromCode
                onActivated: {
                    console.log('fromCombo', idx, currency.code, currency.getSymbol())
                    fromCode = currency.code
                    fromSymbol = currency.getSymbol()
                    getRate()
                }
            }
            CurrencyCombo {
                id: toCombo
                label: qsTr('To')
                currentCurrency: toCode
                onActivated: {
                    console.log('toCombo', idx, currency.code, currency.getSymbol())
                    toCode = currency.code
                    toSymbol = currency.getSymbol()
                    getRate()
                }
            }

            Row {
                id: resultItem
                anchors.horizontalCenter: parent.horizontalCenter
                //anchors.top: toCombo.bottom;
                //anchors.topMargin: Theme.paddingLarge;
                Label {
                    id: fromSymbolLabel;
                    text: fromSymbol;
                    //anchors.leftMargin: Theme.paddingLarge;
                    //anchors.top: parent.top;
                    //anchors.left: parent.left;
                }
                TextField {
                    id: amountText;
                    text: multiplier;
                    label: qsTr('Amount')
                    placeholderText: label
                    //anchors.left: fromSymbolLabel.right;
                    //anchors.rightMargin: fromSymbolLabel.right;
                    width: Math.round(frontPage.width/3.5)
                    horizontalAlignment: TextInput.AlignRight;
                    inputMethodHints: Qt.ImhFormattedNumbersOnly;
                    validator: DoubleValidator {
                        bottom: 0.1
                        decimals: numDecimals
                        notation: DoubleValidator.StandardNotation
                        //locale:
                    }
                    onTextChanged: {
                        // Try not to refresh on every change.
                        // NOTE: Would this delay it too much?
                        //Qt.callLater(inputTimer.restart);
                        console.log('Result 1:', text)
                        if(text.length > 0 && !isNaN(text) && parseFloat(text) > 0.0) {
                            inputTimer.restart();
                        } else if(isNaN(text)) {
                            text = 1
                        } else if(parseFloat(text) === 0) {
                            console.log('Change', text, 'to', 1.0, '?')
                        }
                        tmpResult = parseFloat(text)
                        console.log('Result 2:', text)
                    }
                    EnterKey.enabled: text.length > 0 && parseFloat(text) > 0.1
                    //EnterKey.iconSource: 'image://theme/icon-m-enter-next'
                    EnterKey.iconSource: "image://theme/icon-m-enter-accept"
                }
                Label {
                    //anchors.left: amountText.right;
                    //: Just localizing the result. NOT to be translated
                    text: ' =    ' + toSymbol + ' ' + qsTr("%L1").arg(result);
                    horizontalAlignment: Text.AlignHCenter;
                    verticalAlignment: Text.AlignBottom;
                }
                // Set the time updated. Use Date().toLocaleString(Qt.locale())
                /*Label {
                    width: parent.width;
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
                    font.pixelSize: Theme.fontSizeExtraSmall;
                    color: Theme.secondaryColor;
                    text: "";
                }*/
            }
            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                //anchors.top: resultItem.bottom;
                //anchors.topMargin: Theme.paddingLarge
                font.pixelSize: Theme.fontSizeExtraSmall
                color: Theme.secondaryHighlightColor
                text: (workOffline || !isOnline)
                      ? qsTr('Working offline')
                      : qsTr('Working online')
                Component.onCompleted: {
                    console.log('Small notice Ready. workOffline?', (workOffline || !isOnline) ? true : false)
                    console.log('Small notice Ready. workOffline?', workOffline)
                    console.log('Small notice Ready. isOnline?', isOnline)
                }

            }
        }
    }

    // NOTE: Remove this before release
    Component.onCompleted: {
        console.log('FrontPage.Ready')
    }
}


