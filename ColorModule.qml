import QtQuick 2.0

Item {

    function openBottomLine() {
        bottomRect.color = "black"
        bottomAnimatonX.start()
        bottomAnimatonWidth.start()
    }

    function closeBottomLine() {
        bottomAnimatonXClose.start()
        bottomAnimatonWidthClose.start()
    }


    NumberAnimation {
        id: topAnimatonOpen
        target: topRect
        properties: "width"
        to: rootColumn.width
        duration: 200
        onStarted: topRect.color = "black"
    }

    NumberAnimation {
        id: topAnimatonClose
        target: topRect
        properties: "width"
        to: 3
        duration: 200
        onStopped: topRect.color = "transparent"
    }

    NumberAnimation {
        id: bottomAnimatonWidth
        target: bottomRect
        properties: "width"
        to: rootColumn.width
        duration: 200
    }

    NumberAnimation {
        id: bottomAnimatonX
        target: bottomRect
        properties: "x"
        to: 0
        duration: 200
    }

    NumberAnimation {
        id: bottomAnimatonWidthClose
        target: bottomRect
        properties: "width"
        to: 3
        duration: 200
        onStopped: bottomRect.color = "transparent"
    }

    NumberAnimation {
        id: bottomAnimatonXClose
        target: bottomRect
        properties: "x"
        to: rootColumn.width - 3
        duration: 200
    }

    Column
    {
        id: rootColumn
        spacing: 7
        width: 0
        anchors.fill: parent
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        Rectangle {
            id: topRect
            width: parent.width
            height: 3
            color: "black"
        }
        ColorWheel {
            width: parent.width
            height: width
            colors: main.vectorColors
            onColorsChanged: {
                vectorColors = colors
            }
        }
        Rectangle {
            id: bottomRect
            width: 3
            height: 3
            x: parent.width - width
            color: "black"
        }
    }
}
