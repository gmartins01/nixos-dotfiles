//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic
//@ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000

// Adjust this to make the shell smaller or larger
//@ pragma Env QT_SCALE_FACTOR=1

import "./modules/common/"
import "./modules/background/"
import "./modules/bar/"
import "./modules/cheatsheet/"
import "./modules/dock/"
//import "./modules/lock/"
import "./modules/mediaControls/"
import "./modules/notificationPopup/"
import "./modules/onScreenDisplay/"
import "./modules/overview/"
import "./modules/screenCorners/"
import "./modules/session/"
import "./modules/sidebarRight/"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import Quickshell
import "./services/"

ShellRoot {
    id: root
    // Enable/disable modules here. False = not loaded at all, so rest assured
    // no unnecessary stuff will take up memory if you decide to only use, say, the overview.
    property bool enableBar: true
    property bool enableBackground: true
    property bool enableCheatsheet: true
    property bool enableDock: true
    property bool enableMediaControls: true
    property bool enableNotificationPopup: true
    property bool enableOnScreenDisplayBrightness: true
    property bool enableOnScreenDisplayVolume: true
    property bool enableOverview: true
    property bool enableReloadPopup: true
    property bool enableScreenCorners: true
    property bool enableSession: true
    property bool enableSidebarRight: true

    // Force initialization of some singletons
    Component.onCompleted: {
        //Cliphist.refresh()
        //FirstRunExperience.load()
        //Hyprsunset.load()
        MaterialThemeLoader.reapplyTheme();
    }

    LazyLoader {
        active: root.enableBar
        component: Bar {}
    }
    LazyLoader {
        active: root.enableBackground
        component: Background {}
    }
    LazyLoader {
        active: enableCheatsheet
        component: Cheatsheet {}
    }
    LazyLoader {
        active: enableDock && Config.options.dock.enable
        component: Dock {}
    }
    //LazyLoader { active: enableLock; component: Lock {} }
    LazyLoader {
        active: enableMediaControls
        component: MediaControls {}
    }
    LazyLoader {
        active: enableNotificationPopup
        component: NotificationPopup {}
    }
    LazyLoader {
        active: enableOnScreenDisplayBrightness
        component: OnScreenDisplayBrightness {}
    }
    LazyLoader {
        active: root.enableOnScreenDisplayVolume
        component: OnScreenDisplayVolume {}
    }
    LazyLoader {
        active: root.enableOverview
        component: Overview {}
    }
    LazyLoader {
        active: root.enableReloadPopup
        component: ReloadPopup {}
    }
    LazyLoader {
        active: root.enableScreenCorners
        component: ScreenCorners {}
    }
    LazyLoader {
        active: root.enableSession
        component: Session {}
    }

    // SidebarRight {
    //     id: sidePanel
    //     objectName: "sidePanel"
    // }
    LazyLoader {
        id: sidebarRightLoader

        active: root.enableSidebarRight
        component: SidebarRight {
            id: sidebarRight
        }
    }
}
