#ifndef CURRENTDATA_H
#define CURRENTDATA_H

#include <QString>
#include <QObject>
#include <QVariantList>
#include <QVector3D>

class CurrentData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString ipServer READ ipServer WRITE setIpServer NOTIFY ipServerChanged)
    Q_PROPERTY(bool connectedClient READ connectedClient WRITE setConnectedClient NOTIFY connectedClientChanged)
    Q_PROPERTY(bool connected_module1 READ connected_module1 WRITE setConnected_module1 NOTIFY connectedModule1Changed)
    Q_PROPERTY(bool connected_module2 READ connected_module2 WRITE setConnected_module2 NOTIFY connectedModule2Changed)
    Q_PROPERTY(double flatTemperature READ flatTemperature WRITE setFlatTemperature NOTIFY flatTemperatureChanged)
    Q_PROPERTY(double flatHumidity READ flatHumidity WRITE setFlatHumidity NOTIFY flatHumidityChanged)
    Q_PROPERTY(double outsideTemperature READ outsideTemperature WRITE setOutsideTemperature NOTIFY outsideTemperatureChanged)
    Q_PROPERTY(double outsideHumidity READ outsideHumidity WRITE setOutsideHumidity NOTIFY outsideHumidityChanged)
    Q_PROPERTY(int modeLEDTop READ modeLEDTop WRITE setModeLEDTop NOTIFY modeLEDTopChanged)
    Q_PROPERTY(int modeLEDBottom READ modeLEDBottom WRITE setModeLEDBottom NOTIFY modeLEDBottomChanged)
    Q_PROPERTY(QVector3D rgbTop READ rgbTop WRITE setRgbTop NOTIFY rgbTopChanged)
    Q_PROPERTY(QVector3D rgbBottom READ rgbBottom WRITE setRgbBottom NOTIFY rgbBottomChanged)

public:
    explicit CurrentData(QObject *parent = 0);

    QString ipServer() const;
    bool connectedClient() const;
    bool connected_module1() const;
    bool connected_module2() const;
    double flatTemperature() const;
    double flatHumidity() const;
    double outsideTemperature() const;
    double outsideHumidity() const;
    int modeLEDTop() const;
    int modeLEDBottom() const;
    QVector3D rgbTop() const;
    QVector3D rgbBottom() const;

signals:
    void ipServerChanged();
    void connectedClientChanged();
    void connectedModule1Changed();
    void connectedModule2Changed();
    void flatTemperatureChanged();
    void flatHumidityChanged();
    void outsideTemperatureChanged();
    void outsideHumidityChanged();
    void modeLEDTopChanged();
    void modeLEDBottomChanged();
    void rgbTopChanged();
    void rgbBottomChanged();

public slots:
    void setIpServer(const QString &ipServer);
    void setConnectedClient(const bool &connectedClient);
    void setConnected_module1(const bool &connected_module1);
    void setConnected_module2(const bool &connected_module2);
    void setFlatTemperature(const double &flatTemperature);
    void setFlatHumidity(const double &flatHumidity);
    void setOutsideTemperature(const double &outsideTemperature);
    void setOutsideHumidity(const double &outsideHumidity);
    void setModeLEDTop(const int &modeLEDTop);
    void setModeLEDBottom(const int &modeLEDBottom);
    void setRgbTop(const QVector3D &rgbTop);
    void setRgbBottom(const QVector3D &rgbBottom);

private:
    QString m_ipServer;
    bool m_connectedClient;
    bool m_connected_module1;
    bool m_connected_module2;
    double m_flatTemperature;
    double m_flatHumidity;
    double m_outsideTemperature;
    double m_outsideHumidity;
    int m_modeLEDTop;
    int m_modeLEDBottom;
    QVector3D m_rgbTop;
    QVector3D m_rgbBottom;
};

#endif // CURRENTDATA_H
