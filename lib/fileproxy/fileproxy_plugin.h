#ifndef FILEPROXY_PLUGIN_H
#define FILEPROXY_PLUGIN_H

#include <QQmlExtensionPlugin>

class FileProxyPlugin : public QQmlExtensionPlugin {
    Q_OBJECT
    Q_PLUGIN_METADATA(IID QQmlExtensionInterface_iid)

public:
    void registerTypes(const char *uri) override;
};

#endif // FILEPROXY_PLUGIN_H

