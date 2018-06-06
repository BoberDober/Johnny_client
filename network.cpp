#include "network.h"

Network::Network(QObject *parent) : QObject(parent)
{
    port_server = 8000;
    port_server_move = 8001;
    connected = false;
    client = new QTcpSocket(this);
    client_move = new QUdpSocket(this);
    timer = new QTimer();
    timer->setInterval(5000);
    connect(client, SIGNAL(readyRead()), this, SLOT(onReadyRead()));
    connect(client, SIGNAL(connected()), this, SLOT(onConnected()));
    connect(client, SIGNAL(disconnected()), this, SLOT(onDisconnected()));
    connect(timer, SIGNAL(timeout()), this, SLOT(reConnect()));

    reConnect();
    timer->start();
}

void Network::sendDataMove(int typeControl, int x, int y)
{
    QByteArray datagram;
    QDataStream ds(&datagram, QIODevice::WriteOnly);
    ds << typeControl;
    if(typeControl == 0)
    {
        qDebug() << x << y;
        ds << x << y;
    }
    client_move->writeDatagram(datagram,ip_server, port_server_move);
}

Network::~Network()
{
    client->deleteLater();
    timer->deleteLater();
}

void Network::onReadyRead()
{
    qDebug() << "NEW DATA" << ip_server;
    QByteArray datagram;
    QString jsonStr;
    datagram = client->readAll();
    QDataStream ds(&datagram, QIODevice::ReadOnly);
    ds >> jsonStr;
    qDebug() << jsonStr;
    emit dataReceived(jsonStr);
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
    qDebug() << "DISCONNECTED" << client->state();
}

void Network::reConnect()
{
    client->connectToHost(ip_server, port_server);
}

void Network::changeIP(QString new_ip)
{
    client->abort();
    client->close();
    ip_server = QHostAddress(new_ip);
    qDebug() << ip_server.toString() << client->state();
    client->connectToHost(ip_server, port_server);
}

void Network::sendData(QString data)
{
    qDebug() << data;
    QByteArray arr;
    QDataStream ds(&arr, QIODevice::WriteOnly);
    ds << data;
    qDebug() << "SEND" << client->write(arr);
}
