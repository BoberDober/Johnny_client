import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

ApplicationWindow {
    visible: true
    visibility: Qt.platform.os == "windows" ? "AutomaticVisibility" : "FullScreen"
    width: 800
    height: 480
    title: qsTr("Hello World")
    id: main

    Connections {
        target: core
        onChangeData: {
            temperatureFlatText.data = flatTemperature.toFixed(2)
            humidityFlatText.data = flatHumidity.toFixed(2)
            temperatureOutsideText.data = outsideTemperature.toFixed(2)
            humidityOutsideText.data = outsideHumidity.toFixed(2)
        }
        onChangeConnected:
        {
            if(status)
                statusRect.color = "green"
            else
                statusRect.color = "red"
        }
    }

    Image {
        anchors.fill: parent
        source: "qrc:/image/image/wrapper1.jpeg"
        Rectangle {
            id: statusRect
            anchors.top: parent.top
            anchors.left: parent.left
            width: 20
            height: 20
            color: "red"
        }

        Column {
            id: flatColumn
            anchors.top: parent.top
            anchors.topMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 20
            Text {
                text: "Комната"
                color: "blue"
                font.pointSize: main.height * 0.04
                anchors.topMargin: 20
            }

            Text {
                property string data: 'NONE'
                id: temperatureFlatText
                text: "Температура - " + data
                color: "red"
                font.pointSize: main.height * 0.04
            }
            Text {
                property string data: 'NONE'
                id: humidityFlatText
                text: "Влажность - " + data
                color: "red"
                font.pointSize: main.height * 0.04
            }
        }

        Column {
            anchors.top: flatColumn.bottom
            anchors.topMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 20
            Text {
                text: "На улице"
                color: "blue"
                font.pointSize: main.height * 0.04
                anchors.topMargin: 20
            }

            Text {
                property string data: 'NONE'
                id: temperatureOutsideText
                text: "Температура - " + data
                color: "red"
                font.pointSize: main.height * 0.04
            }
            Text {
                property string data: 'NONE'
                id: humidityOutsideText
                text: "Влажность - " + data
                color: "red"
                font.pointSize: main.height * 0.04
            }
        }

        Image {
            source: "qrc:/image/image/setting-icon.png"
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            fillMode: Image.PreserveAspectFit
            width: parent.height * 0.09

            MouseArea {
                anchors.fill: parent
                onClicked: drawerSettings.open()
            }
        }
    }
    Drawer {
        id: drawerSettings
        edge: Qt.RightEdge
        width: parent.width * 0.3
        height: parent.height
        Column {
            anchors.fill: parent
            anchors.topMargin: 20
            spacing: 5

            TextField {
                id: textinputID
                text: "192.168.1.6"
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.1
                anchors.right: parent.right
                anchors.rightMargin: parent.width * 0.1
            }

            Button {
                text: "Подключиться"
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.2
                anchors.right: parent.right
                anchors.rightMargin: parent.width * 0.2
                onClicked: core.changeIP(textinputID.text)
            }
        }
    }
}
