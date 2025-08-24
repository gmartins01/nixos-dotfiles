import qs.modules.common
import qs.modules.common.widgets
import qs.services
import qs
import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire

Item {
    id: root
    property bool showDeviceSelector: false
    property bool deviceSelectorInput
    property int dialogMargins: 16
    property PwNode selectedDevice
    readonly property list<PwNode> appPwNodes: Pipewire.nodes.values.filter(node => {
        // return node.type == "21" // Alternative, not as clean
        return node.isSink && node.isStream;
    })

    function showDeviceSelectorDialog(input: bool) {
        root.selectedDevice = null;
        root.showDeviceSelector = true;
        root.deviceSelectorInput = input;
    }

    Keys.onPressed: event => {
        // Close dialog on pressing Esc if open
        if (event.key === Qt.Key_Escape && root.showDeviceSelector) {
            root.showDeviceSelector = false;
            event.accepted = true;
        }
    }

    ColumnLayout {
        anchors.fill: parent

        ColumnLayout {
            id: deviceHeaderColumn

            Layout.fillWidth: true
            spacing: 12
            Layout.topMargin: 10
            Layout.leftMargin: 8
            Layout.rightMargin: 8

            // --- Master sink row ---
            RowLayout {
                Layout.fillWidth: true
                spacing: 10
                Layout.alignment: Qt.AlignVCenter

                MaterialSymbol {
                    id: volumeIcon
                    //Layout.rightMargin: indicatorsRowLayout.realSpacing
                    text: {
                        if (Audio.sink?.audio.muted) {
                            return "volume_off";
                        } else if (Audio.sink?.audio.volume === 0) {
                            return "volume_mute";
                        } else if (Audio.sink?.audio.volume <= 0.30) {
                            return "volume_down";
                        } else {
                            return "volume_up";
                        }
                    }
                    iconSize: masterSinkSlider.height * 0.9
                    color: Appearance.m3colors.m3onSecondaryContainer

                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton
                        hoverEnabled: true
                        onClicked: event => {
                            if (event.button === Qt.LeftButton) {
                                Audio.sink.audio.muted = !Audio.sink.audio.muted;
                            }
                        }
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: -4

                    RowLayout {
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignVCenter

                        StyledText {
                            font.pixelSize: Appearance.font.pixelSize.small
                            color: Appearance.colors.colSubtext
                            elide: Text.ElideRight
                            text: Audio.sink?.nickname
                        }

                        Item {
                            Layout.fillWidth: true
                        }

                        StyledText {
                            font.pixelSize: Appearance.font.pixelSize.small
                            color: Appearance.colors.colSubtext
                            elide: Text.ElideRight
                            text: `${Math.round(Audio.sink.audio.volume * 100)}%`
                        }
                    }

                    StyledSlider {
                        id: masterSinkSlider
                        Layout.fillWidth: true
                        value: Audio.sink.audio.volume
                        onPressedChanged: {
                            if (!pressed) {
                                Audio.sink.audio.volume = value;
                            }
                        }
                    }
                }
            }

            // --- Master source row ---
            RowLayout {
                Layout.fillWidth: true
                spacing: 10
                Layout.alignment: Qt.AlignVCenter

                MaterialSymbol {
                    id: micIcon
                    text: {
                        if (Audio.source?.audio.muted) {
                            return "mic_off";
                        } else {
                            return "mic";
                        }
                    }
                    iconSize: masterSinkSlider.height * 0.9
                    color: Appearance.m3colors.m3onSecondaryContainer

                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton
                        hoverEnabled: true
                        onClicked: event => {
                            if (event.button === Qt.LeftButton) {
                                Audio.source.audio.muted = !Audio.source.audio.muted;
                            }
                        }
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: -4

                    RowLayout {
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignVCenter

                        StyledText {
                            font.pixelSize: Appearance.font.pixelSize.small
                            color: Appearance.colors.colSubtext
                            elide: Text.ElideRight
                            text: Audio.source?.nickname
                        }

                        Item {
                            Layout.fillWidth: true
                        }

                        StyledText {
                            font.pixelSize: Appearance.font.pixelSize.small
                            color: Appearance.colors.colSubtext
                            elide: Text.ElideRight
                            text: `${Math.round(Audio.source.audio.volume * 100)}%`
                        }
                    }

                    StyledSlider {
                        id: masterSourcelider
                        Layout.fillWidth: true
                        value: Audio.source.audio.volume
                        onPressedChanged: {
                            if (!pressed) {
                                Audio.source.audio.volume = value;
                            }
                        }
                    }
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            implicitHeight: 1
            color: Appearance.m3colors.m3outlineVariant
            Layout.leftMargin: 8
            Layout.rightMargin: 8
            Layout.topMargin: 6
            Layout.bottomMargin: 6
        }

        // Apps list
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            StyledListView {
                id: listView
                model: root.appPwNodes
                anchors {
                    fill: parent
                    topMargin: 10
                    bottomMargin: 10
                }
                clip: true
                spacing: 6
                visible: root.appPwNodes.length > 0

                delegate: VolumeMixerEntry {
                    // Layout.fillWidth: true
                    anchors {
                        left: parent.left
                        right: parent.right
                        leftMargin: 10
                        rightMargin: 10
                    }
                    required property var modelData
                    node: modelData
                }
            }

            // Placeholder when list is empty
            Item {
                anchors.fill: listView

                visible: opacity > 0
                opacity: (root.appPwNodes.length === 0) ? 1 : 0

                Behavior on opacity {
                    NumberAnimation {
                        duration: Appearance.animation.menuDecel.duration
                        easing.type: Appearance.animation.menuDecel.type
                    }
                }

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 5

                    MaterialSymbol {
                        Layout.alignment: Qt.AlignHCenter
                        iconSize: 55
                        color: Appearance.m3colors.m3outline
                        text: "brand_awareness"
                    }
                    StyledText {
                        Layout.alignment: Qt.AlignHCenter
                        font.pixelSize: Appearance.font.pixelSize.normal
                        color: Appearance.m3colors.m3outline
                        horizontalAlignment: Text.AlignHCenter
                        text: "No audio source"
                    }
                }
            }
        }

        // Device selector
        RowLayout {
            id: deviceSelectorRowLayout
            Layout.fillWidth: true
            Layout.fillHeight: false
            uniformCellSizes: true

            AudioDeviceSelectorButton {
                Layout.fillWidth: true
                input: false
                onClicked: root.showDeviceSelectorDialog(input)
            }
            AudioDeviceSelectorButton {
                Layout.fillWidth: true
                input: true
                onClicked: root.showDeviceSelectorDialog(input)
            }
        }
    }

    // Device selector dialog
    Item {
        anchors.fill: parent
        z: 9999

        visible: opacity > 0
        opacity: root.showDeviceSelector ? 1 : 0
        Behavior on opacity {
            NumberAnimation {
                duration: Appearance.animation.elementMoveFast.duration
                easing.type: Appearance.animation.elementMoveFast.type
                easing.bezierCurve: Appearance.animation.elementMoveFast.bezierCurve
            }
        }

        Rectangle { // Scrim
            id: scrimOverlay
            anchors.fill: parent
            radius: Appearance.rounding.small
            color: Appearance.colors.colScrim
            MouseArea {
                hoverEnabled: true
                anchors.fill: parent
                preventStealing: true
                propagateComposedEvents: false
            }
        }

        Rectangle { // The dialog
            id: dialog
            color: Appearance.colors.colSurfaceContainerHigh
            radius: Appearance.rounding.normal
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 30
            implicitHeight: dialogColumnLayout.implicitHeight

            ColumnLayout {
                id: dialogColumnLayout
                anchors.fill: parent
                spacing: 16

                StyledText {
                    id: dialogTitle
                    Layout.topMargin: dialogMargins
                    Layout.leftMargin: dialogMargins
                    Layout.rightMargin: dialogMargins
                    Layout.alignment: Qt.AlignLeft
                    color: Appearance.m3colors.m3onSurface
                    font.pixelSize: Appearance.font.pixelSize.larger
                    text: root.deviceSelectorInput ? Translation.tr("Select input device") : Translation.tr("Select output device")
                }

                Rectangle {
                    color: Appearance.m3colors.m3outline
                    implicitHeight: 1
                    Layout.fillWidth: true
                    Layout.leftMargin: dialogMargins
                    Layout.rightMargin: dialogMargins
                }

                StyledFlickable {
                    id: dialogFlickable
                    Layout.fillWidth: true
                    clip: true
                    implicitHeight: Math.min(scrimOverlay.height - dialogMargins * 8 - dialogTitle.height - dialogButtonsRowLayout.height, devicesColumnLayout.implicitHeight)

                    contentHeight: devicesColumnLayout.implicitHeight

                    ColumnLayout {
                        id: devicesColumnLayout
                        anchors.fill: parent
                        Layout.fillWidth: true
                        spacing: 0

                        Repeater {
                            model: ScriptModel {
                                values: Pipewire.nodes.values.filter(node => {
                                    return !node.isStream && node.isSink !== root.deviceSelectorInput && node.audio;
                                })
                            }

                            // This could and should be refractored, but all data becomes null when passed wtf
                            delegate: StyledRadioButton {
                                id: radioButton
                                required property var modelData
                                Layout.leftMargin: root.dialogMargins
                                Layout.rightMargin: root.dialogMargins
                                Layout.fillWidth: true

                                description: modelData.description
                                checked: modelData.id === Pipewire.defaultAudioSink?.id || modelData.id === Pipewire.defaultAudioSource?.id

                                Connections {
                                    target: root
                                    function onShowDeviceSelectorChanged() {
                                        if (!root.showDeviceSelector)
                                            return;
                                        radioButton.checked = (modelData.id === Pipewire.defaultAudioSink?.id || modelData.id === Pipewire.defaultAudioSource?.id);
                                    }
                                }

                                onCheckedChanged: {
                                    if (checked) {
                                        root.selectedDevice = modelData;
                                    }
                                }
                            }
                        }
                        Item {
                            implicitHeight: dialogMargins
                        }
                    }
                }

                Rectangle {
                    color: Appearance.m3colors.m3outline
                    implicitHeight: 1
                    Layout.fillWidth: true
                    Layout.leftMargin: dialogMargins
                    Layout.rightMargin: dialogMargins
                }

                RowLayout {
                    id: dialogButtonsRowLayout
                    Layout.bottomMargin: dialogMargins
                    Layout.leftMargin: dialogMargins
                    Layout.rightMargin: dialogMargins
                    Layout.alignment: Qt.AlignRight

                    DialogButton {
                        buttonText: "Cancel"
                        onClicked: {
                            root.showDeviceSelector = false;
                        }
                    }
                    DialogButton {
                        buttonText: "OK"
                        onClicked: {
                            root.showDeviceSelector = false;
                            if (root.selectedDevice) {
                                if (root.deviceSelectorInput) {
                                    Pipewire.preferredDefaultAudioSource = root.selectedDevice;
                                } else {
                                    Pipewire.preferredDefaultAudioSink = root.selectedDevice;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
