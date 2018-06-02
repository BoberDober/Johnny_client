#ifndef CORE_H
#define CORE_H

#include <QObject>
#include <QDebug>
#include "currentdata.h"

#include "network.h"

class Core : public QObject
{
    Q_OBJECT
    Q_PROPERTY(CurrentData* currentData  MEMBER m_currentData CONSTANT)
    Network *network;
public:
    explicit Core(QObject *parent = 0);
signals:
    void changeDistance(double distance);
    void dataSend(QString strJson);
public slots:
    void autorization();
    void connectedChange(bool connected);
    void changeIP(QString new_ip);
    void dataReveiced(QString jsonStr);
    void sendData(int typeLED, int r, int g, int b);
    void sendDataNeon(bool status);
    void sendDataMove(int typeControl, int x, int y);
private:
    CurrentData *m_currentData;
};

#endif // CORE_H
