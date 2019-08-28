import QtQuick 2.0
import Nemo.Configuration 1.0

ConfigurationGroup {
    id: waypointer
    
    path: "/apps/harbour-currencyconverter"

    property string fromCode
    property string toCode

    // Usually the same as above, but can be e.g. £ or $
    property string fromSymbol
    property string toSymbol

    // The amount to multiply the rate with
    property double multiplier

    // The number of decimals to show the result with
    property int numDecimals

    // The last result before multiplication
    property double rate: 1.0

    property bool workOffline: true
}
