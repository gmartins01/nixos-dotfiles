import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import qs.modules.common
import qs.modules.common.widgets

PanelWindow {
    id: root

    property bool showContextMenu: false
    property real contextMenuX: 0
    property real contextMenuY: 0
    property var currentTrayMenu: null
    property var currentTrayItem: null

    visible: showContextMenu
    WlrLayershell.layer: WlrLayershell.Overlay
    WlrLayershell.exclusiveZone: -1
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
    color: "transparent"

    anchors {
        top: true
        left: true
        right: true
        bottom: true
    }

    Rectangle {
        id: menuContainer

        x: contextMenuX
        y: contextMenuY
        width: Math.max(180, Math.min(300, menuList.maxTextWidth + 10 * 2))
        height: Math.max(60, menuList.contentHeight + 5 * 2)
        color: Appearance.colors.colLayer0
        radius: 5//Theme.cornerRadiusLarge
        border.color: "#FFF"//Theme.outlineMedium
        border.width: 1
        opacity: showContextMenu ? 1 : 0
        scale: showContextMenu ? 1 : 0.85

        Rectangle {
            anchors.fill: parent
            anchors.topMargin: 4
            anchors.leftMargin: 2
            anchors.rightMargin: -2
            anchors.bottomMargin: -4
            radius: parent.radius
            color: Qt.rgba(0, 0, 0, 0.15)
            z: parent.z - 1
        }

        Item {
            anchors.fill: parent
            anchors.margins: 5

            QsMenuOpener {
                id: menuOpener

                menu: currentTrayItem && currentTrayItem.hasMenu ? currentTrayItem.menu : null
            }

            ListView {
                id: menuList

                property real maxTextWidth: {
                    let maxWidth = 0;
                    if (model && model.values) {
                        for (let i = 0; i < model.values.length; i++) {
                            console.log(model.menu)
                            const item = model.values[i];
                            if (item && item.text) {
                                const textWidth = textMetrics.advanceWidth * item.text.length * 0.6;
                                maxWidth = Math.max(maxWidth, textWidth);
                            }
                        }
                    }
                    return Math.min(maxWidth, 400); // Cap at reasonable width
                }

                anchors.fill: parent
                spacing: 1
                model: menuOpener.children

                TextMetrics {
                    id: textMetrics

                    font.pixelSize: Appearance.font.pixelSize.small
                    text: "M"
                }

                delegate: Rectangle {
                    width: ListView.view.width
                    height: modelData.isSeparator ? 5 : 28
                    radius: modelData.isSeparator ? 0 : 5//Theme.cornerRadiusSmall
                    color: modelData.isSeparator ? "transparent" : (menuItemArea.containsMouse ? Appearance.colors.colLayer1Hover : "transparent")

                    Rectangle {
                        // Separators
                        visible: modelData.isSeparator
                        anchors.centerIn: parent
                        width: parent.width - 5 * 2
                        height: 1
                        color: "#FFF"
                    }

                    Row {
                        visible: !modelData.isSeparator
                        anchors.left: parent.left
                        anchors.leftMargin: 5//Theme.spacingS
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 7//Theme.spacingXS

                        StyledText {
                            text: modelData.text || ""

                            color: Appearance.colors.colOnLayer1
                            font.pixelSize: Appearance.font.pixelSize.small
                            font.family: Appearance.font.family.main

                            elide: Text.ElideRight
                            wrapMode: Text.NoWrap
                            clip: true
                        }

                        StyledText {
                            visible: !!modelData.menu
                            text: "›"
                            color: Appearance.colors.colOnLayer1
                            font.pixelSize: Appearance.font.pixelSize.small
                        }
                    }

                    MouseArea {
                        id: menuItemArea

                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: modelData.isSeparator ? Qt.ArrowCursor : Qt.PointingHandCursor
                        enabled: !modelData.isSeparator
                        onClicked: {
                            if (modelData.triggered)
                                modelData.triggered();

                            showContextMenu = false;
                        }
                    }

                    Behavior on color {
                        ColorAnimation {
                            duration: 150 //Theme.shortDuration
                            easing.type: Easing.OutCubic
                        }
                    }
                }

            }
        }

        Behavior on opacity {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutCubic
            }
        }

        Behavior on scale {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutCubic
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        z: -1
        onClicked: {
            showContextMenu = false;
        }
    }
}
