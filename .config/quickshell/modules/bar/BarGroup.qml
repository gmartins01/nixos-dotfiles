import qs.modules.common
import QtQuick
import QtQuick.Layouts

Item {
    id: root
    property real padding: 5
    implicitHeight: Appearance.sizes.baseBarHeight
    height: Appearance.sizes.barHeight
    implicitWidth: rowLayout.implicitWidth + padding * 2
    default property alias items: rowLayout.children

    Rectangle {
        id: background
        anchors {
            fill: parent
            topMargin: 6
            bottomMargin: 6
        }
        color: Config.options?.bar.borderless ? "transparent" : Appearance.colors.colLayer1Alt
        radius: Appearance.rounding.verysmall
    }

    RowLayout {
        id: rowLayout
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            right: parent.right
            leftMargin: root.padding
            rightMargin: root.padding
        }
        spacing: 4

    }
}
