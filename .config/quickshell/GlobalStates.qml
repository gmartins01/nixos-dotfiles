pragma Singleton
pragma ComponentBehavior: Bound
import qs.modules.common
import qs
import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io

Singleton {
    id: root
    property bool barOpen: true
    property bool sidebarLeftOpen: false
    property bool sidebarRightOpen: false
    property bool overviewOpen: false
    property bool workspaceShowNumbers: false
    property bool superReleaseMightTrigger: true
    property bool screenLocked: false
    property bool screenLockContainsCharacters: false
    property bool isHyprland: false
    property bool isNiri: false

    property var sidebarRightHandler

    property real screenZoom: 1
    onScreenZoomChanged: {
        Quickshell.execDetached(["hyprctl", "keyword", "cursor:zoom_factor", root.screenZoom.toString()]);
    }
    Behavior on screenZoom {
        animation: Appearance.animation.elementMoveFast.numberAnimation.createObject(this)
    }

    // When user is not reluctant while pressing super, they probably don't need to see workspace numbers
    onSuperReleaseMightTriggerChanged: {
        workspaceShowNumbersTimer.stop();
    }

    Timer {
        id: workspaceShowNumbersTimer
        interval: Config.options.bar.workspaces.showNumberDelay
        // interval: 0
        repeat: false
        onTriggered: {
            workspaceShowNumbers = true;
        }
    }

    GlobalShortcut {
        name: "workspaceNumber"
        description: "Hold to show workspace numbers, release to show icons"

        onPressed: {
            workspaceShowNumbersTimer.start();
        }
        onReleased: {
            workspaceShowNumbersTimer.stop();
            workspaceShowNumbers = false;
        }
    }

    IpcHandler {
        target: "zoom"

        function zoomIn() {
            screenZoom = Math.min(screenZoom + 0.4, 3.0);
        }

        function zoomOut() {
            screenZoom = Math.max(screenZoom - 0.4, 1);
        }
    }

    Component.onCompleted: {
        detectCompositor();
    }

    function detectCompositor() {
        try {
            try {
                if (Hyprland.eventSocketPath) {
                    console.log("Detected Hyprland compositor");
                    root.isHyprland = true;
                    root.isNiri = false;
                    return;
                }
            } catch (e) {
                console.log("Hyprland not available:", e);
            }

            if (typeof Niri !== "undefined") {
                console.log("Detected Niri service");
                root.isHyprland = false;
                root.isNiri = true;
                return;
            }

            console.log("No supported compositor detected");
        } catch (e) {
            console.error("Error detecting compositor:", e);
        }
    }
}
