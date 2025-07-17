import QtQuick
import Quickshell
import Quickshell.Hyprland

Item {
    id: root
    implicitWidth: workspaceRow.implicitWidth
    implicitHeight: workspaceRow.implicitHeight

    property string monitorName: ""

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.NoButton

        onWheel: wheel => {
            const wsList = Hyprland.workspaces.values.filter(ws => ws.monitor && ws.monitor.name === monitorName).sort((a, b) => a.id - b.id).map(ws => ws.id);

            if (!wsList.length)
                return;

            const currentWs = Hyprland.workspaces.values.find(ws => ws.monitor && ws.monitor.name === monitorName && ws.active);
            let idx = currentWs ? wsList.indexOf(currentWs.id) : 0;
            if (idx < 0)
                idx = 0;

            if (wheel.angleDelta.y > 0) {
                idx = (idx + 1) % wsList.length;
            } else if (wheel.angleDelta.y < 0) {
                idx = (idx - 1 + wsList.length) % wsList.length;
            }

            Hyprland.dispatch("workspace " + wsList[idx]);
            wheel.accepted = true;
        }
    }
    Row {
        id: workspaceRow
        spacing: 8

        Repeater {
            model: Hyprland.workspaces.values.filter(ws => ws.monitor && ws.monitor.name === monitorName)

            Rectangle {
                required property var modelData
                width: 15
                height: 24
                radius: 4
                color: modelData.active ? "#4a9eef" : "#333333"
                border.color: "#555555"

                MouseArea {
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch("workspace " + modelData.id)
                }

                Text {
                    text: modelData.id
                    anchors.centerIn: parent
                    color: modelData.active ? "#ffffff" : "#cccccc"
                    font.pixelSize: 15
                    font.family: "Jetbrains Mono NF"
                    font.bold: true
                }
            }
        }

        Text {
            visible: Hyprland.workspaces.values.filter(ws => ws.monitor && ws.monitor.name === monitorName).length === 0
            text: "No workspaces"
            color: "#ffffff"
            font.pixelSize: 15
            font.bold: true
        }
    }
}
