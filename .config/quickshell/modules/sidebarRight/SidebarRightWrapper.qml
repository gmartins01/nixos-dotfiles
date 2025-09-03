import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import qs
import qs.services
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.common.functions

Loader {
    id: root

    active: false
    asynchronous: true

    property ShellScreen screen
    readonly property real scaling: 1

    property Component panelContent: null
    property int panelWidth: 1500
    property int panelHeight: 400
    property color panelBackgroundColor: Appearance.m3colors.m3surface

    property bool panelAnchorHorizontalCenter: false
    property bool panelAnchorVerticalCenter: false
    property bool panelAnchorTop: false
    property bool panelAnchorBottom: false
    property bool panelAnchorLeft: false
    property bool panelAnchorRight: false

    // Properties to support positioning relative to the opener (button)
    property bool useButtonPosition: false
    property point buttonPosition: Qt.point(0, 0)
    property int buttonWidth: 0
    property int buttonHeight: 0

    // Animation properties
    readonly property real originalScale: 1
    readonly property real originalOpacity: 1
    property real scaleValue: originalScale
    property real opacityValue: originalOpacity

    readonly property real barHeight: Appearance.sizes.barHeight
    readonly property bool barAtBottom: false

    signal opened
    signal closed

    Component.onCompleted: {
        PanelService.registerPanel(root);
    }

    // -----------------------------------------
    function toggle(aScreen, buttonItem) {
        if (!active) {
            open(aScreen, buttonItem);
        } else {
            close();
        }
    }

    // -----------------------------------------
    function open(aScreen, buttonItem) {
        if (aScreen !== null) {
            screen = aScreen;
        }

        // Get t button position if provided
        if (buttonItem !== undefined && buttonItem !== null) {
            useButtonPosition = true;

            var itemPos = buttonItem.mapToItem(null, 0, 0);
            buttonPosition = Qt.point(itemPos.x, itemPos.y);
            buttonWidth = buttonItem.width;
            buttonHeight = buttonItem.height;
        } else {
            useButtonPosition = false;
        }

        PanelService.willOpenPanel(root);
        GlobalStates.sidebarRightOpen = true;
        active = true;
        root.opened();
    }

    // -----------------------------------------
    function close() {
        scaleValue = originalScale;
        opacityValue = originalOpacity;
        //hideTimer.start();
        closeCompleted();
    }

    // -----------------------------------------
    function closeCompleted() {
        root.closed();
        GlobalStates.sidebarRightOpen = false;
        active = false;
        useButtonPosition = false; // Reset button position usage
    }

    // -----------------------------------------

    // -----------------------------------------
    sourceComponent: Component {

        PanelWindow {
            id: panelWindow

            visible: true

            // Dim desktop if required
            color: "transparent"//(root.active && !root.isClosing && Settings.data.general.dimDesktop) ? Color.applyOpacity(Color.mShadow, "BB") : Color.transparent

            WlrLayershell.exclusionMode: ExclusionMode.Ignore
            WlrLayershell.namespace: "quickshell:sidebarRight"
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand

            //
            anchors.top: true
            anchors.left: true
            anchors.right: true
            anchors.bottom: true
            margins.top: barHeight// !barAtBottom ? barHeight : 0
            margins.bottom: 0//barAtBottom ? barHeight : 0

            // Close any panel with Esc without requiring focus
            Shortcut {
                sequences: ["Escape"]
                enabled: root.active
                onActivated: root.close()
                context: Qt.WindowShortcut
            }

            // Clicking outside of the rectangle to close
            MouseArea {
                anchors.fill: parent
                onClicked: root.close()
            }

            Rectangle {
                id: panelBackground
                //color: "transparent"
                // radius: Style.radiusL * scaling
                //border.color: Color.mOutline
                //border.width: Math.max(1, Style.borderS * scaling)
                layer.enabled: true
                //width: panelWidth
                //height: panelHeight

                scale: root.scaleValue
                // opacity: root.opacityValue
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    right: parent.right
                    topMargin: Appearance.sizes.hyprlandGapsOut
                    rightMargin: Appearance.sizes.hyprlandGapsOut
                    bottomMargin: Appearance.sizes.hyprlandGapsOut
                    leftMargin: Appearance.sizes.elevationMargin
                }

                //anchors.fill: parent
                implicitHeight: parent.height - Appearance.sizes.hyprlandGapsOut * 2
                implicitWidth: sidebarWidth - Appearance.sizes.hyprlandGapsOut * 2
                color: Appearance.colors.colLayer0
                border.width: 1
                border.color: Appearance.m3colors.m3outlineVariant
                radius: Appearance.rounding.screenRounding - Appearance.sizes.hyprlandGapsOut + 1

                // width: panelWidth - Appearance.sizes.hyprlandGapsOut - Appearance.sizes.elevationMargin
                //height: parent.height - Appearance.sizes.hyprlandGapsOut * 2

                // x: calculatedX
                // y: calculatedY

                // Animate in when component is completed

                // Prevent closing when clicking in the panel bg
                MouseArea {
                    anchors.fill: parent
                }

                Loader {
                    anchors {
                        top: parent.top
                        bottom: parent.bottom
                        right: parent.right
                        left: parent.left
                        topMargin: Appearance.sizes.hyprlandGapsOut
                        rightMargin: Appearance.sizes.hyprlandGapsOut
                        bottomMargin: Appearance.sizes.hyprlandGapsOut
                        leftMargin: Appearance.sizes.elevationMargin
                    }
                    width: panelWidth - Appearance.sizes.hyprlandGapsOut - Appearance.sizes.elevationMargin
                    height: parent.height - Appearance.sizes.hyprlandGapsOut * 2

                    sourceComponent: root.panelContent
                }
            }
        }
    }
}
