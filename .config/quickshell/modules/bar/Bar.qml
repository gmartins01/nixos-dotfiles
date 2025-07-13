import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

Scope {
    id: bar

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: barWindow
            property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            color: "transparent"

            implicitHeight: barBase.height

            Rectangle {
                id: barBase
                anchors.top: parent.top
                anchors.topMargin: 0
                height: 45
                width: parent.width
                color: '#181926'

                RowLayout {
                    height: 10
                    spacing: 10
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom

                    anchors.topMargin: 5
                    anchors.bottomMargin: 10
                    anchors.leftMargin: 15

                    Rectangle {
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                        Layout.preferredWidth: 35
                        Layout.preferredHeight: 35

                        radius: 5
                        color: "#B7BCF8"
                        Text {
                            anchors.centerIn: parent
                            text: ""
                            font.family: "Jetbrains Mono NF"

                            color: "#181926"
                            font.pixelSize: 20
                            font.weight: 300
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
                }

                RowLayout {
                    height: 10
                    spacing: 20
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom

                    anchors.topMargin: 5
                    anchors.bottomMargin: 10
                    anchors.rightMargin: 10

                    TrayWidget {
                        bar: bar
                    }
                    SysTray {
                        Layout.preferredWidth: (SystemTray.items.values.length * 25)

                        bar: barWindow
                    }
                    TimeWidget {}
                }
            }
        }
    }
}
