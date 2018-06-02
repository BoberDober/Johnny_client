#include "currentdata.h"

CurrentData::CurrentData(QObject *parent) : QObject(parent)
{
    m_connectedClient = false;
    m_connected_module1 = false;
    m_connected_module2 = false;
    m_flatTemperature = 0.0;
    m_flatHumidity = 0.0;
    m_outsideTemperature = 0.0;
    m_outsideHumidity = 0.0;
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
