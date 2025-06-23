import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable } from "astal"
import Workspaces from "./modules/workspaces/Worspaces";
import Hyprland from "gi://AstalHyprland"
import { SysTray } from "./modules/SysTray";


export default function Bar(gdkmonitor: Gdk.Monitor) {
    const { BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor;

    return <window
        visible
        className="Bar"
        gdkmonitor={gdkmonitor}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={BOTTOM | LEFT | RIGHT}
        application={App}
    >
        <centerbox
            orientation={Gtk.Orientation.HORIZONTAL}
        >
            <box halign={Gtk.Align.START}>
                <Workspaces gdkmonitor={gdkmonitor} />
                <SysTray />
            </box>

        </centerbox>
    </window>

}
