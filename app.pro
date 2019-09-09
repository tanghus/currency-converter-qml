# The name of your application
TARGET = harbour-currencyconverter

CONFIG += sailfishapp

# App version
DEFINES += APP_VERSION=\"\\\"$${VERSION}\\\"\"

DEPLOYMENT_PATH = /usr/share/$${TARGET}

SOURCES += \
    src/$${TARGET}.cpp

OTHER_FILES += Changelog README.md icons flags

DISTFILES += qml/cover/CoverPage.qml \
    TODO.md \
    qml/$${TARGET}.qml \
    qml/components/Currencies.qml \
    qml/components/Currency.qml \
    qml/components/CurrencyCombo.qml \
    qml/components/CurrencyModel.qml \
    qml/components/CurrencyPair.qml \
    qml/components/qmldir \
    qml/components/Env.qml \
    qml/components/Network.qml \
    qml/components/ExchangeRatesAPIProvider.qml \
    qml/components/ExchangeProvider.qml \
    qml/components/Requester.qml \
    qml/components/Settings.qml \
    qml/components/CurrencyList.qml \
    qml/components/Notification.qml \
    qml/components/Storage.qml \
    qml/pages/FrontPage.qml \
    qml/pages/SettingsDialog.qml \
    qml/pages/AboutPage.qml \
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
#TRANSLATIONS += translations/*.ts

INSTALLS += flags
flags.files = flags
flags.path = $${DEPLOYMENT_PATH}

INSTALLS += data
data.files = data
data.path = $${DEPLOYMENT_PATH}
