/*
  Copyright (C) 2019 Thomas Tanghus
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

pragma Singleton

import QtQuick 2.6
import '.'

/* bool isBusy:   On startup isBusy is true until Currencies has been loaded.
 *                Don't start any requests when true. Use setBusy(true) before
 *                starting any requests. MAKE SURE to use setBusy(false) when
 *                done, or the UI will remain disabled!
 * bool isOnline: Is true when network is online, otherwise false. On startup
 *                it can take 1-2 seconds before it's registered. Monitor Env.isOnline
 *                for changes in connectivity.
 * bool isReady   Is false until Currencies are loaded. Same as Currencies.isReady
 */

QtObject {
    property bool _isBusy: false
    readonly property bool isReady: Currencies.isReady
    readonly property bool isOnline: network.isOnline // || false
    readonly property bool isBusy: (_isBusy || !Currencies.isReady)
    //onIsOnlineChanged: console.log('Env.isOnline:', isOnline)
    //onIsReadyChanged:  console.log('Env.isReady:', isReady)
    onIsBusyChanged:  console.log('Env.isBusy:', isBusy)

    // This is for setting before requesting a result and when it's received.
    // This stops request and other actions, blocks for user input and shows busy indicator.
    function setBusy(state) {
        //console.log('Setting busy:', state)
        _isBusy = state
    }

    property var network: {
        var component = Qt.createComponent(Qt.resolvedUrl('Network.qml'));
        if (component.status === Component.Error) {
            console.error(component.errorString());
            return 0;
        }

        return component.createObject();
    }
}
