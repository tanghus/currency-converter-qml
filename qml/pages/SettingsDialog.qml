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
    canAccept: false
    allowedOrientations: Orientation.All //Portrait | Orientation.Landscape;
    property bool tmpWorkOffline: workOffline
    property int tmpNumDecimals: numDecimals
    property string info: ''

    SilicaFlickable {
        height: isPortrait ? Screen.height : Screen.width
        anchors.fill: parent
        quickScroll: true
        VerticalScrollDecorator {}

        DialogHeader {
            id: header;
            dialog: settingsDialog;
            title: qsTr("Settings")
        }
        Label {
            id: infoBox
            visible: info
            parent: header.extraContent
            text: "Extra content"
            // text: info
        }
        PullDownMenu {
            MenuItem {
                text: qsTr('Empty cache');
                onClicked: {
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
            y: header.height + Theme.paddingMedium
            width: settingsDialog.width - (Theme.paddingMedium * 2)
            spacing: Theme.horizontalPageMargin
            anchors.horizontalCenter: parent.horizontalCenter
            padding: Theme.horizontalPageMargin
            anchors.leftMargin: Theme.paddingLarge
            anchors.rightMargin: Theme.paddingLarge

            TextSwitch {
                anchors.rightMargin: Theme.paddingLarge
                text: qsTr('Work offline')
                description: qsTr('Use available locally stored exchange rates instead of querying online')
                checked: tmpWorkOffline
                onCheckedChanged: {
                    tmpWorkOffline = checked
                    canAccept = workOffline === tmpWorkOffline ? false : true
                }
            }

            Slider {
                id: decimalsSlider
                label: qsTr('Number of decimals in result')
                width: parent.width
                minimumValue: 0
                maximumValue: 10
                value: numDecimals
                valueText: value
                stepSize: 1
                onValueChanged:  {
                    canAccept = numDecimals !== value
                    tmpNumDecimals = value
                }
            }
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

        console.log('About to open network!')
        if(!tmpWorkOffline && workOffline !== tmpWorkOffline && !isOnline) {
            console.log('Opening network!')
            networkIFace.openConnection()
        }

        settings.workOffle =  workOffline = tmpWorkOffline
        settings.numDecimals = numDecimals = parseInt(tmpNumDecimals)
        //saveSettings()
    }
}
