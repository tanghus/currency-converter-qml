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
import QtQuick 2.6
import '.'

Storage {
    id: storage
    tblName: 'rates'
    // Use Map? https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Map
    columns: ({
        fromCode: 'TEXT',
        toCode: 'TEXT',
        rate: 'TEXT',
        date: 'TEXT'
    })
    key: ['fromCode', 'toCode']

    function setRate(from, to, rate, date) {
        console.log('App.storage.setRate()', from, to, rate, date)
        try {
            set(['fromCode', 'toCode', 'rate', 'date'],
                [from, to, rate, date])
        } catch(e) {
            console.warn(e.message)
        }
    }

    function getRate(from, to, cb) {
        console.log('Cache.getRate(', from, to, ')')
        if(!Env.isReady) { return }
        try {
            get(['*'], {'fromCode': from, 'toCode': to},
                function(rows) {
                    //console.log('Cache.getRate. rows:', JSON.stringify(rows))
                    cb(rows[0])
                })
        } catch(e) {
            console.warn(e.message)
            console.trace()
        }
    }

    function removeRate(from, to, cb) {
        console.log('Cache.removeRate(', from, to, ')')
        if(!Env.isReady) { return }
        try {
            // TODO: Return something useful instead of row
            remove({'fromCode': from, 'toCode': to},
                function(rows) { cb(rows[0]) })
        } catch(e) {
            console.warn(e.message)
            console.trace()
        }
    }

    // NOTE: Without using 'base' 'rate' precision will be... Unlikely, BUT
    // the timestamp will most likely cause it to be invalidated anyways, so...
    function getAvailable(base, cb) {
        try {
            executeSQL('SELECT DISTINCT toCode AS code, rate FROM rates',
                function(rows) {
                    console.log('Cache.getAvailable(', base, ') Rows:', rows.status)
                if(cb) {
                    cb(rows)
                }
            })
        } catch(e) {
            console.warn(e.message)
            console.trace()
        }
    }
}

