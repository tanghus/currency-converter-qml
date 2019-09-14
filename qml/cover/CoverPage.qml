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

CoverBackground {
    id: cover
    property bool active: status === Cover.Active;
    signal switchCurrencies()

    Image {
        id: coverImage
        source: 'image://theme/harbour-currencyconverter'
        width: parent.height
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        opacity: 0.4
    }

    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        size: BusyIndicatorSize.Large
        running: Env.isBusy
    }

    ColumnLayout {
        Layout.preferredWidth: cover.width - (Theme.paddingMedium*2)
        Layout.alignment: Qt.AlignHCenter
        spacing: Theme.paddingMedium
        Label {
            text: qsTr('Currency Converter')
            font {
                bold: true
                pixelSize: Theme.fontSizeLarge
            }
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            Layout.preferredWidth: cover.width - (Theme.paddingMedium*3)
        }
        RowLayout {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Layout.preferredWidth: cover.width - (Theme.paddingMedium*2)
            Label {
                text: app.fromCode
                font.pixelSize: Theme.fontSizeSmall
                Layout.alignment: Qt.AlignBottom | Qt.AlignRight
                padding: {
                    right: Theme.paddingMedium
                    bottom: Theme.paddingSmall
                }
            }
            Label {
                text: Number(app.multiplier).toFixed(numDecimals)
                font.bold: true
                font.pixelSize: Theme.fontSizeLarge
                Layout.preferredWidth: (parent.width/2) - (Theme.paddingMedium*2)
                Layout.alignment: Qt.AlignBottom
                padding: {
                    left: Theme.paddingMedium
                    bottom: 0
                }
            }
        }

        Image {
            id: icon
            width: Theme.iconSizeMedium
            height: width
            Layout.preferredWidth: Theme.iconSizeMedium
            Layout.preferredHeight: Theme.iconSizeMedium
            Layout.alignment: Qt.AlignHCenter
            source: 'image://theme/icon-m-transfer'
            rotation: 180
            RotationAnimator {
                id: rotationAnimation
                target: icon
                from: 0
                to: 180
                duration: 180
                running: false
            }
        }
        RowLayout {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Layout.preferredWidth: cover.width - (Theme.paddingMedium*2)
            Label {
                text: app.toCode
                font.pixelSize: Theme.fontSizeSmall
                Layout.alignment: Qt.AlignBottom | Qt.AlignRight
                padding: {
                    right: Theme.paddingMedium
                    bottom: Theme.paddingSmall
                }
            }
            Label {
                text: qsTr("%L1").arg(app.result)
                font.bold: true
                font.pixelSize: Theme.fontSizeLarge
                Layout.alignment: Qt.AlignBottom
                Layout.preferredWidth: (parent.width/2) - (Theme.paddingMedium*2)
                padding: {
                    left: Theme.paddingMedium
                    bottom: 0
                }
            }
        }
    }

    CoverActionList {
        CoverAction {
            iconSource: "image://theme/icon-cover-refresh"
            onTriggered: {
                if(!Env.isBusy) {
                    getRate()
                }
            }
        }
        CoverAction {
            iconSource: "image://theme/icon-cover-transfers"
            onTriggered: {
                if(!Env.isBusy) {
                    rotationAnimation.start()
                    cover.switchCurrencies()
                }
            }
        }
    }
}


