#ifndef CURRENTDATA_H
#define CURRENTDATA_H

#include <QObject>

class CurrentData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool connectedClient READ connectedClient WRITE setConnectedClient NOTIFY connectedClientChanged)

    Q_PROPERTY(bool connected_module1 READ connected_module1 WRITE setConnected_module1 NOTIFY connectedModule1Changed)
    Q_PROPERTY(bool connected_module2 READ connected_module2 WRITE setConnected_module2 NOTIFY connectedModule2Changed)

    Q_PROPERTY(double flatTemperature READ flatTemperature WRITE setFlatTemperature NOTIFY flatTemperatureChanged)
    Q_PROPERTY(double flatHumidity READ flatHumidity WRITE setFlatHumidity NOTIFY flatHumidityChanged)

    Q_PROPERTY(double outsideTemperature READ outsideTemperature WRITE setOutsideTemperature NOTIFY outsideTemperatureChanged)
    Q_PROPERTY(double outsideHumidity READ outsideHumidity WRITE setOutsideHumidity NOTIFY outsideHumidityChanged)

public:
    explicit CurrentData(QObject *parent = 0);

    bool connectedClient() const;

    bool connected_module1() const;
    bool connected_module2() const;

    double flatTemperature() const;
    double flatHumidity() const;

    double outsideTemperature() const;
    double outsideHumidity() const;

signals:
    void connectedClientChanged();

    void connectedModule1Changed();
    void connectedModule2Changed();

    void flatTemperatureChanged();
    void flatHumidityChanged();

    void outsideTemperatureChanged();
    void outsideHumidityChanged();
public slots:
    void setConnectedClient(const bool &connectedClient);

    void setConnected_module1(const bool &connected_module1);
    void setConnected_module2(const bool &connected_module2);

    void setFlatTemperature(const double &flatTemperature);
    void setFlatHumidity(const double &flatHumidity);

    void setOutsideTemperature(const double &outsideTemperature);
    void setOutsideHumidity(const double &outsideHumidity);
private:
    bool m_connectedClient;

    bool m_connected_module1;
    bool m_connected_module2;

    double m_flatTemperature;
    double m_flatHumidity;

    double m_outsideTemperature;
    double m_outsideHumidity;
};

#endif // CURRENTDATA_H
