import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import "content/ColorUtils.js" as ColorUtils

ApplicationWindow {
    visible: true
    visibility: Qt.platform.os == "windows" ? "AutomaticVisibility" : "FullScreen"
    width: 800
    height: 480
    title: qsTr("Hello World")
    id: main

    signal changeStick(bool position)
    signal changeSensors(bool position)

    onChangeStick: {
        if(position)
            stickModule.visible = true
        else
            stickModule.visible = false
    }

    onChangeSensors: {
        if(position)
        {
            dht_outside.visible = true
            dht_flat.visible = true
        }
        else
        {
            dht_outside.visible = false
            dht_flat.visible = false
        }
    }

    property vector3d vectorColors: Qt.vector3d(0, 0, 255)
    property string flatTemperature
    property int typeLED: 1


    Connections {
        target: core
        onChangeDHT_flat: {
            dht_flat.temperature = temperature.toFixed(2)
            dht_flat.humidity = humidity.toFixed(2)
        }

        onChangeDHT_outside: {
            dht_outside.temperature = temperature.toFixed(2)
            dht_outside.humidity = humidity.toFixed(2)
        }

        onChangeConnected:
        {
            if(status)
                statusRect.color = "green"
            else
                statusRect.color = "red"
        }
    }

    onVectorColorsChanged: {

        if(vectorColors.x < 0)
            vectorColors.x = 0
        else if(vectorColors.y < 0)
            vectorColors.y = 0
        else if(vectorColors.z < 0)
            vectorColors.z = 0

        if(typeLED == 1)
        {
            gradTop.color = ColorUtils.rgbToHex(vectorColors.x, vectorColors.y, vectorColors.z)
        }
        else if(typeLED == 2)
        {
            grad.color = ColorUtils.rgbToHex(vectorColors.x, vectorColors.y, vectorColors.z)
        }
        else if(typeLED == 0)
        {
            grad.color = ColorUtils.rgbToHex(vectorColors.x, vectorColors.y, vectorColors.z)
            gradTop.color = ColorUtils.rgbToHex(vectorColors.x, vectorColors.y, vectorColors.z)
        }
        core.sendData(typeLED, vectorColors.x, vectorColors.y, vectorColors.z)
    }

    Rectangle {
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.left: parent.left
        height: parent.height / 3
        gradient: Gradient {
            GradientStop { id: gradTop; position: 0; color: "yellow" }
            GradientStop { position: 0.9; color: "transparent" }
        }
    }

    Rectangle {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        height: parent.height / 3
        gradient: Gradient {
            GradientStop { position: 0; color: "transparent" }
            GradientStop { id: grad; position: 0.9; color: "yellow" }
        }
    }


    Image {
        anchors.fill: parent
//        source: "qrc:/image/image/wrapper1.jpeg"

        Rectangle {
            id: statusRect
            anchors.top: parent.top
            anchors.left: parent.left
            width: 20
            height: 20
            color: "red"
        }

        CircleMenu {
            id: circleMenu
            width: parent.width * 0.4
            height: width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            visible: false
        }

        Component {
            id: temperatureEnableComponent
            TemperatureEnableModule {
                id: huy
                anchors.fill: parent
            }
        }

        Column {
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 20
            spacing: 10

            TemperatureModule {
                id: dht_outside
                visible: false
                width: main.width * 0.2
                height: main.height * 0.2
                title: "Улица"
            }

            TemperatureModule {
                id: dht_flat
                visible: false
                width: parent.width * 0.2
                height: parent.height * 0.2
                title: "Квартира"
            }
        }

        Column {
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: 10
            anchors.rightMargin: 10
            spacing: 20
            Image {
                source: "qrc:/image/image/setting-icon.png"
                fillMode: Image.PreserveAspectFit
                width: main.height * 0.1

                MouseArea {
                    anchors.fill: parent
                    onClicked: drawerSettings.open()
                }
            }
            Image {
                source: "qrc:/image/image/circle-icon.png"
                fillMode: Image.PreserveAspectFit
                width: main.height * 0.1

                MouseArea {
                    anchors.fill: parent
                    onClicked: circleMenu.visible === true ? circleMenu.visible = false : circleMenu.visible = true
                }
            }
        }
    }



//    Component {
//        id: stickComponent
//        StickModule {
//            anchors.fill: parent
//        }
//    }

//    Loader {
//        id: stickLoader
//        anchors.left: parent.left
//        anchors.bottom: parent.bottom
//        anchors.right: parent.right
//        height: parent.height / 2
//    }

    StickModule {
        id: stickModule
        visible: false
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        height: parent.height / 2
    }

    Drawer {
        id: drawerSettings
        edge: Qt.RightEdge
        width: parent.width * 0.3
        height: parent.height
        NetworkModule {
            width: parent.width
            height: parent.height
        }
    }
}
