pragma ComponentBehavior: Bound

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
    implicitHeight: parent.height

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
                    source: {
                        let icon = sysItem.modelData.icon;
                        if (icon.includes("?path=")) {
                            const [name, path] = icon.split("?path=");
                            icon = `file://${path}/${name.slice(name.lastIndexOf("/") + 1)}`;
                        }
                        return icon;
                    }
                    asynchronous: true
                }

                QsMenuAnchor {
                    id: menu
                    menu: modelData.menu

                    anchor.window: root.bar

                    property var iconPos: sysItem.mapToItem(root.bar.contentItem, 0, 0)

                    anchor.rect: Qt.rect(iconPos.x, iconPos.y + sysItem.height + 5, sysItem.width, sysItem.height)
                }

                MouseArea {
                    anchors.fill: parent

                    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

                    onClicked: event => {
                        if (event.button === Qt.LeftButton) {
                            modelData.activate();
                        } else if (event.button === Qt.RightButton && modelData.hasMenu) {
                            menu.iconPos  = sysItem.mapToItem(root.bar.contentItem,-75, 0);

                         

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
