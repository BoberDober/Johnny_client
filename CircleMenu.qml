import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id: circleRoot
//    color: "transparent"

    property bool neonValue: false
    property bool stickEnableValue: false
    property bool autonomousEnableValue: false
    property bool hudEnableValue: main.typeControl == "control" ? hudEnableValue = false : hudEnableValue = true//false
    property bool sensorsEnableValue: false

    LightMenu {
        id: lightMenu
        x: (circleRoot.width - width) / 2
        y: (circleRoot.height - height) / 2
        width: main.width * 0.7
        height: main.height * 0.8
    }

    ListModel {
        id: menuCircleModel
        ListElement {
            icon: "qrc:/image/image/led_icon.png"
            key: "light"
        }
        ListElement {
            icon: "qrc:/image/image/weather_icon.png"
            key: "weather"
        }
        ListElement {
            icon: "qrc:/image/image/stick_icon.png"
            key: "gui"
        }
        ListElement {
            icon: "qrc:/image/image/control_icon.png"
            key: "control"
        }
    }

    Component {
        id: colorWheelComponent
        ColorModule {
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

    function choiceSelector(key) {
        if(key === "light")
        {
            lightMenu.open()
        }
        else if(key === "gui")
        {
            if(circleLoader.sourceComponent !== stickEnableModule)
                circleLoader.sourceComponent = stickEnableModule
            else
            {
                circleLoader.sourceComponent = null
            }
        }
        else if(key === "weather")
        {

        }
        else if(key === "control")
        {
            if(circleLoader.sourceComponent !== controlModule)
                circleLoader.sourceComponent = controlModule
            else
            {
                circleLoader.sourceComponent = null
            }
        }

//        switch(index) {
//        case 0:
//            if(circleLoader.sourceComponent !== colorWheelComponent)
//                lightMenu.open()
//            break
//        case 1:
//            if(circleLoader.sourceComponent !== stickEnableModule)
//                circleLoader.sourceComponent = stickEnableModule
//            else
//            {
//                circleLoader.sourceComponent = null
//            }
//            break
//        case 2:
//            if(circleLoader.sourceComponent !== controlModule)
//                circleLoader.sourceComponent = controlModule
//            else
//            {
//                circleLoader.sourceComponent = null
//            }
//            break
//        }
    }

    PathView {
        id: view
        width: parent.width * 0.9
        height: width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        model: menuCircleModel
        interactive: false
        path: Path {
                startX: view.width / 2
                startY: 0
                PathArc { x: view.width / 2; y: view.height; radiusX: view.width / 2.5; radiusY: view.width / 2.5; useLargeArc: true }
                PathArc { x: view.width / 2; y: 0; radiusX: view.width / 2.5; radiusY: view.width / 2.5; useLargeArc: true }
            }

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
                    onClicked: choiceSelector(key)
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
