import QtQuick
import qs
import qs.services
import qs.modules.common
import qs.modules.common.widgets

ContentPage {
    forceWidth: true

    ContentSection {
        title: "Color generation"

        ConfigRow {
            uniform: true
            ConfigSwitch {
                text: "Shell & utilities"
                checked: Config.options.appearance.wallpaperTheming.enableAppsAndShell
                onCheckedChanged: {
                    Config.options.appearance.wallpaperTheming.enableAppsAndShell = checked;
                }
            }
            ConfigSwitch {
                text: "Qt apps"
                checked: Config.options.appearance.wallpaperTheming.enableQtApps
                onCheckedChanged: {
                    Config.options.appearance.wallpaperTheming.enableQtApps = checked;
                }
                StyledToolTip {
                    content: "Shell & utilities theming must also be enabled"
                }
            }
            ConfigSwitch {
                text: "Terminal"
                checked: Config.options.appearance.wallpaperTheming.enableTerminal
                onCheckedChanged: {
                    Config.options.appearance.wallpaperTheming.enableTerminal = checked;
                }
                StyledToolTip {
                    content: "Shell & utilities theming must also be enabled"
                }
            }

        }
    }
}
