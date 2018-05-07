import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle {
    id: circleRoot
    color: "transparent"
//    color: "red"

    property bool neonValue: false
    property bool stickEnableValue: false
    property bool sensorsEnableValue: false

    ListModel {
        id: menuCircleModel
        ListElement {
            icon: "qrc:/image/image/led_icon.png"
        }
        ListElement {
            icon: "qrc:/image/image/neon_icon.png"
        }
        ListElement {
            icon: "qrc:/image/image/stick_icon.png"
        }
        ListElement {
            icon: "qrc:/image/image/control_icon.png"
        }
    }

    Component {
        id: colorWheelComponent
        ColorModule {
            anchors.fill: parent
        }
    }

    Component {
        id: neonComponent
        NeonModule {
            anchors.fill: parent
        }
    }

    Component {
        id: stickEnableModule
        StickEnableModule {
            anchors.fill: parent
        }
    }

    Component {
        id: controlModule
        ControlModule {
            anchors.fill: parent
        }
    }

    function choiceSelector(index) {
        switch(index) {
        case 0:
            if(circleLoader.sourceComponent !== colorWheelComponent)
                circleLoader.sourceComponent = colorWheelComponent
            else
            {
                circleLoader.sourceComponent = null
                typeLED = 0
            }
            break
        case 1:
            if(circleLoader.sourceComponent !== neonComponent)
                circleLoader.sourceComponent = neonComponent
            else
            {
                circleLoader.sourceComponent = null
            }
            break
        case 2:
            if(circleLoader.sourceComponent !== stickEnableModule)
                circleLoader.sourceComponent = stickEnableModule
            else
            {
                circleLoader.sourceComponent = null
            }
            break
        case 3:
            if(circleLoader.sourceComponent !== controlModule)
                circleLoader.sourceComponent = controlModule
            else
            {
                circleLoader.sourceComponent = null
            }
            break
        default:
            console.log(index)
        }
    }
//M cx cy m -r, 0 a r,r 0 1,0 (r * 2),0 a r,r 0 1,0 -(r * 2),0
    function getCoordinate(width, height) {
        var r = 100
        var cx = width
        var cy = height
//        var str = "M 200 200 m -200 0 a 200 200 0 1 0 400 0 a 200 200 0 1 0 -400 0"
        var buff = "M " + cx + " " + cy + " m " + -r + " 0 a " + r + " " + r + " 0 1 0 " + r * 2 + " 0 a " + r + " " + r + " 0 1 0 " + -r * 2 + " 0"
        console.log(width, height)
        return buff
    }

    PathView {
        id: view
        width: parent.width * 0.9
        height: width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
//        anchors.fill: parent
        model: menuCircleModel
        interactive: false
        path: Path {
                startX: view.width / 2
                startY: 0
                PathArc { x: view.width / 2; y: view.height; radiusX: view.width / 2.5; radiusY: view.width / 2.5; useLargeArc: true }
                PathArc { x: view.width / 2; y: 0; radiusX: view.width / 2.5; radiusY: view.width / 2.5; useLargeArc: true }
            }
//        path: Path {
//                startX: view.width / 2
//                startY: 0
//                PathArc { x: view.width / 2; relativeY: view.height; radiusX: 100; radiusY: 100; useLargeArc: true }
//                PathArc { x: view.width / 2; relativeY: view; radiusX: 100; radiusY: 100; useLargeArc: true }
//            }
//        path: Path {
//            id: myPath
//            startX: 0; startY: 0
//            PathSvg { path: getCoordinate(view.width / 2, view.height / 2) }
//        }

        delegate: Rectangle {
            width: parent.width / 5
            height: width
            color: "transparent"
            border {
                color: "black"
                width: 1
            }
            Image {
                anchors.fill: parent
                source: icon
                MouseArea {
                    anchors.fill: parent
                    onClicked: choiceSelector(index)
                }
            }
        }
        Loader {
            id: circleLoader
            width: parent.width * 0.6
            height: width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
