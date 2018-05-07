import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    Column {
        anchors.centerIn: parent
        spacing: 10
        Switch {
            text: "Стики"
            checked: circleRoot.stickEnableValue
            onPositionChanged: {
                main.changeStick(position)
                circleRoot.stickEnableValue = position
            }
        }
        Switch {
            text: "Датчики"
            checked: circleRoot.sensorsEnableValue
            onPositionChanged: {
                main.changeSensors(position)
                circleRoot.sensorsEnableValue = position
            }
        }
    }
}
