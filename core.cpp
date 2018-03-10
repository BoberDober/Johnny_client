#include "core.h"

Core::Core(QObject *parent) : QObject(parent)
{
    network = new Network();
    connect(network, SIGNAL(dataChange(float, float, float, float)), this, SIGNAL(changeData(float, float, float, float)));
    connect(network, SIGNAL(connectedChange(bool)), this, SIGNAL(changeConnected(bool)));

}

void Core::autorization()
{
    network->reConnect();
}

void Core::changeIP(QString new_ip)
{
    network->changeIP(new_ip);
}
