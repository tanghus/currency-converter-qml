#ifndef FILEPROXY_PLUGIN_H
#define FILEPROXY_PLUGIN_H

#include <QQmlExtensionPlugin>

class FileProxyPlugin : public QQmlExtensionPlugin {
    Q_OBJECT
    Q_PLUGIN_METADATA(IID QQmlExtensionInterface_iid)
    //Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri) override;
    /*void registerTypes(const char *uri) override {
            Q_ASSERT(uri == QLatin1String("FileProxy"));
            qmlRegisterType<FileProxy>(uri, 1, 0, "FileProxy");
    }*/
};

#endif // FILEPROXY_PLUGIN_H

