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
    void changeDHT_flat(double temperature, double humidity);
    void changeDHT_outside(double temperature, double humidity);
    void changeConnected(bool status);
    void dataSend(QString strJson);
public slots:
    void autorization();
    void changeIP(QString new_ip);
    void dataReveiced(QString jsonStr);
    void sendData(int typeLED, int r, int g, int b);
    void sendDataNeon(bool status);
    void sendDataMove(int typeControl, int x, int y);
};

#endif // CORE_H
