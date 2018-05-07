import QtQuick 2.0

Item {
    id: root
    property string dhtFlatTemperature
    property double dhtFlatHumidity
    Column {
        spacing: 10
        TemperatureModule {
            id: dht_outside
            width: root.width
            height: root.height / 2
            title: "Улица"
            temperature: flatTemperature
        }

        TemperatureModule {
            id: dht_flat
            width: root.width
            height: root.height / 2
            title: "Квартира"
        }
    }
}
