import qs.modules.common
import qs.modules.common.widgets
import qs.services
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

Item {
    id: root
    property int count: Notifications.list.length
    height: 20
    visible: count > 0 || Notifications.silent 

    RowLayout {
        anchors.margins: 2
        spacing: 2

        StyledText {
            font.pixelSize: 15
            text: count > 99 ? "99+" : count.toString()
            color: Appearance.colors.colOnLayer0
            visible: count > 0 
        }

        MaterialSymbol {
            id: icon
            iconSize: 20
            text: Notifications.silent ? "notifications_paused" : "notifications"
            color: Appearance.colors.colOnLayer0
        }

    
    }
}
