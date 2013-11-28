# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = net.tanghus.currencyconverter.sailfish

CONFIG += sailfishapp

SOURCES += \
    src/net.tanghus.currencyconverter.sailfish.cpp \
    src/qmlsettings.cpp
    src/qmlsettings.cpp

OTHER_FILES += \
    qml/cover/CoverPage.qml \
    qml/pages/Settings.qml \
    qml/pages/FrontPage.qml \
    qml/pages/CurrencyModel.qml \
    qml/pages/CurrencyItem.qml \
    qml/js/provider.js \
    net.tanghus.currencyconverter.sailfish.desktop \
    rpm/net.tanghus.currencyconverter.sailfish.yaml \
    qml/net.tanghus.currencyconverter.sailfish.qml \
    qml/pages/CurrencyMenuModel.qml

HEADERS += \
    src/qmlsettings.h

