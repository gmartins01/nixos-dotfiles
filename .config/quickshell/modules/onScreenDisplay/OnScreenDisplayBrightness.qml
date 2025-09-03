import qs
import qs.services
import qs.modules.common
import qs.modules.common.widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland


Scope {
    id: root

    function triggerAllOsd() {
        for (var i = 0; i < Brightness.monitors.length; ++i) {
            Brightness.monitors[i].showOsd = true;
        }
        osdTimeoutAll.restart();
    }

    Timer {
        id: osdTimeoutAll
        interval: Config.options.osd.timeout
        repeat: false
        running: false
        onTriggered: {
            for (var i = 0; i < Brightness.monitors.length; ++i) {
                Brightness.monitors[i].showOsd = false;
            }
        }
    }

    Column {
        id: osdColumn
        Repeater {
            model: Brightness.monitors

            Loader {
                id: osdLoader

                active: model.showOsd === true

                sourceComponent: PanelWindow {
                    id: osdRoot

                    screen: model.modelData

                    exclusionMode: ExclusionMode.Normal
                    WlrLayershell.namespace: "quickshell:onScreenDisplay"
                    WlrLayershell.layer: WlrLayer.Overlay
                    color: "transparent"

                    anchors {
                        top: !Config.options.bar.bottom
                        bottom: Config.options.bar.bottom
                    }

                    mask: Region {
                        item: osdValuesWrapper
                    }

                    implicitWidth: columnLayout.implicitWidth
                    implicitHeight: columnLayout.implicitHeight
                    visible: osdLoader.active

                    ColumnLayout {
                        id: columnLayout
                        anchors.horizontalCenter: parent.horizontalCenter

                        Item {
                            id: osdValuesWrapper
                            implicitHeight: osdValues.implicitHeight + Appearance.sizes.elevationMargin * 2
                            implicitWidth: osdValues.implicitWidth
                            clip: true

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: {
                                    model.showOsd = false;
                                }
                            }

                            Behavior on implicitHeight {
                                NumberAnimation {
                                    duration: Appearance.animation.menuDecel.duration
                                    easing.type: Appearance.animation.menuDecel.type
                                }
                            }

                            OsdValueIndicator {
                                id: osdValues
                                anchors.fill: parent
                                anchors.margins: Appearance.sizes.elevationMargin
                                value: model.brightness ? model.brightness : 0.5
                                icon: "light_mode"
                                rotateIcon: true
                                scaleIcon: true
                                name: modelData.name ? modelData.name : "Brightness"
                            }
                        }
                    }
                }

                Timer {
                    id: osdTimeout
                    interval: Config.options.osd.timeout
                    repeat: false
                    running: false
                    onTriggered: {
                        model.showOsd = false;
                    }
                }

                Connections {
                    target: Brightness.monitors[index]
                    function onBrightnessUpdated(newValue) {
                        Brightness.monitors[index].showOsd = true;
                        osdTimeout.restart();
                    }
                }
            }
        }
    }

    IpcHandler {
        target: "osdBrightness"

        function trigger() {
            root.triggerAllOsd();
        }

        function hide() {
            for (var i = 0; i < Brightness.monitors.length; ++i) {
                Brightness.monitors[i].showOsd = false;
            }
        }

        function toggle() {
            if (Brightness.monitors.length > 0)
                Brightness.monitors[0].showOsd = !Brightness.monitors[0].showOsd;
        }
    }
}
