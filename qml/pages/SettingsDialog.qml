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

Dialog {

    id: settingsDialog
    canAccept: changed
    allowedOrientations: Orientation.All //Portrait | Orientation.Landscape;
    property bool tmpWorkOffline: workOffline
    property int tmpNumDecimals: numDecimals
    property string info: ''
    property bool changed: tmpWorkOffline !== workOffline || tmpNumDecimals !== numDecimals

    SilicaFlickable {
        height: isPortrait ? Screen.height : Screen.width
        anchors.fill: parent
        quickScroll: true
        contentHeight: column.height
        VerticalScrollDecorator {}

        /*Label {
            id: infoBox
            visible: info
            parent: header.extraContent
            //text: "Extra content"
            text: info
            font.pixelSize: Theme.fontSizeExtraSmall
            wrapMode: Text.Wrap
            //y: header.height //+ Theme.paddingMedium
            width: settingsDialog.width - (Theme.paddingMedium * 2)
            anchors.horizontalCenter: parent.horizontalCenter
            padding: Theme.horizontalPageMargin
            //anchors.top: header.bottom
            anchors.leftMargin: Theme.paddingLarge
            anchors.rightMargin: Theme.paddingLarge
        }*/
        PullDownMenu {
            MenuItem {
                //: Remove the cached conversions
                text: qsTr('Empty cache');
                onClicked: {
                    //: The currency to convert from
                    Remorse.popupAction(settingsDialog, "Emptying cache", function() {
                    try {
                        storage.truncate(function(result) {
                            //enable Button again
                            enabled = true
                        })
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
        }
        Column {
            id: column
            //y: header.height + Theme.paddingMedium
            width: parent.width - (Theme.paddingMedium * 2)
            spacing: Theme.horizontalPageMargin
            padding: Theme.paddingMedium  //.horizontalPageMargin
            /*
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: header.bottom
            anchors.leftMargin: Theme.paddingLarge
            anchors.rightMargin: Theme.paddingLarge
            */

            /*DialogHeader {
                id: header;
                dialog: settingsDialog;
                title: qsTr("Settings")
            }*/
            SectionHeader {
                id: sectionHeaderGeneral
                text: qsTr('General settings')
            }
            TextSwitch {
                //anchors.rightMargin: Theme.paddingLarge
                text: qsTr('Work offline')
                description: qsTr('Use available locally stored exchange rates instead of querying online')
                checked: tmpWorkOffline
                onCheckedChanged: {
                    tmpWorkOffline = checked
                }
            }

            Slider {
                id: decimalsSlider
                label: qsTr('Number of decimals in result')
                width: parent.width
                minimumValue: 0
                maximumValue: 5
                value: numDecimals
                valueText: value
                stepSize: 1
                onValueChanged:  {
                    tmpNumDecimals = value
                }
            }
            SectionHeader {
                id: sectionProvidersGeneral
                text: qsTr('Exchange Rate Provider')
            }
            //Column {
            //    anchors.fill: parent
                ComboBox {
                    menu: ContextMenu {
                        MenuItem { text: "European Central Bank" }
                        MenuItem { text: "CurrencyLayer" }
                        MenuItem { text: "Fixer.io" }
                    }
                }
            //}
        }
    }
    Component.onCompleted: {
        console.log('SettingsDialog.onCompleted')
        if(info) {
            notifier.notify(qsTr('Notice'), info)
        }
    }
    onAccepted: {
        console.log('tmpWorkOffline:', tmpWorkOffline)
        console.log('workOffline:', workOffline)
        console.log('workOffline !== tmpWorkOffline:', workOffline !== tmpWorkOffline)
        console.log('isOnline:', isOnline)
        console.log('All:', !tmpWorkOffline && workOffline !== tmpWorkOffline && !isOnline)

        // If the user selected to work online, but the phone isn't
        // open the network connection dialog.
        if(workOffline && !tmpWorkOffline !== tmpWorkOffline && !isOnline) {
            console.log('Opening network!')
            networkIFace.openConnection()
        }
        // If the user chose to go from working offline to online,
        // and we are currently online, refresh .
        else if(workOffline && !tmpWorkOffline && isOnline) {
           getRate()
        }

        settings.workOffline =  workOffline = tmpWorkOffline
        settings.numDecimals = numDecimals = parseInt(tmpNumDecimals)
    }
}
