import qs.modules.common
import qs.modules.common.functions
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import Qt5Compat.GraphicalEffects
import Quickshell.Io

MouseArea {
    id: root

    required property var bar
    required property SystemTrayItem item
    property int trayItemWidth: Appearance.font.pixelSize.larger

    property var ignoredClasses: ["xwaylandvideobridge", "blueman", "Stremio", "Polychromatic"]

    signal menuRequested(var menu, var item, real x, real y)

    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
    Layout.fillHeight: true
    implicitWidth: trayItemWidth

    visible: !ignoredClasses.includes(item.title)

    onClicked: event => {
        switch (event.button) {
        case Qt.LeftButton:
            item.activate();
            break;
        case Qt.RightButton:
            if (item.hasMenu) {
                //root.menuRequested(null, item, event.x, event.y);
                menu.iconPos = root.mapToItem(bar.contentItem, -60, 0);
                menu.open();
            }
            break;
        case Qt.MiddleButton:
            Quickshell.execDetached(["notify-send", "Tray Icon Title", `${item.title || item.tooltipTitle}`, "-a", "Shell"]);
            break;
        }
        event.accepted = true;
    }

    onMenuRequested: (currMenu, item, x, y) => {
        console.log("aqui", item.x, bar.width);
        var pt = root.mapToItem(bar.contentItem, x, 0);

        var menuW = systemTrayContextMenu.implicitWidth;

        var rawX = pt.x - menuW;

        var maxX = bar.contentItem.width - menuW;
        var clampedX = Math.max(0, Math.min(rawX, maxX));

        systemTrayContextMenu.contextMenuX = clampedX;
        systemTrayContextMenu.contextMenuY = Appearance.sizes.barHeight + 4; // ou o offset vertical que quiseres

        systemTrayContextMenu.currentTrayItem = item;
        systemTrayContextMenu.currentTrayMenu = currMenu;
        systemTrayContextMenu.showContextMenu = true;
    }

    QsMenuAnchor {
        id: menu

        menu: root.item.menu
        anchor.window: bar
        /*
        anchor.rect.x: root.x + bar.width
        anchor.rect.y: root.y
        anchor.rect.height: root.height
        anchor.edges: Edges.Bottom*/
        property var iconPos: root.mapToItem(bar.contentItem, 0, 0)

        anchor.rect: Qt.rect(iconPos.x, iconPos.y + root.height + 5, root.width, root.height)
    }

    IconImage {
        id: trayIcon
        //visible: !Config.options.bar.tray.monochromeIcons
        source: {
            let icon = root.item.icon;
            if (icon.includes("?path=")) {
                const [name, path] = icon.split("?path=");
                icon = `file://${path}/${name.slice(name.lastIndexOf("/") + 1)}`;
            }
            return icon;
        }
        anchors.centerIn: parent
        width: parent.width
        height: parent.height

        asynchronous: true
    }

    Loader {
        active: Config.options.bar.tray.monochromeIcons
        anchors.fill: trayIcon
        sourceComponent: Item {
            Desaturate {
                id: desaturatedIcon
                visible: false // There's already color overlay
                anchors.fill: parent
                source: trayIcon
                desaturation: 0.5 // 1.0 means fully grayscale
            }
            ColorOverlay {
                anchors.fill: desaturatedIcon
                source: desaturatedIcon
                color: ColorUtils.transparentize(Appearance.colors.colOnLayer0, 0.9)
            }
        }
    }

    SysTrayItemMenu {
        id: systemTrayContextMenu
    }
}
