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
import QtQuick.LocalStorage 2.0 as LS

QtObject {

    property string dbName: ''
    // TODO: Change this to: property var tables: []
    property string tblName: ''
    property string dbDescription: dbName;
    // TODO: Check what database version means
    property string dbVersion: ''
    property var columns: ({})
    property var key

    // Estimated size of DB in bytes. Just a hint for the engine and is ignored as of Qt 5.0 I think
    property int estimatedSize: 10000
    property var _dbObj
    property bool _hasTable: false

    Component.onCompleted: {
        _dbObj = _getDatabase()
        _hasTable = _getTable()
    }

    function _formatException(e, cb) {
        console.log(e)
        console.trace()

        if(cb) {
            var response = {'status': 'error', 'message': e.message}
            cb(response)
        }

        //throw e
    }

    // TODO: Use callback method if provided
    function _getDatabase(cb) {
        if(_dbObj) {
            return _dbObj
        }

        if(!typeof dbName === 'string' || !dbName.trim()) {
            _formatException(new Error(qsTr('No database name has been set')),
                function(response) {
                    if(cb) { cb(response) }
            })
        } else {
            try {
                _dbObj = LS.LocalStorage.openDatabaseSync(
                            dbName, dbVersion, dbDescription, estimatedSize
                            );
                if(cb) { cb({'status':'success','result':[]}) }
                return _dbObj
            } catch(e) {
                _formatException(e, function(response) {
                    if(cb) { cb(response) }
                })
            }
        }
    }

    function _getTable(cb) {

        var response = {}

        if(!_dbObj) {
            _getDatabase()
        }
        if(_hasTable) {
            return true
        }

        if(typeof tblName !== 'string' || !tblName.trim()) {
            _formatException(new Error(qsTr('No table name has been set')),
                function(response) {
                    if(cb) { cb(response) }
            })
            return false
        }

        var keyString = '', tmpColumns = []
        var sql = 'CREATE TABLE IF NOT EXISTS ' + tblName

        // The columns
        for(var k in columns) {
            if (columns.hasOwnProperty(k)) {
                tmpColumns.push(k + ' ' + columns[k])
            }
        }
        tmpColumns.push('timestamp DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP')
        sql += '(' + tmpColumns.join(',')

        // Any primary key?
        if(key) {
            keyString = key.join(',')
        }

        if(keyString) {
            sql += ', PRIMARY KEY(' + keyString + ')'
        }
        sql += ')'

        //console.log('Storage._getTable. SQL:', sql)
        try {
            _dbObj.transaction(
                function(tx) {
                    tx.executeSql(sql)
                }
            )
            _hasTable = true
        } catch(e) {
            _formatException(e, function(response) {
                if(cb) { cb(response) }
            })
        }

        if(cb) { cb({'status':'success','result':[]}) }
        return true
    }

    /**
     * @param array fields An array with the names of the fields
     *   in the table, you want to have inserted/updated
     * @param array values An array of the values you want
     *   insert/update
     * @return undefined or throws exception
     */
    function set(fields, values, cb) {
        //_getTable()
        if(fields.length !== values.length) {
            _formatException(
                new Error(qsTr('The number of values must match the number of fields')))
        }
        if(!fields.length > 0) {
            _formatException(
                new Error(qsTr('At least one field to update must be specified')),
                    function(response) {
                        if(cb) { cb(response)
                        }})
            return
        }

        var fieldsString = fields.join(',')
        var valuesString = values.join('","')
        var sql = 'INSERT OR REPLACE INTO ' + tblName
                + '(' + fieldsString + ')'
                + ' VALUES ("' + valuesString + '");'
        console.log('Storage.set() SQL:', sql);
        executeSQL(sql, function(response) {
            if(cb) { cb(response) }
        })
    }

    function get(fields, where, cb) {
        //_getTable()

        var whereList = [], sql = 'SELECT '

        // Which fields to return
        if(Array.isArray(fields)) {
            sql += fields.join(',')
        } else if(typeof fields === 'string') {
            sql += fields
        } else {
            _formatException(
                new Error(qsTr('fields must be a string or an array.')),
                    function(response) {
                        if(cb) { cb(response)
                    }})
            return
        }

        // The WHERE clauses
        sql += ' FROM '+ tblName +' WHERE '
        for(var w in where) {
            if (where.hasOwnProperty(w)) {
                //console.log(w + " -> " + where[w]);
                whereList.push(w + '="' + where[w] + '"')
            }
        }
        sql += whereList.join(' AND ')
        console.log('Storage.get() SQL:', sql)
        executeSQL(sql, function(response) {
            if(cb) { cb(response) }
        })
    }

    function remove(where, cb) {
        _getTable()

        var whereList = [], sql = 'DELETE FROM ' + tblName

        // The WHERE clauses
        sql += ' WHERE '
        for(var w in where) {
            if (where.hasOwnProperty(w)) {
                //console.log(w + " -> " + where[w]);
                whereList.push(w + '="' + where[w] + '"')
            }
        }
        sql += whereList.join(' AND ')
        console.log('Storage.remove() SQL:', sql)
        executeSQL(sql, function(response) {
            if(cb) { cb(response) }
        })
    }

    function truncate(cb) {
        _getTable()

        var sql = 'DELETE FROM ' + tblName
        console.log('Storage.truncate. SQL:', sql)

        executeSQL(sql, function(response) {
            if(cb) { cb(response) }
        })
    }

    function executeSQL(sql, cb) {
        console.log('Storage.executeSQL:', sql)
        _getTable()

        try {
            _dbObj.transaction(
                function(tx) {
                    var result = tx.executeSql(sql);

                    //console.log('Storage.getFromSQL:', JSON.stringify(result.rows))
                    console.log('Storage.executeSQL. rows.length:', result.rows.length)
                    var rows = []
                    for (var i = 0; i < result.rows.length; i++) {
                        rows.push(result.rows.item(i))
                        //console.log(JSON.stringify(rows[i]))
                    }
                    if(cb) {
                        var response = {'status':'success','result':rows}
                        cb(response);
                    }
                }
            )
        } catch(e) {
            _formatException(e, function(response) {
                if(cb) { cb(response) }
            })
        }
    }
}
