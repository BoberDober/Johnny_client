import QtQuick 2.0
import QtQuick.Controls 2.0

Item {

    Column {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.1
        anchors.right: parent.right
        anchors.rightMargin: parent.width * 0.1
        height: parent.height * 0.3

        Item {
            width: parent.width
            height: parent.height * 0.3
            Text {
                text: "Модуль 1"
                anchors.left: parent.left
                font.pointSize: parent.height * 0.4
                anchors.verticalCenter: parent.verticalCenter
            }
            Rectangle {
                height: parent.height * 0.4
                width: height
                color: core.currentData.connected_module1 ? "green" : "red"
                radius: width / 2
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Item {
            width: parent.width
            height: parent.height * 0.3
            Text {
                text: "Модуль 2"
                anchors {
                    left: parent.left
                }
                font.pointSize: parent.height * 0.4
                anchors.verticalCenter: parent.verticalCenter
            }
            Rectangle {
                height: parent.height * 0.4
                width: height
                color: core.currentData.connected_module2 ? "green" : "red"
                radius: width / 2
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Column {
        anchors.bottom: parent.bottom
        width: parent.width
        height: 100
        spacing: 5

        TextField {
            id: textinputID
            text: core.currentData.ipServer
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
