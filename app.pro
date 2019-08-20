# The name of your application
TARGET = harbour-currencyconverter

TEMPLATE = app

DEPLOYMENT_PATH = /usr/share/$${TARGET}
CONFIG += sailfishapp
CONFIG += sailfishapp_i18n
QT += dbus quick

SOURCES += \
    src/$${TARGET}.cpp

TRANSLATIONS += translations/*.ts

DISTFILES += qml/cover/CoverPage.qml \
    qml/harbour-currencyconverter.qml \
    qml/pages/FrontPage.qml \
    qml/pages/SettingsDialog.qml \
    qml/pages/SearchPage.qml \
    qml/pages/AboutPage.qml \
    qml/components/Settings.qml \
    qml/components/JSONListModel.qml \
    qml/components/CurrencyModel.qml \
    qml/components/CurrencyItem.qml \
    qml/components/CurrencyCombo.qml \
    qml/components/Notification.qml \
    qml/components/Storage.qml \
    harbour-currencyconverter.desktop

INSTALLS += flags
flags.files = flags
flags.path = $${DEPLOYMENT_PATH}


SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

CONFIG(release, debug|release) {
    DEFINES += QT_NO_DEBUG_OUTPUT
}
