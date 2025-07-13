import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import Quickshell.Services.Notifications

import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root
    property var bar

    visible: SystemTray.items.values.length
    height: 30
    color: "transparent"

    property var ignoredClasses: ["xwaylandvideobridge"]

    RowLayout {
        anchors.centerIn: parent
        spacing: 8

        Repeater {
            model: SystemTray.items

            Rectangle {
                id: sysItem
                required property var modelData
                Layout.alignment: Qt.AlignCenter
                height: 21
                width: 21
                color: "transparent"
                visible: !ignoredClasses.includes(modelData.title)

                IconImage {
                    anchors.centerIn: parent
                    width: 20
                    height: 20
                    source: modelData.icon
                }

                QsMenuAnchor {
                    id: menu
                    menu: sysItem.modelData.menu
                    anchor.window: root.bar
                    anchor.rect: Qt.rect(sysItem.x, sysItem.y + sysItem.height + root.height, sysItem.width, sysItem.height)
                }

                MouseArea {
                    anchors.fill: parent

                    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

                    onClicked: event => {
                        if (event.button === Qt.LeftButton) {
                            modelData.activate();
                        } else if (event.button === Qt.RightButton && modelData.hasMenu) {
                            menu.open();
                        } else {
                            console.log("Systray item title:", modelData.title || modelData.tooltipTitle);
                        }
                    }
                }
            }
        }
    }
}
