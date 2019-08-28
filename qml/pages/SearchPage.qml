/****************************************************************************************
**
** Copyright (C) 2013 Jolla Ltd.
** Contact: Joona Petrell <joona.petrell@jollamobile.com>
** All rights reserved.
** 
** This file is part of Sailfish Silica UI component package.
**
** You may use this file under the terms of BSD license as follows:
**
** Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are met:
**     * Redistributions of source code must retain the above copyright
**       notice, this list of conditions and the following disclaimer.
**     * Redistributions in binary form must reproduce the above copyright
**       notice, this list of conditions and the following disclaimer in the
**       documentation and/or other materials provided with the distribution.
**     * Neither the name of the Jolla Ltd nor the
**       names of its contributors may be used to endorse or promote products
**       derived from this software without specific prior written permission.
** 
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
** ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
** DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
** ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
** (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
** LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
** ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
** SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**
****************************************************************************************/

import QtQuick 2.6
import Sailfish.Silica 1.0
import "../components"

Page {
    id: searchPage
    property string searchString
    property bool keepSearchFieldFocus
    property variant translation
    allowedOrientations: Orientation.All

    onTranslationChanged: {
        console.log('Translation changed:', translation)
    }

    Column {
        id: headerContainer

        width: searchPage.width

        PageHeader {
            title: 'Currencies'
        }

        SearchField {
            id: searchField
            width: parent.width

            Binding {
                target: searchPage
                property: "searchString"
                value: searchField.text.toLowerCase().trim()
            }
        }
    }

    SilicaListView {
        anchors {
            fill: parent
            leftMargin: Theme.paddingLarge
            rightMargin: Theme.paddingLarge
            topMargin: headerContainer.height + Theme.paddingLarge
        }

        VerticalScrollDecorator {}

        JSONListModel {
            id: jsonModel
            source: 'https://api.exchangeratesapi.io/latest'
            //source: Qt.resolvedUrl('../components/currencies.json')
        }
        model: jsonModel.model

        delegate: BackgroundItem {
            id: backgroundItem
            onClicked: console.log('Clicked on:', model.code)

            ListView.onAdd: AddAnimation {
                target: backgroundItem
            }
            ListView.onRemove: RemoveAnimation {
                target: backgroundItem
            }

            Row {
                spacing: Theme.paddingMedium
                Image {
                    source: Qt.resolvedUrl("../../flags/" + model.code.toLowerCase() + ".png")
                    anchors.verticalCenter: parent.verticalCenter
                    fillMode: Image.PreserveAspectFit
                }
                Label {
                    anchors.verticalCenter: parent.verticalCenter
                    color: Theme.secondaryHighlightColor
                    textFormat: Text.StyledText
                    text: model.code + ': ' + translation[model.code].name // model.rate
                }
            }
        }
    }

    function getCurrencyTranslation() {
        var locale = Qt.locale().name
        if(locale === 'C') {
            locale = 'en_GB'
        }

        var url = Qt.resolvedUrl('../../data/currencies_{locale}.json'.replace('{locale}', locale))
        console.log('Locale:', locale)
        console.log('URL:', url)
        var xhr = new XMLHttpRequest
        xhr.open("GET", url)
        xhr.onreadystatechange = function() {
            console.log('xhr.readyState:', xhr.readyState, XMLHttpRequest.DONE)
            console.log('xhr.status:', xhr.status, xhr.statusText)
            if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                console.log('Got it')
                translation = JSON.parse(xhr.responseText)
            }
        }
        xhr.send();
    }

    Component.onCompleted: {
        translation = getCurrencyTranslation()
    }
}
