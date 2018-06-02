import QtQuick 2.0
import QtQuick.Controls 2.0
import "content/ColorUtils.js" as ColorUtils

Popup {
    id: root

    property vector3d vectorColors: Qt.vector3d(0, 0, 0)
    property int mode: 0
    onVectorColorsChanged: {
        console.log(vectorColors.x + " " + vectorColors.y + " " + vectorColors.z)
        if(vectorColors.x < 0)
            vectorColors.x = 0
        else if(vectorColors.y < 0)
            vectorColors.y = 0
        else if(vectorColors.z < 0)
            vectorColors.z = 0

        if(typeLED == 1)
        {
            topLED.color = ColorUtils.rgbToHex(vectorColors.x, vectorColors.y, vectorColors.z)
        }
        else if(typeLED == 2)
        {
            bottomLED.color = ColorUtils.rgbToHex(vectorColors.x, vectorColors.y, vectorColors.z)
        }
        else if(typeLED == 0)
        {
            bottomLED.color = ColorUtils.rgbToHex(vectorColors.x, vectorColors.y, vectorColors.z)
            topLED.color = ColorUtils.rgbToHex(vectorColors.x, vectorColors.y, vectorColors.z)
        }
        core.sendData(typeLED, vectorColors.x, vectorColors.y, vectorColors.z)
    }

    onModeChanged: {
        console.log(mode)
    }

    ListModel {
        id: paletteModel
        ListElement {colors: "red"}
        ListElement {colors: "red"}
        ListElement {colors: "red"}

        ListElement {colors: "blue"}
        ListElement {colors: "blue"}
        ListElement {colors: "blue"}

        ListElement {colors: "green"}
        ListElement {colors: "green"}
        ListElement {colors: "green"}
    }

    Component {
        id: colorCircleComponent
        ColorWheel {
            anchors.fill: parent
            colors: root.vectorColors
            onColorsChanged: {
                vectorColors = colors
            }
        }
    }

    Component {
        id: colorModeComponent
        Column {
            anchors.fill: parent
            Switch{
                id: mode1
                text: "Наугад"
                checked: (root.mode == 1) ? mode1.checked = true : mode1.checked = false
                onPositionChanged: root.mode = 1
            }
            Switch{
                id: mode2
                text: "Вперед"
                checked: (root.mode == 2) ? mode2.checked = true : mode2.checked = false
                onPositionChanged: root.mode = 2
            }
            Switch{
                id: mode3
                text: "Назад"
                checked: (root.mode == 3) ? mode3.checked = true : mode3.checked = false
                onPositionChanged: root.mode = 3
            }
            Switch{
                id: mode4
                text: "Плавно"
                checked: (root.mode == 4) ? mode4.checked = true : mode4.checked = false
                onPositionChanged: root.mode = 4
            }
        }
    }

    Component {
        id: colorPaletteComponent
        GridView {
            id: paletteGrid
            anchors.fill: parent
            cellHeight: height / 3 - 5
            cellWidth: width / 3 - 5
            model: paletteModel
            delegate: Rectangle {
                width: paletteGrid.cellWidth
                height: paletteGrid.cellHeight
                color: colors
                border {
                    width: 1
                    color: "black"
                }
            }
        }
    }

    Column {
        width: parent.width
        height: parent.height
        anchors {
            right: parent.right
            bottom: parent.bottom
            left: parent.left
        }

        spacing: 5
        GroupBox {
            title: "Подсветка окна"
            height: parent.height * 0.7
            width: parent.width
            Row {
                anchors.fill: parent
                Item {
                    width: parent.width / 3
                    anchors.top: parent.top
                    anchors.topMargin: 2
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 2
                    Loader {
                        id: colorLoader
                        width: parent.width * 0.9
                        height: width
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        sourceComponent: colorCircleComponent
                    }

//                    ColorWheel {
//                        width: parent.width * 0.9
//                        height: width
//                        anchors.top: parent.top
//                        anchors.horizontalCenter: parent.horizontalCenter
//                        colors: root.vectorColors
//                        onColorsChanged: {
//                            vectorColors = colors
//                        }
//                    }
                    Rectangle {
                        width: parent.width * 0.9
                        height: parent.height * 0.15
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: offArea.pressed? "gray" : "#e0e0e0"
                        Text {
                            text: "Выключить"
                            color: "#353637"
                            font.pixelSize: parent.height * 0.5
                            anchors.centerIn: parent
                        }
                        MouseArea {
                            id: offArea
                            anchors.fill: parent
                            onClicked: vectorColors = Qt.vector3d(0, 0, 0)
                        }
                    }
                }

                Item {
                    width: parent.width / 3
                    anchors.top: parent.top
                    anchors.topMargin: 2
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 2
                    Column {
                        spacing: 2
                        width: parent.width * 0.9
                        height: parent.height * 0.85
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        RadioButton {
                            text: "Верхняя лента"
                            checked: true
                            width: parent.width
                            height: parent.height / 3
                            onClicked: main.typeLED = 1

                        }
                        RadioButton {
                            text: "Нижняя лента"
                            width: parent.width
                            height: parent.height / 3
                            onClicked: main.typeLED = 2
                        }
                        RadioButton {
                            text: "Две ленты"
                            width: parent.width
                            height: parent.height / 3
                            onClicked: main.typeLED = 0
                        }
                    }
                    ComboBox {
                        currentIndex: 0
                        height: parent.height * 0.15
                        width: parent.width * 0.9
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        model: ["Цвета", "Режимы"]
                        onActivated: {
                            switch(index)
                            {
                            case 0:
                                colorLoader.sourceComponent = colorCircleComponent
                                break;
                            case 1:
                                colorLoader.sourceComponent = colorModeComponent
                                break;
                            default:
                                colorLoader.sourceComponent = colorCircleComponent
                                break;
                            }
                        }
                    }
                }

                 Item {
                    width: parent.width / 3
                    anchors.top: parent.top
                    anchors.topMargin: 2
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 2

                    Column {
                        width: parent.width * 0.9
                        height: parent.height * 0.4
                        anchors.centerIn: parent
                        spacing: 10

                        Rectangle {
                            id: topLED
                            width: parent.width
                            height: parent.height / 2
                            color: "black"
                            border {
                                width: 1
                                color: "black"
                            }
                        }
                        Rectangle {
                            id: bottomLED
                            width: parent.width
                            height: parent.height / 2
                            color: "black"
                            border {
                                width: 1
                                color: "black"
                            }
                        }
                    }
                }
            }
        }

        Row {
            height: parent.height * 0.3
            width: parent.width
            GroupBox {
                title: "Палитра"
                height: parent.height
                width: parent.width / 2
            }
            GroupBox {
                title: "Неон"
                height: parent.height
                width: parent.width / 2

                Switch {
                    text: "Вкл/Выкл"
                    anchors.centerIn: parent
                    checked: circleRoot.neonValue
                    onPositionChanged: {
                        core.sendDataNeon(position)
                    }
                }
            }
        }
    }
}
