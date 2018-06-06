#include "currentdata.h"

CurrentData::CurrentData(QObject *parent) : QObject(parent)
{
    m_ipServer = "";
    m_connectedClient = false;
    m_connected_module1 = false;
    m_connected_module2 = false;
    m_flatTemperature = 0.0;
    m_flatHumidity = 0.0;
    m_outsideTemperature = 0.0;
    m_outsideHumidity = 0.0;
    m_modeLEDTop = 0;
    m_modeLEDBottom = 0;
    m_rgbTop = QVector3D(0, 0, 0);
    m_rgbBottom = QVector3D(0, 0, 0);
}

QString CurrentData::ipServer() const
{
    return m_ipServer;
}

bool CurrentData::connectedClient() const
{
    return m_connectedClient;
}

bool CurrentData::connected_module1() const
{
    return m_connected_module1;
}

bool CurrentData::connected_module2() const
{
    return m_connected_module2;
}

double CurrentData::flatTemperature() const
{
    return m_flatTemperature;
}

double CurrentData::flatHumidity() const
{
    return m_flatHumidity;
}

double CurrentData::outsideTemperature() const
{
    return m_outsideTemperature;
}

double CurrentData::outsideHumidity() const
{
    return m_outsideHumidity;
}

int CurrentData::modeLEDTop() const
{
    return m_modeLEDTop;
}

int CurrentData::modeLEDBottom() const
{
    return m_modeLEDBottom;
}

QVector3D CurrentData::rgbTop() const
{
    return m_rgbTop;
}

QVector3D CurrentData::rgbBottom() const
{
    return m_rgbBottom;
}

void CurrentData::setIpServer(const QString &ipServer)
{
    m_ipServer = ipServer;
    emit ipServerChanged();
}

void CurrentData::setConnectedClient(const bool &connectedClient)
{
    m_connectedClient = connectedClient;
    emit connectedClientChanged();
}

void CurrentData::setConnected_module1(const bool &connected_module1)
{
    m_connected_module1 = connected_module1;
    emit connectedModule1Changed();
}

void CurrentData::setConnected_module2(const bool &connected_module2)
{
    m_connected_module2 = connected_module2;
    emit connectedModule2Changed();
}

void CurrentData::setFlatTemperature(const double &flatTemperature)
{
    m_flatTemperature = flatTemperature;
    emit flatTemperatureChanged();
}

void CurrentData::setFlatHumidity(const double &flatHumidity)
{
    m_flatHumidity = flatHumidity;
    emit flatHumidityChanged();
}

void CurrentData::setOutsideTemperature(const double &outsideTemperature)
{
    m_outsideTemperature = outsideTemperature;
    emit outsideTemperatureChanged();
}

void CurrentData::setOutsideHumidity(const double &outsideHumidity)
{
    m_outsideHumidity = outsideHumidity;
    emit outsideHumidityChanged();
}

void CurrentData::setModeLEDTop(const int &modeLEDTop)
{
    m_modeLEDTop = modeLEDTop;
    emit modeLEDTopChanged();
}

void CurrentData::setModeLEDBottom(const int &modeLEDBottom)
{
    m_modeLEDBottom = modeLEDBottom;
    emit modeLEDBottomChanged();
}

void CurrentData::setRgbTop(const QVector3D &rgbTop)
{
    m_rgbTop = rgbTop;
    emit rgbTopChanged();
}

void CurrentData::setRgbBottom(const QVector3D &rgbBottom)
{
    m_rgbBottom = rgbBottom;
    emit rgbBottomChanged();
}
