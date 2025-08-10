import qs.modules.common
import qs.modules.common.widgets
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

Item {
    id: root

    required property var bar

    height: parent.height
    implicitWidth: rowLayout.implicitWidth
    Layout.margins: Config.options.bar.borderless ? 0 : 5

    implicitHeight: Appearance.sizes.barHeight

    RowLayout {
        id: rowLayout
        anchors.fill: parent
        spacing: 13

        Repeater {
            model: SystemTray.items

            SysTrayItem {
                required property SystemTrayItem modelData

                bar: root.bar
                item: modelData
            }
        }

        StyledText {
            Layout.alignment: Qt.AlignVCenter
            font.pixelSize: Appearance.font.pixelSize.larger
            color: Appearance.colors.colSubtext
            text: "•"
            visible: {
                Config.options.bar.borderless && SystemTray.items.values.length > 0;
            }
        }
    }
}
