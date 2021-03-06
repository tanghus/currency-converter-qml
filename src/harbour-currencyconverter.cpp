/*
  Copyright (C) 2013-2019 Thomas Tanghus <thomas@tanghus.net>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <sailfishapp.h>
#include <QGuiApplication>
#include <QQuickView>
#include <QQmlContext>
#include <QLocale>
#include <QTranslator>
#include <QDebug>

int main(int argc, char *argv[]) {
    //QGuiApplication *app = SailfishApp::application(argc, argv);
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    app->setApplicationVersion(QString(APP_VERSION));
    qDebug() << "APP_VERSION" << APP_VERSION;
    app->setApplicationName(QStringLiteral("harbour-currencyconverter"));
    app->setApplicationDisplayName(QStringLiteral("Currency Converter"));
    //app->setApplicationVersion(QStringLiteral(VERSION_STRING));
    QQuickView *view = SailfishApp::createView();
    view->engine()->addImportPath(SailfishApp::pathTo("lib/").toLocalFile());
    qDebug() << "Components import path" << SailfishApp::pathTo("qml/components/").toLocalFile();
    view->engine()->addImportPath(SailfishApp::pathTo("qml/components/").toLocalFile());
    view->engine()->addImportPath(SailfishApp::pathTo("qml/pages/").toLocalFile());

    //qmlRegisterSingletonType(SailfishApp::pathTo("qml/components/Env.qml"), "harbour.currencyconverter.environment", 0, 1, "Env");

    QTranslator *translator = new QTranslator;

    QString locale = QLocale::system().name();
    QString translation = SailfishApp::pathTo("translations").toLocalFile() + "/" + locale + ".qm";

    qDebug() << "Active translation for:" << locale << ": " << translation;

    if(!translator->load(translation)) {
        qDebug() << "Couldn't load translation";
    }
    app->installTranslator(translator);

    // https://stackoverflow.com/questions/34109523/setting-localstorage-location-via-setofflinestoragepath
    view->rootContext()->setContextProperty("root", SailfishApp::pathTo("./").toLocalFile());
    view->setSource(SailfishApp::pathTo("qml/harbour-currencyconverter.qml"));
    view->showFullScreen();
    return app->exec();
}

