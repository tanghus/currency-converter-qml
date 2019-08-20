# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-currencyconverter

DEPLOYMENT_PATH = /usr/share/$${TARGET}

#QT += qml quick

#CONFIG += sailfishapp

#SOURCES += \
#    src/$${TARGET}.cpp

#HEADERS += \
#    src/qmlsettings.h

#DISTFILES += qml/harbour-currencyconverter.qml \
#    Changelog \
#    LICENSE \
#    README.md \
#    TODO \
#    flags/*.png \
#    qml/cover/CoverPage.qml \
#    rpm/harbour-currencyconverter.changes.in \
#    rpm/harbour-currencyconverter.changes.run.in \
#    rpm/harbour-currencyconverter.spec \
#    rpm/harbour-currencyconverter.yaml \
#    translations/*.ts \
#    harbour-currencyconverter.desktop \
#    translations/pl_PL.ts

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


# NOTE: This is supposed to install icons, but craps out with
# File not found: /home/deploy/installroot/usr/share/icons/hicolor/*/apps/harbour-currencyconverter.png
SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172
#SAILFISHAPP_ICONS = icons

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.

# TRANSLATION
#lupdate_only{
# Add .qml files here
#}
TRANSLATIONS += translations/*.ts

INSTALLS += flags
flags.files = flags
flags.path = $${DEPLOYMENT_PATH}

#icons.files = icons
#icons.path = /usr/share/icons

#desktop.files = $${TARGET}.desktop
#desktop.path = /usr/share/applications

TEMPLATE = subdirs
SUBDIRS += src/fileproxy src
