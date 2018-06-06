#include "core.h"

Core::Core(QObject *parent) : QObject(parent)
{
    qRegisterMetaType<CurrentData*>();
    setting = new QSettings("Johnny-client.conf", QSettings::IniFormat, this);
    network = new Network(this);
    m_currentData = new CurrentData(this);
    connect(network, SIGNAL(dataReceived(QString)), this, SLOT(dataReveiced(QString)));
    connect(network, SIGNAL(connectedChange(bool)), this, SLOT(connectedChange(bool)));
    connect(this, SIGNAL(dataSend(QString)), network, SLOT(sendData(QString)));
    changeIP(setting->value("IP_server", "192.168.1.2").toString());
}

void Core::autorization()
{
    network->reConnect();
}

void Core::connectedChange(bool connected)
{
    m_currentData->setConnectedClient(connected);
}

void Core::changeIP(QString new_ip)
{
    m_currentData->setIpServer(new_ip);
    setting->setValue("IP_server", new_ip);
    setting->sync();
    network->changeIP(new_ip);
}

void Core::dataReveiced(QString jsonStr)
{
//    qDebug() << "!!!!!!!!!!!!!!!!!!!!!!!!!" << jsonStr; // данные перебиваются (((
    QJsonObject jsonOut = QJsonDocument::fromJson(jsonStr.toUtf8()).object();
    foreach (QString key, jsonOut.keys()) {
        QJsonObject jsonTmpObj = jsonOut.value(key).toObject();
        if(key == "DHT_FLAT")
        {
            m_currentData->setFlatTemperature(jsonTmpObj.value("TEMPERATURE").toDouble());
            m_currentData->setFlatHumidity(jsonTmpObj.value("HUMIDITY").toDouble());
        }
        else if(key == "DHT_OUTSIDE")
        {
            m_currentData->setOutsideTemperature(jsonTmpObj.value("TEMPERATURE").toDouble());
            m_currentData->setOutsideHumidity(jsonTmpObj.value("HUMIDITY").toDouble());
        }
        else if(key == "ULTRASONIC")
        {
            double distance = jsonTmpObj.value("DISTANCE").toDouble();
            emit changeDistance(distance);
        }
        else if(key == "MODULE1")
        {
            m_currentData->setConnected_module1(jsonTmpObj.value("STATUS").toBool());
        }
        else if(key == "MODULE2")
        {
            m_currentData->setConnected_module2(jsonTmpObj.value("STATUS").toBool());
        }
    }
}

void Core::sendRGBColor(int typeLED, QVector3D rgb)
{
    QJsonObject jsonObj;
    QJsonObject jsonTmpType;
    QJsonObject jsonTmpValue;

    jsonTmpValue["RED"] = rgb.x();
    jsonTmpValue["GREEN"] = rgb.y();
    jsonTmpValue["BLUE"] = rgb.z();

    jsonTmpType["COLOR"] = jsonTmpValue;

    if(typeLED == 1)//верх
    {
        jsonObj["LED_TOP"] = jsonTmpType;
    }
    else if(typeLED == 2)//низ
    {
        jsonObj["LED_BOTTOM"] = jsonTmpType;
    }
    if(typeLED == 3)//обе
    {
        jsonObj["LED_BOTTOM"] = jsonTmpType;
        jsonObj["LED_TOP"] = jsonTmpType;
    }

    QJsonDocument jsonDoc(jsonObj);
    QString strJson(jsonDoc.toJson(QJsonDocument::Compact));
    emit dataSend(strJson);
}

void Core::sendRGBMode(int typeLED)
{
    QJsonObject jsonObj;
    QJsonObject jsonTmpValue;

    if(typeLED == 1)//верх
    {
        jsonTmpValue["MODE"] = m_currentData->modeLEDTop();
        jsonObj["LED_TOP"] = jsonTmpValue;
    }
    else if(typeLED == 2)//низ
    {
        jsonTmpValue["MODE"] = m_currentData->modeLEDBottom();
        jsonObj["LED_BOTTOM"] = jsonTmpValue;
    }
    if(typeLED == 3)//обе
    {
        jsonTmpValue["MODE"] = m_currentData->modeLEDTop();
        jsonObj["LED_TOP"] = jsonTmpValue;
        jsonTmpValue["MODE"] = m_currentData->modeLEDBottom();
        jsonObj["LED_BOTTOM"] = jsonTmpValue;
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

