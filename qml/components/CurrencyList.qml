/*
  Copyright (C) 2013-2019 Thomas Tanghus
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

Page {
    id: searchPage
    property string searchString
    property bool keepSearchFieldFocus
    property string currentCurrencyCode: value
    signal currencySelected(var currency)
    allowedOrientations: Orientation.All

    SequentialAnimation {
        id: animateHighlighted
        PropertyAnimation {
            target: currencyList.currentItem
            properties: 'highlighted'
            to: true
            duration: 300
        }
        PropertyAnimation {
            target: currencyList.currentItem
            properties: 'highlighted'
            to: false
            duration: 1500
        }
    }

    // Temporaryly giving up on searching
    // onSearchStringChanged: currencyModel.update()
    Component.onCompleted: {
        console.log('CurrencyList.onCompleted. currentCurrencyCode:', currentCurrencyCode)
        var idx = currencyModel.findByCode(currentCurrencyCode)
        if(!isNaN(idx)) {
            currencyList.currentIndex = idx
            animateHighlighted.start()
            currencyList.positionViewAtIndex(idx, ListView.Beginning)
        }

        //currencyModel.update()
    }

    Column {
        id: headerContainer

        width: searchPage.width

        PageHeader {
            title: 'Currencies'
        }

        /*SearchField {
            id: searchField
            width: parent.width

            Binding {
                target: searchPage
                property: "searchString"
                value: searchField.text.toLowerCase().trim()
            }
        }*/
    }

    SilicaListView {
        id: currencyList
        anchors {
            fill: parent
            topMargin: headerContainer.height + Theme.paddingLarge
        }
        signal currencySelected(var currency)

        VerticalScrollDecorator {}

        model: currencyModel
        delegate: currencyDelegate
    }

    CurrencyModel {
        id: currencyModel

        function findByCode(code) {
            for(var i = 0; i < rowCount(); i++) {
                if(get(i).code === code) {
                    console.log('CurrencyList.currencyModel. Found:', JSON.stringify(get(i)))
                    return i
                }
            }
            return null
        }
    }

    Component {
        id: currencyDelegate
        ListItem {
            id: listItem
            onClicked: {
                console.log('CurrencyList.onClicked:', model.code, model.index)
                currencySelected(model)
                pageStack.pop()
            }

            ListView.onAdd: AddAnimation {
                target: listItem
            }
            ListView.onRemove: RemoveAnimation {
                target: listItem
            }

            Row {
                spacing: Theme.paddingMedium
                padding: Theme.paddingMedium
                anchors {
                    left: parent.left
                    leftMargin: Theme.horizontalPageMargin
                    right: parent.right
                    rightMargin: Theme.horizontalPageMargin
                    verticalCenter: parent.verticalCenter
                }
                Image {
                    source: Qt.resolvedUrl("../../flags/" + model.code.toLowerCase() + ".png")
                    anchors.verticalCenter: parent.verticalCenter
                    fillMode: Image.PreserveAspectFit
                }
                Label {
                    anchors.verticalCenter: parent.verticalCenter
                    color: listItem.highlighted ? Theme.highlightColor : Theme.primaryColor
                    textFormat: Text.StyledText
                    text: model.name + ' (' + model.code + ')'
                }
            }
        }
    }
}


