/*
  Copyright (C) 2013 Thomas Tanghus
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
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

Page {
    id: page

    Connections {
        target: amountText;
        onTextChanged: {
            multiplier = parseInt(amountText.text);
            getQuote();
        }
    }

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: 'Settings'
                onClicked: pageStack.push(Qt.resolvedUrl('Settings.qml'))
            }
            MenuItem {
                text: 'Update'
                onClicked: getQuote();
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: 'Currency Converter'
            }
            ComboBox {
                id: fromCombo
                label: 'From'
                menu: ContextMenu {
                    Repeater {
                         model: CurrencyModel { id: currencyModelFrom }
                    }
                    onActivated: {
                        fromCombo.currentIndex = index;
                        var from = fromCombo.currentItem;
                        fromCode = from.code;
                        symbolFromText.text = from.getSymbol();
                        getQuote();
                        console.log(index, fromCode);
                    }
                }
            }
            ComboBox {
                id: toCombo
                label: 'To'
                menu: ContextMenu {
                    Repeater {
                         model: CurrencyModel { id: currencyModelTo }
                    }
                    onActivated: {
                        toCombo.currentIndex = index;
                        var to = toCombo.currentItem;
                        toCode = to.code;
                        symbolToText.text = to.getSymbol();
                        getQuote();
                        console.log(index, toCode);
                    }
                }
            }
            Row {
                TextField {
                    id: amountText;
                    text: multiplier;
                    horizontalAlignment: TextInput.AlignRight;
                    inputMethodHints: Qt.ImhNoPredictiveText;
                    validator: DoubleValidator {
                        decimals: 4;
                        notation: DoubleValidator.StandardNotation;
                    }
                }
                Label {
                    id: symbolFromText;
                    verticalAlignment: Text.AlignBottom;
                }
                Label {
                    text: ' = ';
                    horizontalAlignment: Text.AlignHCenter;
                    verticalAlignment: Text.AlignBottom;
                }
                TextField {
                    id: resultText;
                    readOnly: true;
                    horizontalAlignment: TextInput.AlignRight
                }
                Label {
                    id: symbolToText;
                    verticalAlignment: Text.AlignBottom;
                }
            }
        }
    }

    Connections {
        target: app;
        onNewResult: {
            resultText.text = value;
        }
        onStartUp: {
            var from = fromCombo.currentItem;
            fromCode = from.code;
            symbolFromText.text = from.getSymbol();

            var to = toCombo.currentItem;
            toCode = to.code;
            symbolToText.text = to.getSymbol();
        }
    }

}


