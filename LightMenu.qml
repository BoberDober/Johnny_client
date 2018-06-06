import QtQuick 2.0
import QtQuick.Controls 2.0
import "content/ColorUtils.js" as ColorUtils

Popup {
    id: root

    property vector3d vectorColors: Qt.vector3d(0, 0, 0)
    property int currentLED: 1
    onVectorColorsChanged: {
        console.log(vectorColors.x + " " + vectorColors.y + " " + vectorColors.z)
        if(vectorColors.x < 0)
            vectorColors.x = 0
        else if(vectorColors.y < 0)
            vectorColors.y = 0
        else if(vectorColors.z < 0)
            vectorColors.z = 0
        if(root.currentLED == 1)
        {
            core.currentData.rgbTop = vectorColors
        }
        else if(root.currentLED == 2)
        {
            core.currentData.rgbBottom = vectorColors
        }
        else if(root.currentLED == 3)
        {
            core.currentData.rgbTop = vectorColors
            core.currentData.rgbBottom = vectorColors
        }
        core.sendRGBColor(root.currentLED, vectorColors)
    }

    function changeMode(mode)
    {
        if(root.currentLED === 1)
        {
            core.currentData.modeLEDTop = mode
        }
        else if(root.currentLED === 2)
            core.currentData.modeLEDBottom = mode
        else if(root.currentLED === 3)
        {
            core.currentData.modeLEDTop = mode
            core.currentData.modeLEDBottom = mode
        }
        core.sendRGBMode(root.currentLED)
    }

    function checkedMode(mode)
    {
        if(root.currentLED == 1)
            if(core.currentData.modeLEDTop === mode)
                return true
            else
                return false
        else if(root.currentLED == 2)
            if(core.currentData.modeLEDBottom === mode)
                return true
            else
                return false
        else if(root.currentLED == 3)
            if(core.currentData.modeLEDTop === mode && core.currentData.modeLEDBottom === mode)
                return true
            else
                return false
        else
            return false
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
            RadioButton {
                text: "Наугад"
                checked: checkedMode(1)
                width: parent.width
                height: parent.height / 4
                onClicked: root.changeMode(1)
            }
            RadioButton {
                text: "Вперед"
                width: parent.width
                height: parent.height / 4
                checked: checkedMode(2)
                onClicked: root.changeMode(2)
            }
            RadioButton {
                text: "Назад"
                width: parent.width
                height: parent.height / 4
                checked: checkedMode(3)
                onClicked: root.changeMode(3)
            }
            RadioButton {
                text: "Плавно"
                width: parent.width
                height: parent.height / 4
                checked: checkedMode(4)
                onClicked: root.changeMode(4)
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
                            onClicked: {
                                core.currentData.modeLEDTop = 0
                                core.currentData.modeLEDBottom = 0
                                vectorColors = Qt.vector3d(0, 0, 0)
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
                            onClicked:
                            {
                                root.currentLED = 1
                            }

                        }
                        RadioButton {
                            text: "Нижняя лента"
                            width: parent.width
                            height: parent.height / 3
                            onClicked:
                            {
                                root.currentLED = 2
                            }
                        }
                        RadioButton {
                            text: "Две ленты"
                            width: parent.width
                            height: parent.height / 3
                            onClicked:
                            {
                                root.currentLED = 3
                            }
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
                                core.currentData.modeLEDTop = 0
                                core.currentData.modeLEDBottom = 0
                                break;
                            case 1:
                                colorLoader.sourceComponent = colorModeComponent
                                vectorColors = Qt.vector3d(0, 0, 0)
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
                            color: ColorUtils.rgbToHex(core.currentData.rgbTop.x, core.currentData.rgbTop.y, core.currentData.rgbTop.z)
                            border {
                                width: 1
                                color: "black"
                            }
                        }
                        Rectangle {
                            id: bottomLED
                            width: parent.width
                            height: parent.height / 2
                            color: ColorUtils.rgbToHex(core.currentData.rgbBottom.x, core.currentData.rgbBottom.y, core.currentData.rgbBottom.z)
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
