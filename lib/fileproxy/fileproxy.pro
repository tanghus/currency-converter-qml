PROJECT = currencyconverter
TEMPLATE = lib
TARGET = fileproxy
CONFIG += qt plugin c++11
QT += quick
QT -= gui

TARGET = $$qtLibraryTarget($$TARGET)
target.path = /usr/share/harbour-$$PROJECT/lib/harbour/$$PROJECT/$$TARGET
#uri = net.tanghus.qmlcomponents
uri = harbour.$$PROJECT.TARGET

SOURCES += \
    fileproxy.cpp \
    fileproxy_plugin.cpp

HEADERS += \
    fileproxy.h \
    fileproxy_plugin.h

DISTFILES = qmldir
qmldir.files += $$_PRO_FILE_PWD_/qmldir
qmldir.path += $$target.path
#OTHER_FILES = qmldir

INSTALLS += target qmldir

#!equals(_PRO_FILE_PWD_, $$OUT_PWD) {
#    copy_qmldir.target = $$OUT_PWD/qmldir
#    copy_qmldir.depends = $$_PRO_FILE_PWD_/qmldir
#    copy_qmldir.commands = $(COPY_FILE) "$$replace(copy_qmldir.depends, /, $$QMAKE_DIR_SEP)" "$$replace(copy_qmldir.target, /, $$QMAKE_DIR_SEP)"
#    QMAKE_EXTRA_TARGETS += copy_qmldir
#    PRE_TARGETDEPS += $$copy_qmldir.target
#}

#qmldir.files = qmldir
#unix {
#    installPath = $$[QT_INSTALL_QML]/$$replace(uri, \., /)
#    qmldir.path = $$installPath
#    target.path = $$installPath
#    INSTALLS += target qmldir
#}
