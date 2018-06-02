import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2

ApplicationWindow {
    visible: true
    visibility: Qt.platform.os == "windows" ? "AutomaticVisibility" : "FullScreen"
    width: 800
    height: 480
    title: qsTr("Hello World")
    id: main

    signal changeStick(bool position)
    signal changeSensors(bool position)
    signal changeHUD(bool position)

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

    onChangeHUD: {
        if(position)
            echoDisplay.visible = true
        else
            echoDisplay.visible = false
    }

    property string flatTemperature
    property int typeLED: 1
    property string typeControl: "control" //control - ручное autonomous - автономное

    Connections {
        target: core

        onChangeDistance: {
            echoDisplay.digitalDistance = Math.round(distance)
            echoDisplay.lightIndicator(distance)
        }
    }

    Image {
        anchors.fill: parent
//        source: "qrc:/image/image/wrapper1.jpeg"

        EchoDisplay {
            id: echoDisplay
            width: parent.width / 2
            height: parent.height * 0.08
            visible: false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: height / 3
        }

        Rectangle {
            id: statusRect
            anchors.top: parent.top
            anchors.left: parent.left
            width: 20
            height: 20
//            color: "red"
            color: core.currentData.connectedClient ? "green" : "red"//"red"

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
                temperature: core.currentData.outsideTemperature.toFixed(2)
                humidity: core.currentData.outsideHumidity.toFixed(2)
            }

            TemperatureModule {
                id: dht_flat
                visible: false
                width: parent.width * 0.2
                height: parent.height * 0.2
                title: "Квартира"
                temperature: core.currentData.flatTemperature.toFixed(2)
                humidity: core.currentData.flatHumidity.toFixed(2)
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
