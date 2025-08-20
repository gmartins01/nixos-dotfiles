import qs.modules.common
import qs.modules.common.widgets
import qs.services
import qs
import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell

Item {
    id: root
    ColumnLayout {
        anchors.fill: parent
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            ListView {
                id: listView
                model: Brightness.monitors
                clip: true
                anchors {
                    fill: parent
                    topMargin: 10
                    bottomMargin: 10
                }
                spacing: 6

                delegate: Item {
                    implicitHeight: rowLayout.implicitHeight

                    anchors {
                        left: parent.left
                        right: parent.right
                        leftMargin: 10
                        rightMargin: 10
                    }
                    RowLayout {
                        id: rowLayout
                        anchors.fill: parent
                        spacing: 6

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: -4

                            RowLayout {
                                Layout.fillWidth: true

                                StyledText {
                                    font.pixelSize: Appearance.font.pixelSize.small
                                    color: Appearance.colors.colSubtext
                                    elide: Text.ElideRight
                                    text: `${modelData.name} [${modelData.model}]`
                                }

                                Item {
                                    Layout.fillWidth: true
                                }

                                StyledText {
                                    font.pixelSize: Appearance.font.pixelSize.small
                                    color: Appearance.colors.colSubtext
                                    elide: Text.ElideRight
                                    text: `${Math.round(model.brightness * 100)}%`
                                }
                            }

                            StyledSlider {
                                Layout.fillWidth: true
                                value: model.brightness
                                onPressedChanged: {
                                    if (!pressed) {
                                        var monitor = Brightness.getMonitorForScreen(model.modelData);
                                        monitor.setBrightness(value);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
//g     Repeater {
//         model: Brightness.monitors
//
//         Item {
//             implicitHeight: rowLayout.implicitHeight
//
//             anchors {
//                 left: parent.left
//                 right: parent.right
//                 leftMargin: 10
//                 rightMargin: 10
//             }
//             RowLayout {
//                 id: rowLayout
//                 anchors.fill: parent
//                 spacing: 6
//                 StyledText {
//                     Layout.fillWidth: true
//                     font.pixelSize: Appearance.font.pixelSize.small
//                     color: Appearance.colors.colSubtext
//                     elide: Text.ElideRight
//                     text: `${modelData.name} [${modelData.model}] ${Math.round(model.brightness * 100)}%`
//                 }
//
//                 StyledSlider {
//                     Layout.fillWidth: true
//                     value: model.brightness
//                     onPressedChanged: {
//                         if (!pressed) {
//                             var monitor = Brightness.getMonitorForScreen(model.modelData);
//                             monitor.setBrightness(value);
//                         }
//                     }
//                 }
//             }
//         }
//     }
// }
