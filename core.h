#ifndef CORE_H
#define CORE_H

#include <QObject>
#include <QDebug>
#include <QSettings>
#include <QVector3D>
#include "currentdata.h"
#include "network.h"

class Core : public QObject
{
    Q_OBJECT
    Q_PROPERTY(CurrentData* currentData  MEMBER m_currentData CONSTANT)
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
    void sendRGBColor(int typeLED, QVector3D rgb);
    void sendRGBMode(int typeLED);
    void sendDataNeon(bool status);
    void sendDataMove(int typeControl, int x, int y);
private:
    QSettings *setting;
    Network *network;
    CurrentData *m_currentData;
};

#endif // CORE_H
