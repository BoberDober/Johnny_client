import QtQuick 2.0

Item {
    id: root

    property int digitalDistance: 0
    property int indicatorRadius: 15

    function lightIndicator(distance) // 35 55 70 85 100 120 доделать с проперти
    {
        lg1.color = "transparent"
        lg2.color = "transparent"
        ly1.color = "transparent"
        ly2.color = "transparent"
        lr1.color = "transparent"
        lr2.color = "transparent"

        rr1.color = "transparent"
        rr2.color = "transparent"
        ry1.color = "transparent"
        ry2.color = "transparent"
        rg1.color = "transparent"
        rg2.color = "transparent"

        if(distance <= 35)
        {
            lg1.color = "green"
            lg2.color = "green"
            ly1.color = "yellow"
            ly2.color = "yellow"
            lr1.color = "red"
            lr2.color = "red"

            rr1.color = "red"
            rr2.color = "red"
            ry1.color = "yellow"
            ry2.color = "yellow"
            rg1.color = "green"
            rg2.color = "green"
        }
        else if(distance <= 55)
        {
            lg1.color = "green"
            lg2.color = "green"
            ly1.color = "yellow"
            ly2.color = "yellow"
            lr1.color = "red"

            rr2.color = "red"
            ry1.color = "yellow"
            ry2.color = "yellow"
            rg1.color = "green"
            rg2.color = "green"
        }
        else if(distance <= 70)
        {
            lg1.color = "green"
            lg2.color = "green"
            ly1.color = "yellow"
            ly2.color = "yellow"

            ry1.color = "yellow"
            ry2.color = "yellow"
            rg1.color = "green"
            rg2.color = "green"
        }
        else if(distance <= 85)
        {
            lg1.color = "green"
            lg2.color = "green"
            ly1.color = "yellow"

            ry2.color = "yellow"
            rg1.color = "green"
            rg2.color = "green"
        }
        else if(distance <= 100)
        {
            lg1.color = "green"
            lg2.color = "green"

            rg1.color = "green"
            rg2.color = "green"
        }
        else if(distance > 101)
        {
            lg1.color = "green"

            rg2.color = "green"
        }
    }

        Rectangle {
        anchors.fill: parent
        color: "transparent"
        border {
            color: "black"
            width: 1
        }
        radius: root.indicatorRadius

        Item {
            width: parent.width * 0.7
            height: parent.height - 10
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            Rectangle {
                id: leftIndicator
                width: parent.width * 0.3
                height: parent.height
                color: "transparent"
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                Row {
                    anchors.fill: parent
                    spacing: 4
                    Rectangle {
                        id: lg1
                        width: parent.width / 6.6
                        height: parent.height * 0.5
                        anchors.verticalCenter: parent.verticalCenter
//                        color: "green"
                        radius: root.indicatorRadius
                        color: "transparent"
                    }
                    Rectangle {
                        id: lg2
                        width: parent.width / 6.6
                        height: parent.height * 0.6
                        anchors.verticalCenter: parent.verticalCenter
//                        color: "green"
                        radius: root.indicatorRadius
                        color: "transparent"
                    }
                    Rectangle {
                        id: ly1
                        width: parent.width / 6.6
                        height: parent.height * 0.7
                        anchors.verticalCenter: parent.verticalCenter
//                        color: "yellow"
                        radius: root.indicatorRadius
                        color: "transparent"
                    }
                    Rectangle {
                        id: ly2
                        width: parent.width / 6.6
                        height: parent.height * 0.8
                        anchors.verticalCenter: parent.verticalCenter
//                        color: "yellow"
                        radius: root.indicatorRadius
                        color: "transparent"
                    }
                    Rectangle {
                        id: lr1
                        width: parent.width / 6.6
                        height: parent.height * 0.9
                        anchors.verticalCenter: parent.verticalCenter
//                        color: "red"
                        radius: root.indicatorRadius
                        color: "transparent"
                    }
                    Rectangle {
                        id: lr2
                        width: parent.width / 6.6
                        height: parent.height * 1
                        anchors.verticalCenter: parent.verticalCenter
//                        color: "red"
                        radius: root.indicatorRadius
                        color: "transparent"
                    }
                }
            }

            Rectangle {
                id: distanceDigital
                width: parent.width * 0.2
                height: parent.height
                color: "white"
                anchors.centerIn: parent
                radius: root.indicatorRadius
                Text {
                    text: digitalDistance.toString()
                    font.pixelSize: parent.height * 0.9
                    anchors.centerIn: parent
                }
            }
            Rectangle {
                id: rightIndicator
                width: parent.width * 0.3
                height: parent.height
                color: "transparent"
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                Row {
                    anchors.fill: parent
                    spacing: 4
                    Rectangle {
                        id: rr1
                        width: parent.width / 6.6
                        height: parent.height * 1
                        anchors.verticalCenter: parent.verticalCenter
//                        color: "red"
                        color: "transparent"
                        radius: root.indicatorRadius
                    }
                    Rectangle {
                        id: rr2
                        width: parent.width / 6.6
                        height: parent.height * 0.9
                        anchors.verticalCenter: parent.verticalCenter
//                        color: "red"
                        color: "transparent"
                        radius: root.indicatorRadius
                    }
                    Rectangle {
                        id: ry1
                        width: parent.width / 6.6
                        height: parent.height * 0.8
                        anchors.verticalCenter: parent.verticalCenter
//                        color: "yellow"
                        color: "transparent"
                        radius: root.indicatorRadius
                    }
                    Rectangle {
                        id: ry2
                        width: parent.width / 6.6
                        height: parent.height * 0.7
                        anchors.verticalCenter: parent.verticalCenter
//                        color: "yellow"
                        color: "transparent"
                        radius: root.indicatorRadius
                    }
                    Rectangle {
                        id: rg1
                        width: parent.width / 6.6
                        height: parent.height * 0.6
                        anchors.verticalCenter: parent.verticalCenter
//                        color: "green"
                        color: "transparent"
                        radius: root.indicatorRadius
                    }
                    Rectangle {
                        id: rg2
                        width: parent.width / 6.6
                        height: parent.height * 0.5
                        anchors.verticalCenter: parent.verticalCenter
//                        color: "green"
                        color: "transparent"
                        radius: root.indicatorRadius
                    }
                }
            }
        }
    }
}
