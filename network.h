#ifndef NETWORK_H
#define NETWORK_H

#include <QObject>
#include <QTimer>
#include <QTcpSocket>
#include <QUdpSocket>
#include <QHostAddress>
#include <QByteArray>
#include <QDataStream>
#include <QJsonDocument>
#include <QJsonObject>



class Network : public QObject
{
    Q_OBJECT
    QTcpSocket *client;
    QUdpSocket *client_move;
    QHostAddress ip_server;
    quint16 port_server;
    quint16 port_server_move;
    QTimer *timer;
    bool connected;
public:
    explicit Network(QObject *parent = 0);
    void sendDataMove(int typeControl, int x, int y);
    ~Network();
signals:
    void dataReceived(QString jsonStr);
    void connectedChange(bool status);

public slots:
    void onReadyRead();
    void onConnected();
    void onDisconnected();
    void reConnect();
    void changeIP(QString new_ip);
    void sendData(QString data);
};

#endif // NETWORK_H
