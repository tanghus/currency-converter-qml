#include "fileproxy.h"
#include <QUrl>
#include <QFileInfo>
#include <QStandardPaths>
#include <QDir>
#include <QJsonDocument>
#include <QDebug>

//#include <errno.h>
//#include <stdio.h>

FileProxy::FileProxy(QQuickItem *parent):
    QQuickItem(parent) {
    qDebug() << "FileProxy constructor."
             << "Cache folder: "
             << QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
}

FileProxy::~FileProxy() {
}

void FileProxy::setName(const QString &name)
{
    QString localName = name;
    qDebug() << "FileProxy.setName: " << name;
    if (m_file.fileName() != localName) {
        m_file.setFileName(localName);
        emit nameChanged(localName);
    }
}

QString FileProxy::fileName() const
{
    return QFileInfo(m_file).fileName();
}

bool FileProxy::rename(const QString &newName)
{
    bool success = m_file.rename(newName);
    if (success) {
        emit nameChanged(newName);
    }
    return success;
}

bool FileProxy::write(const QVariantMap &data)
{
    if (m_file.fileName().isEmpty()) {
        m_error = tr("empty name");
        return false;
    }
    QJsonDocument doc = QJsonDocument::fromVariant(data);
    if (doc.isNull()) {
        return false;
    }
    if (doc.isEmpty()) {
        m_error = tr("empty data");
        return false;
    }
    QByteArray json = doc.toJson();
    if (!m_file.open(QIODevice::WriteOnly | QIODevice::Truncate | QIODevice::Text)) {
        m_error = tr("cannot open file '%1' for writing: %2")
                .arg(m_file.fileName()).arg((m_file.errorString()));
        return false;
    }
    bool success = m_file.write(json) == json.size();
    m_file.close();
    return success;
}

QVariant FileProxy::read()
{
    if (m_file.fileName().isEmpty()) {
        m_error = tr("empty name");
        return QVariant();
    }
    if (!m_file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        m_error = tr("cannot open file '%1' for reading: %2")
                .arg(m_file.fileName()).arg((m_file.errorString()));
        return QVariant();
    }
    QByteArray json = m_file.readAll();
    m_file.close();
    QJsonParseError error;
    QJsonDocument doc = QJsonDocument::fromJson(json, &error);
    if (error.error != QJsonParseError::NoError) {
        m_error = tr("invalid JSON file '%1' at offset %2")
                .arg(error.errorString()).arg(error.offset);
        return QVariant();
    }
    return doc.toVariant();
}
