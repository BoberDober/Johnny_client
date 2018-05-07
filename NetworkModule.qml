import QtQuick 2.0
import QtQuick.Controls 2.0

Item {

    Column {
        anchors.bottom: parent.bottom
        width: parent.width
        height: 100
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
