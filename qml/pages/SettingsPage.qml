/*
  Copyright (C) 2013 Thomas Tanghus
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

Dialog {

    property bool s_update: (refreshInterval > 0);

    Column {
        spacing: 10;
        anchors.fill: parent;
        anchors.leftMargin: Theme.paddingLarge;
        anchors.rightMargin: Theme.paddingLarge;
        DialogHeader {
        }
        TextSwitch {
            text: "Update";
            description: "Update exchange rate regularly";
            checked: refreshInterval > 0;
            onCheckedChanged: {
                //enable interval input
                s_update = interval.visible = checked;
            }
        }
        Row {
            visible: refreshInterval > 0;
            id: interval;
            Label {
                text: 'Update interval (minutes)';
            }
            TextField {
                id: intervalValue;
                text: refreshInterval;
                horizontalAlignment: TextInput.AlignRight;
                inputMethodHints: Qt.ImhFormattedNumbersOnly;
                validator: IntValidator {
                    bottom: 0;
                }
            }
        }
    }
    onDone: {
        if(result == DialogResult.Accepted) {
            refreshInterval = s_update ? parseInt(intervalValue.text) : 0;
            settings.setValue('refreshInterval', refreshInterval);
        }
    }
}
