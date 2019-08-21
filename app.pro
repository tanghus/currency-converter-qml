# The name of your application
TARGET = harbour-currencyconverter

CONFIG += sailfishapp

# App version
DEFINES += APP_VERSION=\"\\\"$${VERSION}\\\"\"

DEPLOYMENT_PATH = /usr/share/$${TARGET}

SOURCES += \
    src/$${TARGET}.cpp

DISTFILES += qml/cover/CoverPage.qml \
    qml/$${TARGET}.qml \
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
    rpm/$${TARGET}.changes.in \
    rpm/$${TARGET}.changes.run.in \
    rpm/$${TARGET}.spec \
    rpm/$${TARGET}.yaml \
    translations/*.ts \
    $${TARGET}.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

# to disable building translations every time, comment out the
# following CONFIG line
#CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/*.ts

INSTALLS += flags
flags.files = flags
flags.path = $${DEPLOYMENT_PATH}
