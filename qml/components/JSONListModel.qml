/* JSONListModel - a QML ListModel with JSON and JSONPath support
 *
 * Copyright (c) 2012 Romain Pokrzywka (KDAB) (romain@kdab.com)
 * Licensed under the MIT licence (http://opensource.org/licenses/mit-license.php)
 * From: https://github.com/kromain/qml-utils/tree/master/JSONListModel
 */

import QtQuick 2.6
import "./jsonpath.js" as JSONPath

Item {
    property string source: ""
    property string json: ""
    property string query: ""

    property ListModel model : ListModel { id: jsonModel }
    property alias count: jsonModel.count

    onSourceChanged: {
        console.log('JSONListModel. Opening:', source)
        var xhr = new XMLHttpRequest;
        xhr.open("GET", source);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE)
                console.log('xhr.status:', xhr.status, xhr.statusText)
                json = xhr.responseText;
        }
        xhr.send();
    }

    Component.onCompleted: {
        console.log('JSONListModel.onCompleted. source:', source)
    }

    onJsonChanged: {
        updateJSONModel()
    }

    onQueryChanged: updateJSONModel()

    function updateJSONModel() {
        jsonModel.clear();

        if ( json === "" )
            return;

        var objectArray = parseJSONString(json, query);
        for ( var key in objectArray ) {
            var jo = objectArray[key];
            jsonModel.append( jo );
        }
    }

    function parseJSONString(jsonString, jsonPathQuery) {
        var objectArray = JSON.parse(jsonString);
        if ( jsonPathQuery !== "" )
            objectArray = JSONPath.jsonPath(objectArray, jsonPathQuery);

        return objectArray;
    }
}
