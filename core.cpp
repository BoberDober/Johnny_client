#include "core.h"

Core::Core(QObject *parent) : QObject(parent)
{
    network = new Network();

    connect(network, SIGNAL(dataReceived(QString)), this, SLOT(dataReveiced(QString)));
    connect(network, SIGNAL(connectedChange(bool)), this, SIGNAL(changeConnected(bool)));
    connect(this, SIGNAL(dataSend(QString)), network, SLOT(sendData(QString)));
}

void Core::autorization()
{
    network->reConnect();
}

void Core::changeIP(QString new_ip)
{
    network->changeIP(new_ip);
}

void Core::dataReveiced(QString jsonStr)
{
    QJsonObject jsonOut = QJsonDocument::fromJson(jsonStr.toUtf8()).object();
    foreach (QString key, jsonOut.keys()) {
        QJsonObject jsonTmpObj = jsonOut.value(key).toObject();
        if(key == "DHT_FLAT")
        {
            double temperature = jsonTmpObj.value("TEMPERATURE").toDouble();
            double humidity = jsonTmpObj.value("HUMIDITY").toDouble();
            emit changeDHT_flat(temperature, humidity);
        }
        else if(key == "DHT_OUTSIDE")
        {
            double temperature = jsonTmpObj.value("TEMPERATURE").toDouble();
            qDebug() << temperature;
            double humidity = jsonTmpObj.value("HUMIDITY").toDouble();
            emit changeDHT_outside(temperature, humidity);
        }
    }
}

void Core::sendData(int typeLED, int r, int g, int b)
{
    QJsonObject jsonObj;
    QJsonObject jsonTmp;

    jsonTmp["RED"] = r;
    jsonTmp["GREEN"] = g;
    jsonTmp["BLUE"] = b;

    if(typeLED == 0)//обе
    {
        jsonObj["LED_BOTTOM"] = jsonTmp;
        jsonObj["LED_TOP"] = jsonTmp;
    }
    else if(typeLED == 1)//верх
    {
        jsonObj["LED_TOP"] = jsonTmp;
    }
    else if(typeLED == 2)//низ
    {
        jsonObj["LED_BOTTOM"] = jsonTmp;
    }

    QJsonDocument jsonDoc(jsonObj);
    QString strJson(jsonDoc.toJson(QJsonDocument::Compact));
    emit dataSend(strJson);
}

void Core::sendDataNeon(bool status)
{
    QJsonObject jsonObj;
    jsonObj["NEON"] = status;
    QJsonDocument docIn(jsonObj);
    QString strJson(docIn.toJson(QJsonDocument::Compact));
    emit dataSend(strJson);
}

void Core::sendDataMove(int typeControl, int x, int y)
{
    network->sendDataMove(typeControl, x, y);
}


