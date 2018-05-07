import QtQuick 2.0

Item {
    id: root
    property string temperature: 'NO DATA'
    property string humidity: 'NO DATA'
    property string title

    Column {
        anchors.fill: parent
        spacing: 12
        Text {
            text: root.title
            color: "blue"
            font.pointSize: main.height * 0.04
        }
        Column {
            spacing: 7
            Text {
                text: "Температура - " + root.temperature
                color: "red"
                font.pointSize: 14
            }
            Text {
                text: "Влажность - " + root.humidity
                color: "red"
                font.pointSize: 14
            }
        }
    }
}
