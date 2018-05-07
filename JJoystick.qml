import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
import "qrc:/joystickFOO.js" as FOO
import ru.fo.gui 1.0

Rectangle {

    signal changeMove(int valueX, int valueY)

    property int typeStick: 3
    property int maxValue: 10
    property int minValue: -10
    property string handleColor: "grey"
    property string joystickBgColor: "transparent"
    property string joystickBorderColor: "black"
    readonly property double weight: FOO.getWeight()
    property int pointBegin: 0
    readonly property int size: width > height ? height : width

    readonly property int countSteps: FOO.getCountSteps()
    property int startX: 0
    property int startY: 0

    property bool handleUp: true // меняется на границе
    property alias joystick: joystick
    property alias pressed: mouseArea.focus

    id: joystick
    visible: FOO.setVisible()

    Rectangle {
        anchors.fill: parent
        color: joystickBgColor
        border.width: 3
        border.color: joystickBorderColor
        radius: width / 2
    }

    Rectangle {
        id: borderBegin
        color: "red"
//        width: 1
//        height: 1
        x: FOO.getPointBeginX()
        y: FOO.getPointBeginY()
    }

    Rectangle {
        id: handle
        width: FOO.getHandle()
        height: width
        anchors.centerIn: borderBegin
        anchors.onHorizontalCenterOffsetChanged:
            anchors.horizontalCenterOffset / (joystick.width / 2 - handle.width / 2)
        anchors.onVerticalCenterOffsetChanged:
            anchors.verticalCenterOffset / (joystick.height / 2 - handle.height / 2)
        radius: width / 2
        color: handleColor
    }
    NumberAnimation {
        id: returnAnimation
        target: handle.anchors
        properties: "horizontalCenterOffset,verticalCenterOffset"
        to: 0
        duration: 200
        easing.type: Easing.OutSine
    }
    MultiPointTouchArea {
        id: mouseArea
        touchPoints: [
            TouchPoint { id: touch }
        ]
        anchors.fill: parent
        property int angle: 0
        property bool fingerOutOfBounds: FOO.getFingerOutOfBounds()
        onPressed: {
            startX = touch.x
            startY = touch.y
        }
        onUpdated: {
            var angle = 0
            var valueX = 0
            var valueY = 0
            var lenght = 0

            if(handle.anchors.verticalCenterOffset < 0)
                handleUp = true
            else
                handleUp = false

            switch(typeStick)
            {
            case 1:
                if(handle.anchors.verticalCenterOffset < 0)
                {
                    handleUp = true
                    lenght = borderBegin.y
                    valueX = (handle.anchors.verticalCenterOffset / (lenght / Math.abs(maxValue - pointBegin))) * -1 +  pointBegin
                }
                else
                {
                    handleUp = false
                    lenght = joystick.height -  borderBegin.y
                    valueX = (handle.anchors.verticalCenterOffset / (lenght / Math.abs(minValue - pointBegin))) * -1 + pointBegin
                }
                if (fingerOutOfBounds) {
                    handle.anchors.verticalCenterOffset = touch.y - startY
                }
                else {
                    angle = Math.atan2(touch.y - startY, touch.x - startX)
                    handle.anchors.verticalCenterOffset = Math.sin(angle) * lenght
                }
                break
            case 2:
                if(handle.anchors.horizontalCenterOffset < 0)
                {
                    handleUp = false
                    lenght = borderBegin.x
                    valueY = (handle.anchors.horizontalCenterOffset / (lenght / Math.abs(minValue - pointBegin))) +  pointBegin
                }
                else
                {
                    handleUp = true
                    lenght = joystick.width -  borderBegin.x
                    valueY = (handle.anchors.horizontalCenterOffset / (lenght / Math.abs(maxValue - pointBegin))) +  pointBegin
                }
                if (fingerOutOfBounds) {
                    handle.anchors.horizontalCenterOffset = touch.x - startX
                }
                else {
                    angle = Math.atan2(touch.y - startY, touch.x - startX)
                    handle.anchors.horizontalCenterOffset = Math.cos(angle) * lenght
                }
                break;
            case 3:
                if (fingerOutOfBounds) {
                    handle.anchors.horizontalCenterOffset = touch.x - startX
                    handle.anchors.verticalCenterOffset = touch.y - startY
                } else {
                    angle = Math.atan2(touch.y - startY, touch.x - startX)
                    handle.anchors.horizontalCenterOffset = Math.cos(angle) * (joystick.width / 2)
                    handle.anchors.verticalCenterOffset = Math.sin(angle) * (joystick.width / 2)
                }
                valueX = (handle.anchors.verticalCenterOffset / (joystick.height / (maxValue * 2))) * -1
                valueY = (handle.anchors.horizontalCenterOffset / (joystick.width / (maxValue * 2)))
                break;
            }
//            console.log(valueX + " " + valueY)
            changeMove(valueX, valueY)

        }
        onReleased: {
            console.log("STOP")
            changeMove(0, 0)
            returnAnimation.start()
        }
    }
}
