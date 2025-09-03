import qs
import qs.services
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.common.functions
import "./quickToggles/"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell.Io
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

// Scope {
//     id: root
//     property int sidebarWidth: Appearance.sizes.sidebarWidth
//     property int sidebarPadding: 12
//     property string settingsQmlPath: Quickshell.shellPath("settings.qml")
//
//     property ShellScreen screen
//     signal opened
//     signal closed
//
//     Component.onCompleted: {
//         PanelService.registerPanel(root);
//     }
//
//     // -----------------------------------------
//     function toggle(aScreen, buttonItem) {
//         if (!GlobalStates.sidebarRightOpen || isClosing) {
//             open(aScreen, buttonItem);
//         } else {
//             close();
//         }
//     }
//
//     // -----------------------------------------
//     function open(aScreen, buttonItem) {
//         if (aScreen !== null) {
//             screen = aScreen;
//         }
//         GlobalStates.sidebarRightOpen = true;
//
//         // Get t button position if provided
//         if (buttonItem !== undefined && buttonItem !== null) {
//             useButtonPosition = true;
//
//             var itemPos = buttonItem.mapToItem(null, 0, 0);
//             buttonPosition = Qt.point(itemPos.x, itemPos.y);
//             buttonWidth = buttonItem.width;
//             buttonHeight = buttonItem.height;
//         } else {
//             useButtonPosition = false;
//         }
//
//         // Special case if currently closing/animating
//         if (isClosing) {
//             hideTimer.stop(); // in case we were closing
//             scaleValue = 1.0;
//             opacityValue = 1.0;
//         }
//
//         PanelService.willOpenPanel(root);
//
//         active = true;
//         root.opened();
//     }
//
//     // -----------------------------------------
//     function close() {
//         GlobalStates.sidebarRightOpen = false;
//         scaleValue = originalScale;
//         opacityValue = originalOpacity;
//         hideTimer.start();
//     }
//
//     // -----------------------------------------
//     function closeCompleted() {
//         root.closed();
//         active = false;
//         useButtonPosition = false; // Reset button position usage
//     }
//
//     // -----------------------------------------
//     // Timer to disable the loader after the close animation is completed
//     Timer {
//         id: hideTimer
//         interval: 450
//         repeat: false
//         onTriggered: {
//             closeCompleted();
//         }
//     }
//
//     PanelWindow {
//         id: sidebarShield
//         visible: GlobalStates.sidebarRightOpen
//         color: "#FFF"
//         exclusiveZone: 0
//         WlrLayershell.namespace: "quickshell:sidebarRightShield"
//         // WlrLayershell.layer: WlrLayershell.Overlay
//         //WlrLayershell.exclusiveZone: -1
//         WlrLayershell.exclusionMode: ExclusionMode.Ignore
//         WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
//
//
//         // anchors {
//         //     top: true
//         //     right: false
//         //     bottom: true
//         //     left: true
//         // }
//         anchors.top: true
//         anchors.left: true
//         anchors.right: true
//         anchors.bottom: true
//         margins.top: Appearance.sizes.barHeight// !barAtBottom ? barHeight : 0
//         margins.bottom: 0
//         // width: Screen.width - sidebarWidth
//
//         Shortcut {
//             sequences: ["Escape"]
//             enabled: GlobalStates.sidebarRightOpen && !root.isClosing
//             onActivated: root.close()
//             context: Qt.WindowShortcut
//         }
//
//         // Clicking outside of the rectangle to close
//         MouseArea {
//             anchors.fill: parent
//             onClicked: root.close()
//         }
//     }
//
//     PanelWindow {
//         id: sidebarRoot
//         visible: GlobalStates.sidebarRightOpen
//
//         exclusiveZone: 0
//         implicitWidth: sidebarWidth
//         WlrLayershell.namespace: "quickshell:sidebarRight"
//         WlrLayershell.keyboardFocus: GlobalStates.sidebarRightOpen ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None
//         color: "transparent"
//
//         anchors {
//             top: true
//             right: true
//             bottom: true
//         }
//
//         // HyprlandFocusGrab {
//         //     id: grab
//         //     windows: [sidebarRoot]
//         //     active: GlobalStates.sidebarRightOpen
//         //     onCleared: () => {
//         //         if (!active)
//         //             root.hide();
//         //     }
//         // }
//
//         Loader {
//             id: sidebarContentLoader
//             active: GlobalStates.sidebarRightOpen
//             anchors {
//                 top: parent.top
//                 bottom: parent.bottom
//                 right: parent.right
//                 left: parent.left
//                 topMargin: Appearance.sizes.hyprlandGapsOut
//                 rightMargin: Appearance.sizes.hyprlandGapsOut
//                 bottomMargin: Appearance.sizes.hyprlandGapsOut
//                 leftMargin: Appearance.sizes.elevationMargin
//             }
//             width: sidebarWidth - Appearance.sizes.hyprlandGapsOut - Appearance.sizes.elevationMargin
//             height: parent.height - Appearance.sizes.hyprlandGapsOut * 2
//
//             focus: GlobalStates.sidebarRightOpen
//
//             // Keys.onPressed: event => {
//             //     if (event.key === Qt.Key_Escape) {
//             //         root.hide();
//             //     }
//             // }
//
//             MouseArea {
//                 anchors.fill: parent
//             }
//             sourceComponent: Item {
//                 implicitHeight: sidebarRightBackground.implicitHeight
//                 implicitWidth: sidebarRightBackground.implicitWidth
//
//                 StyledRectangularShadow {
//                     target: sidebarRightBackground
//                 }
//                 Rectangle {
//                     id: sidebarRightBackground
//
//                     anchors.fill: parent
//                     implicitHeight: parent.height - Appearance.sizes.hyprlandGapsOut * 2
//                     implicitWidth: sidebarWidth - Appearance.sizes.hyprlandGapsOut * 2
//                     color: Appearance.colors.colLayer0
//                     border.width: 1
//                     border.color: Appearance.m3colors.m3outlineVariant
//                     radius: Appearance.rounding.screenRounding - Appearance.sizes.hyprlandGapsOut + 1
//
//                     MouseArea {
//                         anchors.fill: parent
//                     }
//
//                     ColumnLayout {
//                         anchors.fill: parent
//                         anchors.margins: sidebarPadding
//                         spacing: sidebarPadding
//
//                         RowLayout {
//                             Layout.fillHeight: false
//                             spacing: 10
//                             Layout.margins: 10
//                             Layout.topMargin: 5
//                             Layout.bottomMargin: 0
//
//                             Item {
//                                 implicitWidth: distroIcon.width
//                                 implicitHeight: distroIcon.height
//                                 CustomIcon {
//                                     id: distroIcon
//                                     width: 25
//                                     height: 25
//                                     source: SystemInfo.distroIcon
//                                 }
//                                 ColorOverlay {
//                                     anchors.fill: distroIcon
//                                     source: distroIcon
//                                     color: Appearance.colors.colOnLayer0
//                                 }
//                             }
//
//                             StyledText {
//                                 font.pixelSize: Appearance.font.pixelSize.normal
//                                 color: Appearance.colors.colOnLayer0
//                                 text: Translation.tr("Uptime: %1").arg(DateTime.uptime)
//                                 textFormat: Text.MarkdownText
//                             }
//
//                             Item {
//                                 Layout.fillWidth: true
//                             }
//
//                             ButtonGroup {
//                                 QuickToggleButton {
//                                     toggled: false
//                                     buttonIcon: "restart_alt"
//                                     onClicked: {
//                                         Hyprland.dispatch("reload");
//                                         Quickshell.reload(true);
//                                     }
//                                     StyledToolTip {
//                                         content: "Reload Hyprland & Quickshell"
//                                     }
//                                 }
//                                 QuickToggleButton {
//                                     toggled: false
//                                     buttonIcon: "settings"
//                                     onClicked: {
//                                         Hyprland.dispatch("global quickshell:sidebarRightClose");
//                                         Quickshell.execDetached(["qs", "-p", root.settingsQmlPath]);
//                                     }
//                                     StyledToolTip {
//                                         content: "Settings"
//                                     }
//                                 }
//                                 QuickToggleButton {
//                                     toggled: false
//                                     buttonIcon: "power_settings_new"
//                                     onClicked: {
//                                         Quickshell.execDetached(["qs", "ipc", "call", "session", "open"]);
//                                         //Hyprland.dispatch("global quickshell:sessionOpen");
//                                     }
//                                     StyledToolTip {
//                                         content: "Session"
//                                     }
//                                 }
//                             }
//                         }
//
//                         ButtonGroup {
//                             Layout.alignment: Qt.AlignHCenter
//                             spacing: 5
//                             padding: 5
//                             color: Appearance.colors.colLayer1
//
//                             NetworkToggle {}
//                             BluetoothToggle {}
//                             NightLight {}
//                             GameMode {}
//                             IdleInhibitor {}
//                             EasyEffectsToggle {}
//                         }
//
//                         // Center widget group
//                         CenterWidgetGroup {
//                             focus: sidebarRoot.visible
//                             Layout.alignment: Qt.AlignHCenter
//                             Layout.fillHeight: true
//                             Layout.fillWidth: true
//                         }
//
//                         BottomWidgetGroup {
//                             Layout.alignment: Qt.AlignHCenter
//                             Layout.fillHeight: false
//                             Layout.fillWidth: true
//                             Layout.preferredHeight: implicitHeight
//                         }
//                     }
//                 }
//             }
//         }
//     }
//
//     // function toggle() {
//     //     GlobalStates.sidebarRightOpen = !GlobalStates.sidebarRightOpen;
//     //     if (GlobalStates.sidebarRightOpen)
//     //         Notifications.timeoutAll();
//     // }
//
//     function show() {
//         GlobalStates.sidebarRightOpen = true;
//     }
//
//     function hide() {
//         GlobalStates.sidebarRightOpen = false;
//     }
//
//     IpcHandler {
//         id: sidebarRightHandler
//         target: "sidebarRight"
//
//         function toggle(): void {
//             GlobalStates.sidebarRightOpen = !GlobalStates.sidebarRightOpen;
//             if (GlobalStates.sidebarRightOpen)
//                 Notifications.timeoutAll();
//         }
//
//         function open(): void {
//             GlobalStates.sidebarRightOpen = true;
//             Notifications.timeoutAll();
//         }
//
//         function close(): void {
//             GlobalStates.sidebarRightOpen = false;
//         }
//     }
//
//     GlobalShortcut {
//         name: "sidebarRightToggle"
//         description: "Toggles right sidebar on press"
//
//         onPressed: {
//             GlobalStates.sidebarRightOpen = !GlobalStates.sidebarRightOpen;
//             if (GlobalStates.sidebarRightOpen)
//                 Notifications.timeoutAll();
//         }
//     }
//     GlobalShortcut {
//         name: "sidebarRightOpen"
//         description: "Opens right sidebar on press"
//
//         onPressed: {
//             GlobalStates.sidebarRightOpen = true;
//             Notifications.timeoutAll();
//         }
//     }
//     GlobalShortcut {
//         name: "sidebarRightClose"
//         description: "Closes right sidebar on press"
//
//         onPressed: {
//             GlobalStates.sidebarRightOpen = false;
//         }
//     }
// }

