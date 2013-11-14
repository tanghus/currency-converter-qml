import QtQuick 2.0
import Sailfish.Silica 1.0

MenuItem {
    property string code: '';
    property string numericCode: '';
    property string name: '';
    property string symbol: '';
    property variant countries: [];

    text: this.name; // + '(' + (code || symbol) + ')';
}
