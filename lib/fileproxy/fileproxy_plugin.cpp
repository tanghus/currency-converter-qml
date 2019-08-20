#include "fileproxy_plugin.h"
#include "fileproxy.h"

#include <qqml.h>

void FileProxyPlugin::registerTypes(const char *uri)
{
    // @uri harbour.currencyconverter.fileproxy
    qmlRegisterType<FileProxy>(uri, 1, 0, "FileProxy");
}


