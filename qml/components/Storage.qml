import QtQuick 2.6
import QtQuick.LocalStorage 2.0 as LS

QtObject {

    property string dbName: ''
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

    function _formatException(e) {
        console.trace()
        throw e
    }

    function _getDatabase() {
        if(_dbObj) {
            return _dbObj
        }

        if(!typeof dbName === 'string' || !dbName.trim()) {
            _formatException(new Error(qsTr('No table name has been set')))
        }

        try {
            _dbObj = LS.LocalStorage.openDatabaseSync(
                dbName, dbVersion, dbDescription, estimatedSize
            );
            return _dbObj
        } catch(e) {
            _formatException(e)
        }
    }

    function _getTable() {
        if(!_dbObj) {
            _getDatabase()
        }
        if(_hasTable) {
            return true
        }

        if(!typeof tblName === 'string' || !tblName.trim()) {
            _formatException(new Error(qsTr('No table name has been set')))
        }

        var keyString = '', tmpColumns = []
        var sql = 'CREATE TABLE IF NOT EXISTS ' + tblName
        console.log('Storage.getTable. SQL:', sql)

        // The columns
        // Use Map?
        // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Map#Iterating_Map_with_for..of
        for(var k in columns) {
            if (columns.hasOwnProperty(k)) {
                tmpColumns.push(k + ' ' + columns[k])
            }
        }
        sql += '(' + tmpColumns.join(',')
        console.log('Storage.getTable. SQL:', sql)

        // Any primary key?
        if(key) {
            keyString = key.join(',')
        }

        if(keyString) {
            sql += ', PRIMARY KEY(' + keyString + ')'
        }
        sql += ')'

        try {
            _dbObj.transaction(
                function(tx) {
                    tx.executeSql(sql)
                }
            )
            _hasTable = true
        } catch(e) {
            _formatException(e)
        }
        return true
    }

    /**
     * @param array fields An array with the names of the fields
     *   in the table, you want to have inserted/updated
     * @param array values An array of the values you want
     *   insert/update
     * @return undefined or throws exception
     */
    function set(fields, values) {
        _getTable()
        if(fields.length !== values.length) {
            _formatException(
                new Error(qsTr('The number of values must match the number of fields')))
        }
        if(!fields.length > 0) {
            _formatException(
                new Error(qsTr('The number of fields to update must be larger than one')))
        }

        var fieldsString = fields.join(',')
        var valuesString = values.join('","')
        var sql = 'INSERT OR REPLACE INTO ' + tblName
                + '(' + fieldsString + ')'
                + ' VALUES ("' + valuesString + '");'
        console.log('Storage.set() SQL:', sql);

        try {
            _dbObj.transaction(
                function(tx) {
                    tx.executeSql(sql)
                }
            )
        } catch(e) {
            _formatException(e)
        }
    }

    function get(fields, where, cb) {
        _getTable()

        var whereList = [], sql = 'SELECT '

        // Which fields to return
        if(Array.isArray(fields)) {
            sql += fields.join(',')
        } else if(typeof fields === 'string') {
            sql += fields
        } else {
            throw new Error(qsTr('fields must be a string or an array.'))
        }

        // The WHERE clauses
        sql += ' FROM '+ tblName +' WHERE '
        for(var w in where) {
            if (where.hasOwnProperty(w)) {
                console.log(w + " -> " + where[w]);
                whereList.push(w + '="' + where[w] + '"')
            }
        }
        sql += whereList.join(' AND ')
        //console.log('Storage.get() SQL:', sql)
        try {
            _dbObj.transaction(
                function(tx) {
                    tx.executeSql(sql)
                    var result = tx.executeSql(sql);

                    if (result.rows.length > 0) {
                        var row = result.rows.item(0);
                        cb(row);
                    } else {
                        // TODO: callback should contain result or error msg(?)
                        cb(false);
                    }
                }
            )
        } catch(e) {
            _formatException(e)
        }

    }

    function truncate(cb) {
        _getTable()

        var sql = 'DELETE FROM ' + tblName

        try {
            _dbObj.transaction(
                function(tx) {
                    tx.executeSql(sql)
                    var result = tx.executeSql(sql);

                    if (result.rows.length > 0) {
                        var row = result.rows.item(0);
                        cb(true);
                    } else {
                        // TODO: callback should contain result or error msg(?)
                        cb(false);
                    }
                }
            )
        } catch(e) {
            _formatException(e)
        }

    }
}
