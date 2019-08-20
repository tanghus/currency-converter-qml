#ifndef FILEPROXY_H
#define FILEPROXY_H

#include <QQuickItem>
#include <QObject>
#include <QFile>
#include <QVariant>

class FileProxy : public QQuickItem {
    Q_OBJECT
    Q_DISABLE_COPY(FileProxy)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString fileName READ fileName NOTIFY nameChanged)
    Q_PROPERTY(bool exists READ exists)
    Q_PROPERTY(bool writeable READ writeable)
    Q_PROPERTY(bool readable READ readable)
    Q_PROPERTY(qint64 size READ size)
    Q_PROPERTY(QString error READ error)

public:
    FileProxy(QQuickItem *parent = 0);
    ~FileProxy();

    inline QString name() const { return m_file.fileName(); }
    QString fileName() const;
    inline bool exists() const { return m_file.exists(); }
    inline bool writeable() const { return m_file.permissions().testFlag(QFileDevice::WriteUser); }
    inline bool readable() const { return m_file.permissions().testFlag(QFileDevice::ReadUser); }
    inline qint64 size() const { return m_file.size(); }
    inline QString error() const { return m_error; }

    Q_INVOKABLE bool rename(const QString &newName);

    Q_INVOKABLE inline bool copy(const QString &newName) { return m_file.copy(newName); }
    Q_INVOKABLE inline bool remove() { return m_file.remove(); }

    Q_INVOKABLE bool write(const QVariantMap &data);
    Q_INVOKABLE QVariant read();


Q_SIGNALS:
    void nameChanged(const QString &name);

public Q_SLOTS:
    Q_INVOKABLE void setName(const QString &name);

private:
    QFile m_file;
    QString m_error;

//private Q_SLOTS:

};

#endif // FILEPROXY_H

