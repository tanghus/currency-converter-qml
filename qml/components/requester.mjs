/*
Copyright (c) 2019 Thomas Tanghus

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
//import "utils.js" as Utils

WorkerScript.onMessage = function(message) {
    var url = message.url.supplant(message.args)
    console.log('Requester.onMessage', JSON.stringify(message))
    console.log('Requester.onMessage. url:', url)

    var xhr = new XMLHttpRequest();
    xhr.timeout = 3000;

    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            if(xhr.status >= 200 && xhr.status < 300) {
                console.log('requester: status/size:', xhr.status, xhr.statusText, xhr.responseText.length)
                var result = JSON.parse(xhr.responseText);

                WorkerScript.sendMessage({'status': 'success', result: result, request: message});

            } else {
                console.log('requester.js', xhr.statusText, JSON.parse(xhr.responseText).error);
                WorkerScript.sendMessage({
                        status: 'error',
                        error: xhr.statusText,
                        message: JSON.parse(xhr.responseText).error,
                        request: message
                    }
                );
            }
        }
    }

    xhr.onTimeout = function() {
        WorkerScript.sendMessage({error: 'Request timed out'});
    }

    xhr.open('GET', url, true);
    xhr.send();
}


String.prototype.supplant = function (o) {
    try {
        return this.replace(/{([^{}]*)}/g,
            function (a, b) {
                var r = o[b];
                    return typeof r === 'string' || typeof r === 'number' ? r : a;
            }
        );
    } catch(e) {

    }
};


