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
            id: autonomousSwitch
            text: "Автономно"
            checked: circleRoot.autonomousEnableValue
            onPositionChanged: {
                if(position)
                {
                    main.typeControl = "autonomous"
                    core.sendDataMove(1, 0, 0)
                }
                else
                {
                    main.typeControl = "autonomous"
                    core.sendDataMove(0, 0, 0)
                }
            }
        }
        Switch {
            text: "HUD"
            checked: circleRoot.hudEnableValue
            onPositionChanged: {
                main.changeHUD(position)
                circleRoot.hudEnableValue = position
            }
        }
    }
}
