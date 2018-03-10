#ifndef CORE_H
#define CORE_H

#include <QObject>
#include <QDebug>

#include "network.h"

class Core : public QObject
{
    Q_OBJECT
    Network *network;
public:
    explicit Core(QObject *parent = 0);
signals:
    void changeData(float flatTemperature, float flatHumidity, float outsideTemperature, float outsideHumidity);
    void changeConnected(bool status);
public slots:
    void autorization();
    void changeIP(QString new_ip);
};

#endif // CORE_H
