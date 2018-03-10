#include "network.h"
#include <QByteArray>
#include <QDataStream>
Network::Network(QObject *parent) : QObject(parent)
{
    ip_server = QHostAddress::LocalHost;
    port_server = 8000;
    connected = false;
    client = new QTcpSocket();
    timer = new QTimer();
    timer->setInterval(5000);
    reConnect();
    connect(client, SIGNAL(readyRead()), this, SLOT(onReadyRead()));
    connect(client, SIGNAL(connected()), this, SLOT(onConnected()));
    connect(client, SIGNAL(disconnected()), this, SLOT(onDisconnected()));

    connect(timer, SIGNAL(timeout()), this, SLOT(reConnect()));
    timer->start();
}

void Network::onReadyRead()
{
    qDebug() << "NEW DATA" << ip_server;
    float flatTemperature;
    float flatHumidity;
    float outsideTemperature;
    float outsideHumidity;
    QByteArray datagram;
    datagram = client->readAll();

    QDataStream ds(&datagram, QIODevice::ReadOnly);
    ds.setFloatingPointPrecision(QDataStream::SinglePrecision);
    ds >> flatTemperature;
    ds >> flatHumidity;
    ds >> outsideTemperature;
    ds >> outsideHumidity;
//    qDebug() << flatTemperature << flatHumidity << outsideTemperature << outsideHumidity << datagram.size();
    emit dataChange(flatTemperature, flatHumidity, outsideTemperature, outsideHumidity);
}

void Network::onConnected()
{
    timer->stop();
    emit connectedChange(true);
    qDebug() << "CONNECTED";
}

void Network::onDisconnected()
{
    timer->start();
    emit connectedChange(false);
    qDebug() << "DISCONNECTED";
}

void Network::reConnect()
{
    client->connectToHost(ip_server, port_server);
}

void Network::changeIP(QString new_ip)
{
    client->disconnectFromHost();
    ip_server = QHostAddress(new_ip);
    qDebug() << ip_server.toString() << client->state();
    client->connectToHost(ip_server, port_server);
}
