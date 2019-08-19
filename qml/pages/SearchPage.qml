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
    allowedOrientations: Orientation.All

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
        anchors.fill: parent

        VerticalScrollDecorator {}

        JSONListModel {
            id: jsonModel1
            source: Qt.resolvedUrl('../components/currencies.json')
            //source: Qt.resolvedUrl('/home/thomas/currency-converter-qml/data/currencies.json')

            query: "$.store.book[*]"
        }
        model: jsonModel1.model

        /*delegate: ListItem {
            Label {
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                color: Theme.secondaryHighlightColor
                text: model.title + ':' + model.author
            }
        }*/
        delegate: BackgroundItem {
            id: backgroundItem

            ListView.onAdd: AddAnimation {
                target: backgroundItem
            }
            ListView.onRemove: RemoveAnimation {
                target: backgroundItem
            }

            Label {
                //x: searchField.textLeftMargin
                anchors.verticalCenter: parent.verticalCenter
                /*color: searchString.length > 0 ? (highlighted ? palette.secondaryHighlightColor : palette.secondaryColor)
                                               : (highlighted ? palette.highlightColor : palette.primaryColor)*/
                color: Theme.secondaryHighlightColor
                textFormat: Text.StyledText
                //text: Theme.highlightText(model.text, searchString, palette.highlightColor)
                text: model.title + ':' + model.author
            }
        }
    }

    /*SilicaListView {
        model: listModel
        anchors.fill: parent
        currentIndex: -1 // otherwise currentItem will steal focus
        header:  Item {
            id: header
            width: headerContainer.width
            height: headerContainer.height
            Component.onCompleted: headerContainer.parent = header
        }

        delegate: BackgroundItem {
            id: backgroundItem

            ListView.onAdd: AddAnimation {
                target: backgroundItem
            }
            ListView.onRemove: RemoveAnimation {
                target: backgroundItem
            }

            Label {
                x: searchField.textLeftMargin
                anchors.verticalCenter: parent.verticalCenter
                color: searchString.length > 0 ? (highlighted ? palette.secondaryHighlightColor : palette.secondaryColor)
                                               : (highlighted ? palette.highlightColor : palette.primaryColor)
                textFormat: Text.StyledText
                text: Theme.highlightText(model.text, searchString, palette.highlightColor)
            }
        }

        VerticalScrollDecorator {}

        Component.onCompleted: {
            if (keepSearchFieldFocus) {
                searchField.forceActiveFocus()
            }
            keepSearchFieldFocus = false
        }
    }*/

    ListModel {
        id: listModel

        // copied under creative commons license from Wikipedia
        // http://en.wikipedia.org/wiki/List_of_sovereign_states
        property var countries: ["Afghanistan", "Albania", "Algeria", "Andorra", "Angola",
            "Antigua and Barbuda", "Argentina", "Armenia", "Australia", "Austria",
            "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados",
            "Belarus", "Belgium", "Belize", "Benin", "Bhutan",
            "Bolivia", "Bosnia and Herzegovina", "Botswana", "Brazil", "Brunei",
            "Bulgaria", "Burkina Faso", "Burma", "Burundi", "Cambodia",
            "Cameroon", "Canada", "Cape Verde", "Central African Republic", "Chad",
            "Chile", "China", "Colombia", "Comoros", "Costa Rica",
            "Croatia", "Cuba", "Cyprus", "Czech Republic", "Denmark",
            "Djibouti", "Dominica", "Dominican Republic", "East Timor", "Ecuador",
            "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia",
            "Ethiopia", "Fiji", "Finland", "France", "Gabon",
            "Gambia", "Georgia", "Germany", "Ghana", "Greece",
            "Grenada", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana",
            "Haiti", "Honduras", "Hungary", "Iceland", "India",
            "Indonesia", "Iran", "Iraq", "Ireland", "Israel",
            "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan",
            "Kenya", "Kiribati", "Korea North", "Korea South", "Kuwait",
            "Kyrgyzstan", "Laos", "Latvia", "Lebanon", "Lesotho",
            "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg",
            "Macedonia", "Madagascar", "Malawi", "Malaysia", "Maldives",
            "Mali", "Malta", "Marshall Islands", "Mauritania", "Mauritius",
            "Mexico", "Micronesia", "Moldova", "Monaco", "Mongolia",
            "Montenegro", "Morocco", "Mozambique", "Namibia", "Nauru",
            "Nepal", "Netherlands", "New Zealand", "Nicaragua", "Niger",
            "Nigeria", "Norway", "Oman", "Pakistan", "Palau",
            "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines",
            "Poland", "Portugal", "Qatar", "Romania", "Russia",
            "Rwanda", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa",
            "San Marino", "Saudi Arabia", "Senegal", "Serbia", "Seychelles",
            "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon Islands",
            "Somalia", "South Africa", "South Sudan", "Spain", "Sri Lanka",
            "Sudan", "Suriname", "Swaziland", "Sweden", "Switzerland",
            "Syria", "Tajikistan", "Tanzania", "Thailand", "Togo",
            "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan",
            "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom",
            "United States", "Uruguay", "Uzbekistan", "Vanuatu", "Vatican City",
            "Venezuela", "Vietnam", "Yemen", "Zambia", "Zimbabwe",
            "Abkhazia", "Cook Islands", "Kosovo", "Nagorno-Karabakh", "Niue",
            "Northern Cyprus", "Palestine", "SADR", "Somaliland", "South Ossetia",
            "Taiwan"]

        function update() {
            var filteredCountries = countries.filter(function (country) { return country.toLowerCase().indexOf(searchString) !== -1 })

            var country
            var found
            var i

            // helper objects that can be quickly accessed
            var filteredCountryObject = new Object
            for (i = 0; i < filteredCountries.length; ++i) {
                filteredCountryObject[filteredCountries[i]] = true
            }
            var existingCountryObject = new Object
            for (i = 0; i < count; ++i) {
                country = get(i).text
                existingCountryObject[country] = true
            }

            // remove items no longer in filtered set
            i = 0
            while (i < count) {
                country = get(i).text
                found = filteredCountryObject.hasOwnProperty(country)
                if (!found) {
                    remove(i)
                } else {
                    i++
                }
            }

            // add new items
            for (i = 0; i < filteredCountries.length; ++i) {
                country = filteredCountries[i]
                found = existingCountryObject.hasOwnProperty(country)
                if (!found) {
                    // for simplicity, just adding to end instead of corresponding position in original list
                    append({ "text": country})
                }
            }
        }
    }
}
