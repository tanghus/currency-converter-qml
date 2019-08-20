#ifndef FILEPROXY_PLUGIN_H
#define FILEPROXY_PLUGIN_H

#include <QQmlExtensionPlugin>

class FileProxyPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri);
};

#endif // FILEPROXY_PLUGIN_H

