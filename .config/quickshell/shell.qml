//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma UseQApplication

import "./modules/bar/"

import Quickshell
import QtQuick

ShellRoot {
    property bool enableBar: true
    property bool enableReloadPopup: false

    LazyLoader {
        active: enableBar
        component: Bar {}
    }

    LazyLoader {
        active: enableReloadPopup
        component: ReloadPopup {}
    }
}
