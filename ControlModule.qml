import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    Column {
        anchors.centerIn: parent
        spacing: 10
        Switch {
            text: "Автономно"
            checked: circleRoot.stickEnableValue
            onPositionChanged: {
                if(position)
                    core.sendDataMove(1, 0, 0)
                else
                    core.sendDataMove(0, 0, 0)
            }
        }
    }
}
