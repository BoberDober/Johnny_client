import QtQuick 2.0
//import ru.fo.gui 1.0

Item {
    id: root
    property int value_x
    property int value_y

   JJoystick {
       id: leftStick
       typeStick: 1
       maxValue: 6
       minValue: -6
       anchors.left: parent.left
       anchors.bottom: parent.bottom
       anchors.leftMargin: parent.width / 15
       anchors.bottomMargin: parent.height / 15
       width: main.width / 13
       height: main.height / 2.5
       color: "transparent"
       onChangeMove: {
           root.value_x = valueX
           core.sendDataMove(0, root.value_x, root.value_y)
       }
   }

   JJoystick {
       id: rightStick
       typeStick: 2
       maxValue: 6
       minValue: -6
       anchors.right: parent.right
       anchors.bottom: parent.bottom
       anchors.rightMargin: parent.width / 15
       anchors.bottomMargin: parent.height / 15 + main.height / 2.5 / 2  - height / 2
       width: main.width / 4
       height: main.height / 8
       color: "transparent"
       onChangeMove: {
           root.value_y = valueY
           core.sendDataMove(0, root.value_x, root.value_y)
       }
   }
}
