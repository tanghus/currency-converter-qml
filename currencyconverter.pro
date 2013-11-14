# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = net.tanghus.currencyconverter

CONFIG += sailfishapp

SOURCES += src/currencyconverter.cpp

OTHER_FILES += \
    qml/cover/CoverPage.qml \
    rpm/net.tanghus.currencyconverter.spec \
    rpm/net.tanghus.currencyconverter.yaml \
    qml/net.tanghus.currencyconverter.qml \
    net.tanghus.currencyconverter.desktop \
    qml/pages/Settings.qml \
    qml/pages/FrontPage.qml \
    qml/pages/CurrencyModel.qml \
    qml/pages/CurrencyItem.qml \
    qml/js/provider.js

