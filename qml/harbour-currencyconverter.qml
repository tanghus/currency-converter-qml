/*
  Copyright (C) 2013 Thomas Tanghus
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
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
//import org.nemomobile.configuration 1.0
import "cover"
import "pages"

ApplicationWindow {

    id: app;

    property string fromCode: 'USD';
    property string toCode: 'EUR';

    // Usually the same as above, but can be e.g. £ or $
    property string fromSymbol: '$';
    property string toSymbol: '€';

    // The amount to multiply the quote with
    property int multiplier: 1;

    // Refresh interval in seconds
    property int refreshInterval: 3600;

    // The last result before multiplication
    property string quote: '1';

    // The multiplied result
    property string result: '';

    property bool isBusy: false;

    signal startUp();

    initialPage: Component {
        id: frontPage;
        FrontPage {}
    }

    cover: Component {
        CoverPage {}
    }

    Component.onCompleted: {
        console.log('Ready');
        refreshInterval = settings.value('refreshInterval', 3600);
        fromCode = settings.value('currencyCodeFrom', 'USD');
        toCode = settings.value('currencyCodeTo', 'EUR');
        multiplier = settings.value('amount', 1);
        quote = settings.value('quote', '1');
        //startUp();
        getQuote();
    }

    Timer {
        id: timer;
        interval: refreshInterval * 60000;
        running: true;
        repeat: true;
        onTriggered: getQuote();
    }

    BusyIndicator {
        id: busyIndicator;
        anchors.centerIn: parent;
        size: BusyIndicatorSize.Large;
    }

    WorkerScript {
        id: myWorker
        source: Qt.resolvedUrl('js/provider.js')

        onMessage: {
            if(messageObject.quote) {
                result = String(messageObject.quote * multiplier);
            } else {
                console.log(messageObject.error);
            }
            setBusy(false);
        }
    }

    function getQuote() {
        if(isBusy) {
            return;
        }

        setBusy(true);

        if(timer.running) {
            timer.restart();
        }
        myWorker.sendMessage({'quote': fromCode + toCode});
    }

    function setBusy(state) {
        isBusy = state;
        busyIndicator.running = state;
    }
}


