import QtQuick 2.0
import QtQuick.Controls 2.0
Item {
    id: root

    Switch {
        text: "Неон"
        anchors.centerIn: parent
        checked: circleRoot.neonValue
        onPositionChanged: {
            core.sendDataNeon(position)
            circleRoot.neonValue = position
        }
    }
}
