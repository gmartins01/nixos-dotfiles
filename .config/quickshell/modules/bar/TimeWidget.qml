import QtQuick
import Quickshell
import QtQuick.Layouts

Rectangle {
    id: root
    width: iconBg.implicitWidth + textBg.implicitWidth
    height: 35
    radius: 5
    color: "#24273A"

    RowLayout {
        anchors.fill: parent
        spacing: 0

        Rectangle {
            id: iconBg
            implicitHeight: root.height
            implicitWidth: iconBg.height
            topLeftRadius: root.radius
            bottomLeftRadius: root.radius
            color: "#B7BCF8"

            Layout.alignment: Qt.AlignVCenter | Qt.AlignCenter
            Layout.leftMargin: 0

            Text {
                anchors.centerIn: parent
                text: "󰥔"
                font.family: "Jetbrains Mono NF"
                font.pixelSize: 22
                font.weight: Font.Bold
                color: "#24273A"
            }
        }

        Rectangle {
            id: textBg
            implicitHeight: root.height
            implicitWidth: timeText.paintedWidth + 15
            radius: root.radius
            color: root.color

            Layout.alignment: Qt.AlignVCenter | Qt.AlignCenter
            Layout.rightMargin: 0

            Text {
                id: timeText
                anchors.centerIn: parent
                text: Time.time
                font.family: "Jetbrains Mono NF"
                font.pixelSize: 16
                font.weight: Font.Bold
                color: "#B7BCF8"
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        //onEntered: parent.color = "#B7BCF8"
        //onExited: parent.color = "#B7BCF8"
        //onClicked: banging
    }
}
