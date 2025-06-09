import { App, Astal, Gtk, Gdk } from "astal/gtk4"
import { Variable } from "astal"
import WorkspacesPanelButton from "./WorkspacesPanelButton";
import Workspaces from "./modules/workspaces/worspaces";
import Hyprland from "gi://AstalHyprland"

const panelButton = {
  workspace: () => <WorkspacesPanelButton />,
};



export default function Bar(gdkmonitor: Gdk.Monitor, monitorIndex: number) {
     const { BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor;

    return <window
            visible
            cssClasses={["Bar"]}
            gdkmonitor={gdkmonitor}
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            anchor={BOTTOM | LEFT | RIGHT}
            application={App}
        >
            <box
                orientation={Gtk.Orientation.HORIZONTAL}
            >
            <Workspaces monitor={monitorIndex}/>
            </box>
        </window>
    
}
