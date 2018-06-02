import QtQuick 2.2
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import "content"
import "content/ColorUtils.js" as ColorUtils

Item {
    id: root
    focus: true

    property vector4d colorHSVA: Qt.vector4d(1, 0, 1, 1)
    property vector4d colorRGBA: ColorUtils.hsva2rgba(root.colorHSVA)
    property vector3d colors

    signal accepted
    signal doubleClick

    onAccepted: {
        colors = Qt.vector3d(Math.round(colorRGBA.x * 255), Math.round(colorRGBA.y * 255), Math.round(colorRGBA.z * 255))
    }

    Wheel {
        id: wheel
        hue: colorHSVA.x
        anchors.fill: parent
        saturation: colorHSVA.y
        onUpdateHS: {
            colorHSVA = Qt.vector4d(hueSignal,saturationSignal, colorHSVA.z, colorHSVA.w)
        }
        onAccepted: {
            root.accepted()
        }
    }
}
