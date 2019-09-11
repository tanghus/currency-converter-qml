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
import QtQml.Models 2.3
import Sailfish.Silica 1.0
import '.'

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

    Column {
        id: headerContainer

        width: searchPage.width

        PageHeader {
            title: 'Currencies'
        }
    }

    DelegateModel {
        id: visualModel
        model: currencyModel
        delegate: currencyDelegate

        property var lessThan: [
            function(left, right) { return left.name < right.name },
            function(left, right) { return left.code < right.code }
        ]

        property int sortOrder: 0

        Component.onCompleted: {
            console.log('CurrencyList.visualModel.onCompleted. currentCurrencyCode:', currentCurrencyCode)

            items.setGroups(0, items.count, 'unsorted')

            var i
            for(i = 0; i < currencyModel.count; i++) {
                var item = currencyModel.get(i)
                if(item.code === currentCurrencyCode) {
                    console.log('Found:', item.code)
                    item.highlighted = true
                }
                console.log('Item:', i, JSON.stringify(item))
            }

            currencyList.currentIndex = 0

            for(i = 0; i < currencyList.count; i++) {
                var currentSelectedItem
                currentSelectedItem = visualModel.items.get(i).model;
                if(currentSelectedItem.code === currentCurrencyCode) {
                    console.log('currentItem.code:', currentSelectedItem.code)
                    currencyList.currentIndex = i
                    animateHighlighted.start()
                    currencyList.positionViewAtIndex(i, ListView.Beginning)
                    break
                }
            }
        }

        function setCurrentItem() {
            console.log('CurrencyList.visualModel.setCurrentItem. currentCurrencyCode:',
                        currentCurrencyCode)
            var idx = findByCode(currentCurrencyCode)
            if(!isNaN(idx)) {
                currencyList.currentIndex = idx
                animateHighlighted.start()
                currencyList.positionViewAtIndex(idx, ListView.Beginning)
            }
        }

        function findByCode(code) {
            for(var i = 0; i < count; i++) {
                console.log('findByCode:', JSON.stringify(items.get(i)))
                if(items.get(i).code === code) {
                    console.log('CurrencyList.currencyModel. Found:', i,
                                JSON.stringify(items.get(i)))
                    return i
                }
            }
            return null
        }

        function insertPosition(lessThan, item) {
            //console.log('lessThan item', lessThan, item)
            var lower = 0
            var upper = items.count
            while (lower < upper) {
                var middle = Math.floor(lower + (upper - lower) / 2)
                var result = lessThan(item.model, items.get(middle).model);
                if (result) {
                    upper = middle
                } else {
                    lower = middle + 1
                }
            }
            return lower
        }

        function sort(lessThan) {
            while (unsortedItems.count > 0) {
                var item = unsortedItems.get(0)
                var index = insertPosition(lessThan, item)

                item.groups = 'items'
                items.move(item.itemsIndex, index)
            }
        }

        items.includeByDefault: false

        groups: DelegateModelGroup {
            id: unsortedItems
            name: 'unsorted'

            includeByDefault: true

            onChanged: {
                if (visualModel.sortOrder === visualModel.lessThan.length) {
                    setGroups(0, count, "items")
                } else {
                    visualModel.sort(visualModel.lessThan[visualModel.sortOrder])
                }
            }
        }
    }

    SilicaListView {
        id: currencyList
        anchors {
            fill: parent
            topMargin: headerContainer.height + (Theme.paddingLarge*2)
        }
        property var currentSelectedItem

        signal currencySelected(var currency)

        VerticalScrollDecorator {}

        Component.onCompleted: {
            console.log('currencyList.onCompleted', currentItem.name);
        }

        /*onCurrentItemChanged:  {
            // Update the currently-selected item
            currentSelectedItem = visualModel.items.get(currentIndex).model;
            // Log the Display Role
            console.log('onCurrentItemChanged', currentSelectedItem.name);
        }*/

        model: visualModel
        //delegate: currencyDelegate
    }

    CurrencyModel {
        id: currencyModel

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

            // https://doc.qt.io/qt-5/qml-qtquick-layouts-rowlayout.html ?
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
                    //visible: source !== ''
                    //height: parent.height
                    //width: height
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


