TEMPLATE = lib
PROJECT = currencyconverter
TARGET = fileproxy
QT += quick
QT -= gui
CONFIG += qt plugin

TARGET = $$qtLibraryTarget($$TARGET)
target.path = /usr/share/harbour-$$PROJECT/lib/harbour/$$PROJECT/$$TARGET

uri = harbour.$$PROJECT.TARGET

# Input
SOURCES += \
    fileproxy.cpp \
    fileproxy_plugin.cpp

HEADERS += \
    fileproxy.h \
    fileproxy_plugin.h

OTHER_FILES = qmldir

qmldir.files += $$_PRO_FILE_PWD_/qmldir
qmldir.path += $$target.path

INSTALLS += target qmldir

#DISTFILES += \
#    ../../rpm/harbour-currencyconverter.spec \
#    ../../rpm/harbour-currencyconverter.yaml

