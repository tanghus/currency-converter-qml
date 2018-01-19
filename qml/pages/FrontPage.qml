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

import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

Page {
    id: frontPage;

    Timer {
        id: inputTimer;
        interval: 300;
        running: false;
        repeat: false;
        onTriggered: {
            multiplier = parseInt(amountText.text);
            getQuote();
        }
    }

    Connections {
        target: amountText;
        onTextChanged: {
            // Try not to refresh on every change.
            inputTimer.restart();
        }
    }

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr('About');
                onClicked: {
                    pageStack.push(Qt.resolvedUrl('AboutPage.qml'));
                }
            }
            MenuItem {
                text: qsTr('Open website');
                onClicked: Qt.openUrlExternally('http://finance.yahoo.com/currency-converter');
            }
            MenuItem {
                text: qsTr('Settings');
                onClicked: {
                    pageStack.push(Qt.resolvedUrl('SettingsPage.qml'));
                }
            }
            MenuItem {
                text: qsTr('Switch currencies');
                onClicked: {
                    setBusy(true);
                    var from = fromCombo.currentIndex;
                    fromCombo.currentIndex = toCombo.currentIndex;
                    toCombo.currentIndex = from;
                    setBusy(false);
                    getQuote();
                }
            }
            MenuItem {
                text: qsTr('Update');
                onClicked: getQuote();
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: frontPage.width;
            spacing: Theme.paddingLarge;
            anchors.leftMargin: Theme.paddingLarge
            anchors.rightMargin: Theme.paddingLarge
            PageHeader {
                title: qsTr('Currency Converter');
            }
            CurrencyCombo {
                id: fromCombo;
                label: qsTr('From');
                currentCurrency: fromCode;
                onActivated: {
                    console.log('fromCombo', currency.code);
                    fromCode = currency.code;
                    fromSymbol = currency.getSymbol();
                    getQuote();
                }
            }
            CurrencyCombo {
                id: toCombo;
                label: qsTr('To');
                currentCurrency: toCode;
                onActivated: {
                    console.log('toCombo', currency.code);
                    toCode = currency.code;
                    toSymbol = currency.getSymbol();
                    getQuote();
                }
            }

            Item {
                anchors.top: toCombo.bottom;
                anchors.topMargin: Theme.paddingLarge;
                Label {
                    anchors.leftMargin: Theme.paddingLarge;
                    anchors.top: parent.top;
                    anchors.left: parent.left;
                    id: fromSymbolLabel;
                    text: fromSymbol;
                }
                TextField {
                    anchors.left: fromSymbolLabel.right;
                    id: amountText;
                    text: multiplier;
                    //anchors.rightMargin: fromSymbolLabel.right;
                    width: Math.round(frontPage.width/3.5)
                    horizontalAlignment: TextInput.AlignRight;
                    inputMethodHints: Qt.ImhFormattedNumbersOnly;
                    validator: DoubleValidator {
                        decimals: 4;
                        notation: DoubleValidator.StandardNotation;
                    }
                }
                Label {
                    anchors.left: amountText.right;
                    text: ' =    ' + toSymbol + ' ' + result;
                    horizontalAlignment: Text.AlignHCenter;
                    verticalAlignment: Text.AlignBottom;
                }
                // Set the time updated. Use Date().toLocaleString(Qt.locale())
                Label {
                    width: parent.width;
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
                    font.pixelSize: Theme.fontSizeExtraSmall;
                    color: Theme.secondaryColor;
                    text: "";
                }
            }
        }
    }

    Connections {
        target: app;
        /* Saving this as it's useful for debugging
        onStartUp: {

        }*/
    }

}


