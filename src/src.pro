TEMPLATE = app

TARGET = harbour-currencyconverter

# App version
DEFINES += APP_VERSION=\"\\\"$${VERSION}\\\"\"

CONFIG += sailfishapp

QT += dbus quick
#declarative

SOURCES += \
    $${TARGET}.cpp

#HEADERS += qmlsettings.h

CONFIG(release, debug|release) {
    DEFINES += QT_NO_DEBUG_OUTPUT
}
