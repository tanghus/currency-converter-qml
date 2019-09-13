/*
  Copyright (C) 2013-2014 Marko Koschak (marko.koschak@tisno.de)
  All rights reserved.

  This file was originally part of ownKeepass:
  https://github.com/jobe-m/ownkeepass

  Modification by Thomas Tanghus <thomas@tanghus.net>

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.

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

  The reason for using this, instead of Nemo.Notifications, is to have a Notification
  object that stays in-app, and doesn't litter the Event screen.
*/

import QtQuick 2.6
import Sailfish.Silica 1.0

MouseArea {
    id: infoPopup

    property string summary: ''
    property string body: ''
    property int timeout: 10
    /*
    property string previewSummary: summary
    property string previewBody: body
    property int expireTimeout: 0
    property bool isTransient: true
    property int replacesId: 0
    */

    function notify(nSummary, nBody) {
        summary = nSummary
        body = nBody = nBody ? nBody : ''
        console.log('Trying to publish a notification..%1: %2', nSummary, nBody)
        console.trace()
        publish()
    }

    function publish() {
        _timeout = timeout * 1000
        if (_timeout !== 0) {
            console.log('Restarting timer:', _timeout)
            countdown.restart()
        }
        // where does this 'state' come from? MouseArea?
        state = "active"
    }

    function cancel() {
        _close()
        closed()
    }

    function _close() {
        if (_timeout !== 0) countdown.stop()
        state = ""
    }

    property int _timeout: 0

    signal closed

    opacity: 0.0
    visible: false
    width: parent ? parent.width : Screen.width
    height: column.height + Theme.paddingMedium * 2 + colorShadow.height
    z: 1

    onClicked: cancel()

    states: State {
        name: "active"
        PropertyChanges { target: infoPopup; opacity: 1.0; visible: true }
    }
    transitions: [
        Transition {
            to: "active"
            SequentialAnimation {
                PropertyAction { target: infoPopup; property: "visible" }
                FadeAnimation {}
            }
        },
        Transition {
            SequentialAnimation {
                FadeAnimation {}
                PropertyAction { target: infoPopup; property: "visible" }
            }
        }
    ]

    Rectangle {
        id: infoPopupBackground
        anchors.fill: column
        //x: Theme.paddingSmall + Theme.paddingMedium
        //width: parent.width - ((Theme.paddingMedium * 2) + (Theme.paddingSmall * 2))
        //height: titleLabel.height + messageLabel.height + Theme.paddingMedium * 2
        radius: 25
        color: Theme.highlightBackgroundColor
        //color: highlightBackgroundFromColor(Theme.highlightBackgroundColor, Theme.LightOnDark)
    }

    Rectangle {
        id: colorShadow
        anchors.fill: column
        //x: Theme.paddingSmall + Theme.paddingMedium
        //width: parent.width - ((Theme.paddingMedium * 2) + (Theme.paddingSmall * 2))
        //height: titleLabel.height + messageLabel.height + Theme.paddingMedium * 2
        radius: 25
        color: Theme.highlightBackgroundColor
    }

    OpacityRampEffect {
        sourceItem: colorShadow
        slope: 0.5
        offset: 0.0
        clampFactor: -0.5
        direction: 2 // TtB
    }

    Column {
        id: column
        x: Theme.paddingMedium
        y: Theme.paddingMedium
        width: parent.width - Theme.paddingMedium * 2
        height: children.height
        Label {
            id: titleLabel
            text: summary
            width: parent.width - Theme.paddingMedium * 2
            padding: Theme.paddingMedium
            horizontalAlignment: Text.AlignLeft
            font.family: Theme.fontFamilyHeading
            font.pixelSize: Theme.fontSizeLarge
            opacity: 0.6
            truncationMode: TruncationMode.Fade
            color: Theme.darkPrimaryColor
        }
        Label {
            id: messageLabel
            text: body
            width: parent.width - Theme.paddingMedium * 2
            padding: Theme.paddingMedium
            horizontalAlignment: Text.AlignLeft
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSizeSmall
            color: Theme.darkSecondaryColor
            opacity: 0.5
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        }
    }

    Timer {
        id: countdown
        running: false
        repeat: false
        interval: _timeout

        function restart() { running = true }

        function stop() { running = false }

        onTriggered: _close()
    }
}
