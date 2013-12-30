# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = harbour-currencyconverter

#CONFIG += sailfishapp

QT += quick qml
CONFIG += link_pkgconfig
PKGCONFIG += sailfishapp
INCLUDEPATH += /usr/include/sailfishapp

TARGETPATH = /usr/bin
target.path = $${TARGETPATH}

DEPLOYMENT_PATH = /usr/share/$${TARGET}
qml.files = qml
qml.path = $${DEPLOYMENT_PATH}

desktop.files = $${TARGET}.desktop
desktop.path = /usr/share/applications

icon.files = $${TARGET}.png
icon.path = /usr/share/icons/hicolor/86x86/apps

INSTALLS += target icon desktop qml

SOURCES += \
    src/$${TARGET}.cpp \
    src/qmlsettings.cpp

QML_FILES = \
    qml/cover/CoverPage.qml \
    qml/pages/FrontPage.qml \
    qml/pages/AboutPage.qml \
    qml/pages/SettingsPage.qml \
    qml/pages/CurrencyModel.qml \
    qml/pages/CurrencyItem.qml \
    qml/pages/CurrencyCombo.qml \
    qml/harbour-currencyconverter.qml \

lupdate_only {
    SOURCES += $${QML_FILES}
}

OTHER_FILES += \
    $${QML_FILES} \
    qml/js/provider.js \
    harbour-currencyconverter.desktop \
    rpm/harbour-currencyconverter.yaml

HEADERS += \
    src/qmlsettings.h

