pragma ComponentBehavior: Bound

import qs
import qs.services
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.common.functions as CF
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

Scope {
    id: root
    readonly property bool fixedClockPosition: Config.options.background.fixedClockPosition
    readonly property real fixedClockX: Config.options.background.clockX
    readonly property real fixedClockY: Config.options.background.clockY

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bgRoot

            required property var modelData
 
            // Wallpaper
            property string wallpaperPath: Config.options.background.wallpaperPath
            property bool wallpaperIsVideo: Config.options.background.wallpaperPath.endsWith(".mp4")
                || Config.options.background.wallpaperPath.endsWith(".webm")
                || Config.options.background.wallpaperPath.endsWith(".mkv")
                || Config.options.background.wallpaperPath.endsWith(".avi")
                || Config.options.background.wallpaperPath.endsWith(".mov")            
            property real preferredWallpaperScale: Config.options.background.parallax.workspaceZoom
            property real effectiveWallpaperScale: 1 // Some reasonable init value, to be updated
            property int wallpaperWidth: modelData.width // Some reasonable init value, to be updated
            property int wallpaperHeight: modelData.height // Some reasonable init value, to be updated
            property real movableXSpace: (Math.min(wallpaperWidth * effectiveWallpaperScale, screen.width * preferredWallpaperScale) - screen.width) / 2
            property real movableYSpace: (Math.min(wallpaperHeight * effectiveWallpaperScale, screen.height * preferredWallpaperScale) - screen.height) / 2

            // Colors
            property color dominantColor: Appearance.colors.colPrimary
            property bool dominantColorIsDark: dominantColor.hslLightness < 0.5
            property color colText: CF.ColorUtils.colorWithLightness(Appearance.colors.colPrimary, (dominantColorIsDark ? 0.8 : 0.12))

            // Layer props
            screen: modelData
            exclusionMode: ExclusionMode.Ignore
            WlrLayershell.layer: GlobalStates.screenLocked ? WlrLayer.Top : WlrLayer.Bottom
            // WlrLayershell.layer: WlrLayer.Bottom
            WlrLayershell.namespace: "quickshell:background"
            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }
            color: "transparent"

          

            // Wallpaper
            Image {
                id: wallpaperImage
                visible: !bgRoot.wallpaperIsVideo
                // property real value // 0 to 1, for offset
                // value: {
                //     // Range = half-groups that workspaces span on
                //     const chunkSize = 5;
                //     const lower = Math.floor(bgRoot.firstWorkspaceId / chunkSize) * chunkSize;
                //     const upper = Math.ceil(bgRoot.lastWorkspaceId / chunkSize) * chunkSize;
                //     const range = upper - lower;
                //     return (Config.options.background.parallax.enableWorkspace ? ((bgRoot.monitor.activeWorkspace.id - lower) / range) : 0.5)
                //         + (0.15 * GlobalStates.sidebarRightOpen * Config.options.background.parallax.enableSidebar)
                //         - (0.15 * GlobalStates.sidebarLeftOpen * Config.options.background.parallax.enableSidebar)
                // }
                // property real effectiveValue: Math.max(0, Math.min(1, value))
                // x: -(bgRoot.movableXSpace) - (effectiveValue - 0.5) * 2 * bgRoot.movableXSpace
                // y: -(bgRoot.movableYSpace)
                source: bgRoot.wallpaperPath
                //fillMode: Image.FillMode
                anchors.fill: parent
                Behavior on x {
                    NumberAnimation {
                        duration: 600
                        easing.type: Easing.OutCubic
                    }
                }
                sourceSize {
                    width: bgRoot.screen.width * bgRoot.effectiveWallpaperScale
                    height: bgRoot.screen.height * bgRoot.effectiveWallpaperScale
                }


            }

        }
    }
}