SidebarRightWrapper {
    id: root

    property string settingsQmlPath: Quickshell.shellPath("settings.qml")

    property int sidebarWidth: Appearance.sizes.sidebarWidth

    panelWidth: Appearance.sizes.sidebarWidth//460 * scaling
    // panelHeight: 1980// 700 * scaling
    panelAnchorRight: false

    panelContent: ColumnLayout {
        anchors.fill: parent
        //anchors.margins: sidebarPadding
        //spacing: sidebarPadding

        RowLayout {
            Layout.fillHeight: false
            spacing: 10
            Layout.margins: 10
            Layout.topMargin: 5
            Layout.bottomMargin: 0

            Item {
                implicitWidth: distroIcon.width
                implicitHeight: distroIcon.height
                CustomIcon {
                    id: distroIcon
                    width: 25
                    height: 25
                    source: SystemInfo.distroIcon
                }
                ColorOverlay {
                    anchors.fill: distroIcon
                    source: distroIcon
                    color: Appearance.colors.colOnLayer0
                }
            }

            StyledText {
                font.pixelSize: Appearance.font.pixelSize.normal
                color: Appearance.colors.colOnLayer0
                text: Translation.tr("Uptime: %1").arg(DateTime.uptime)
                textFormat: Text.MarkdownText
            }

            Item {
                Layout.fillWidth: true
            }

            ButtonGroup {
                QuickToggleButton {
                    toggled: false
                    buttonIcon: "restart_alt"
                    onClicked: {
                        Hyprland.dispatch("reload");
                        Quickshell.reload(true);
                    }
                    StyledToolTip {
                        content: "Reload Hyprland & Quickshell"
                    }
                }
                QuickToggleButton {
                    toggled: false
                    buttonIcon: "settings"
                    onClicked: {
                        Hyprland.dispatch("global quickshell:sidebarRightClose");
                        Quickshell.execDetached(["qs", "-p", root.settingsQmlPath]);
                    }
                    StyledToolTip {
                        content: "Settings"
                    }
                }
                QuickToggleButton {
                    toggled: false
                    buttonIcon: "power_settings_new"
                    onClicked: {
                        Quickshell.execDetached(["qs", "ipc", "call", "session", "open"]);
                        //Hyprland.dispatch("global quickshell:sessionOpen");
                    }
                    StyledToolTip {
                        content: "Session"
                    }
                }
            }
        }

        ButtonGroup {
            Layout.alignment: Qt.AlignHCenter
            spacing: 5
            padding: 5
            color: Appearance.colors.colLayer1

            NetworkToggle {}
            BluetoothToggle {}
            NightLight {}
            GameMode {}
            IdleInhibitor {}
            EasyEffectsToggle {}
        }

        // Center widget group
        CenterWidgetGroup {
            //   focus: sidebarRoot.visible
            Layout.alignment: Qt.AlignHCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        IpcHandler {
            id: sidebarRightHandler
            target: "sidebarRight"

            function toggle(): void {
                GlobalStates.sidebarRightOpen = !GlobalStates.sidebarRightOpen;
                if (GlobalStates.sidebarRightOpen)
                    Notifications.timeoutAll();
            }

            function open(): void {
                GlobalStates.sidebarRightOpen = true;
                Notifications.timeoutAll();
            }

            function close(): void {
                GlobalStates.sidebarRightOpen = false;
            }
        }

        // BottomWidgetGroup {
        //     Layout.alignment: Qt.AlignHCenter
        //     Layout.fillHeight: false
        //     Layout.fillWidth: true
        //     Layout.preferredHeight: implicitHeight
        // }
    }
}

// NPanel {
//     id: panel
//
//     panelWidth: 460 * scaling
//     panelHeight: 700 * scaling
//     panelAnchorRight: true
//
//     panelContent: Item {
//         id: content
//
//         property real cardSpacing: 10
//
//         anchors.left: parent.left
//         anchors.right: parent.right
//         anchors.top: parent.top
//         anchors.margins: 20
//         implicitHeight: layout.implicitHeight
//
//         // Layout content (not vertically anchored so implicitHeight is valid)
//         ColumnLayout {
//             id: layout
//             // Use the same spacing value horizontally and vertically
//             anchors.left: parent.left
//             anchors.right: parent.right
//             anchors.top: parent.top
//             spacing: content.cardSpacing
//
//             // Cards (consistent inter-card spacing via ColumnLayout spacing)
//             // Layout.topMargin: 0
//             // Layout.bottomMargin: 0
//             // Layout.topMargin: 0
//             // Layout.bottomMargin: 0
//
//             // Middle section: media + stats column
//             RowLayout {
//                 Layout.fillWidth: true
//                 Layout.topMargin: 0
//                 Layout.bottomMargin: 0
//                 spacing: 1
//             }
//
//             // Bottom actions (two grouped rows of round buttons)
//             RowLayout {
//                 Layout.fillWidth: true
//                 Layout.topMargin: 0
//                 Layout.bottomMargin: 0
//                 spacing:10
//             }
//         }
//     }
// }
