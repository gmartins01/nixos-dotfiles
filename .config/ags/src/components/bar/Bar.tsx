import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable } from "astal"
import Workspaces from "./modules/workspaces/Worspaces";
import Hyprland from "gi://AstalHyprland"


export default function Bar(gdkmonitor: Gdk.Monitor, monitorIndex: number) {
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
            <Workspaces gdkmonitor={gdkmonitor} />
            teste
        </centerbox>
    </window>

}
