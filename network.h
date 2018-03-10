#ifndef NETWORK_H
#define NETWORK_H

#include <QObject>
#include <QTimer>
#include <QTcpSocket>
#include <QHostAddress>

class Network : public QObject
{
    Q_OBJECT
    QTcpSocket *client;
    QHostAddress ip_server;
    quint16 port_server;
    QTimer *timer;
    bool connected;
public:
    explicit Network(QObject *parent = 0);
signals:
    void dataChange(float flatTemperature, float flatHumidity, float outsideTemperature, float outsideHumidity);
    void connectedChange(bool status);

public slots:
    void onReadyRead();
    void onConnected();
    void onDisconnected();
    void reConnect();
    void changeIP(QString new_ip);
};

#endif // NETWORK_H
