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
import Sailfish.Silica 1.0

CoverBackground {

    property bool active: status === Cover.Active;

    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        size: BusyIndicatorSize.Large
        running: isBusy && active
    }

    Column {
        anchors.fill: parent;
        anchors {
            topMargin:  Theme.paddingLarge
            leftMargin: Theme.paddingLarge
            rightMargin: Theme.paddingLarge
        }
        Label {
            text: qsTr('Currency')
            font {
                bold: true
                family: Theme.fontFamilyHeading
                pixelSize: Theme.fontSizeLarge
            }
            width: parent.width
            truncationMode: TruncationMode.Fade
            horizontalAlignment: Text.AlignHCenter
        }
        Label {
            text: qsTr('Converter')
            font.bold: true
            font.family: Theme.fontFamilyHeading
            font.pixelSize: Theme.fontSizeLarge
            width: parent.width
            truncationMode: TruncationMode.Fade
            horizontalAlignment: Text.AlignHCenter
        }
        Label {
            text: fromSymbol + ' ' + multiplier
            font.pixelSize: Theme.fontSizeLarge
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
            width: parent.width
        }
        Label {
            text: ' = '
            font.pixelSize: Theme.fontSizeLarge
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }
        Label {
            text: toSymbol + ' ' + qsTr("%L1").arg(result)
            font.pixelSize: Theme.fontSizeLarge
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }
    }

    CoverActionList {
        id: coverActionSync

        CoverAction {
            iconSource: "image://theme/icon-cover-refresh"
            onTriggered: getRate()
        }
    }
}


