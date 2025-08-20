import QtQuick
import qs
import qs.services
import qs.modules.common
import qs.modules.common.widgets

ContentPage {
    forceWidth: true
    ContentSection {
        title: "Monitors Brightness Control"

        Repeater {
            model: Brightness.monitors

            ContentSubsection {
                title: `${modelData.name} [${modelData.model}] ${Math.round(model.brightness * 100)}%`
                tooltip: model.method

                StyledSlider {
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
