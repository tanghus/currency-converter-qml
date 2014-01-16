# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = harbour-currencyconverter

DEPLOYMENT_PATH = /usr/share/$${TARGET}

CONFIG += sailfishapp

SOURCES += \
    src/$${TARGET}.cpp \
    src/qmlsettings.cpp

TRANSLATIONS = \
    translations/da_DK.ts \
    translations/de_DE.ts \
    translations/en_GB.ts \
    translations/fi_FI.ts \
    translations/fr.ts \
    translations/it_IT.ts \
    translations/nl.ts \
    translations/pl_PL.ts \
    translations/ru.ts \
    translations/sv.ts \
    translations/zh_CN.ts

translations.files = translations
translations.path = $${DEPLOYMENT_PATH}

lupdate_only{
SOURCES = \
    qml/pages/FrontPage.qml \
    qml/pages/SettingsPage.qml \
    qml/pages/AboutPage.qml \
    qml/cover/CoverPage.qml \
    qml/components/CurrencyModel.qml
}

OTHER_FILES += \
    qml/cover/CoverPage.qml \
    qml/pages/FrontPage.qml \
    qml/pages/AboutPage.qml \
    qml/pages/SettingsPage.qml \
    qml/components/CurrencyModel.qml \
    qml/components/CurrencyItem.qml \
    qml/components/CurrencyCombo.qml \
    qml/harbour-currencyconverter.qml \
    transifex.sh \
    .travis.yml

lupdate_only {
    SOURCES += $${QML_FILES}
}

OTHER_FILES += \
    $${QML_FILES} \
    qml/js/provider.js \
    harbour-currencyconverter.desktop \
    rpm/harbour-currencyconverter.yaml \
    harbour-currencyconverter.desktop \
    qml/harbour-currencyconverter.qml \
    README.md \
    LICENSE

HEADERS += \
    src/qmlsettings.h

INSTALLS += translations
