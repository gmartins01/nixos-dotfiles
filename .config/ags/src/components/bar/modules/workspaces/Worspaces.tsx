import { Gtk, Gdk } from "astal/gtk3";
import { bind, Variable } from "astal";
import AstalHyprland from "gi://AstalHyprland";
//import { getAppIcon } from "./icons";

const workspaceRename = Array.from({ length: 30 }, (_, i) => i % 10);

const hyprland = AstalHyprland.get_default();

const ignoredClients = ["xwaylandvideobridge"];

class Workspace {
    readonly id: number;
    readonly name: string;
    readonly translatedId: string;
    readonly widget: Gtk.Widget;
    readonly urgent: ReturnType<typeof Variable<boolean>>;
    readonly active: ReturnType<typeof Variable<boolean>>;
    readonly className: ReturnType<typeof Variable<string>>;
    isDestroyed: boolean = false;
    clients: ReturnType<typeof Variable<AstalHyprland.Client[]>>;
    visible: ReturnType<typeof Variable<boolean>>;

    constructor(args: { id: number; name: string; translatedId: number | undefined }) {
        this.id = args.id;
        this.name = args.name;
        this.translatedId = args.translatedId?.toString() ?? args.name;
        this.urgent = Variable(false);
        this.active = Variable(false);
        this.className = Variable.derive([this.active, this.urgent], (active, urgent) => {
            const result = ["workspace"];
            if (active) {
                result.push("active");
            }
            if (urgent) {
                result.push("urgent");
            }
            return result.join(" ");
        });

        this.clients = Variable(
            hyprland.clients.filter(
                (client) => client?.workspace?.id === args?.id && !ignoredClients.includes(client.class),
            ),
        );
        /*this.visible = Variable.derive(
            [this.active, this.clients],
            (active, clients) => !this.translatedId.startsWith("special:") && (active || !!clients.length),
        );*/


        this.visible = Variable(!this.translatedId.startsWith("special:"));


        this.widget = (
            <button
                visible={bind(this.visible)}
                className={bind(this.className)}
                onClicked={() => {
                    try {
                        hyprland.dispatch("workspace", this.id.toString());
                    } catch (e) {
                        console.error("Error dispatching workspace:", e);
                    }
                }
                }
                onDestroy={() => {
                    this.isDestroyed = true;
                    this.className.drop();
                }}
                child={
                    < box >
                        <label valign={Gtk.Align.CENTER} className="label" label={this.translatedId.toString()} />
                        {/* {bind(this.clients).as((clients) => */}
                        {/*     clients.map((client) => { */}
                        {/*         return <icon className="icon" icon={getAppIcon(client?.class)} />; */}
                        {/*     }), */}
                        {/* )} */}
                    </box >
                }
            ></button >
        );
    }

    setUrgent(value: boolean) {
        this.urgent.set(value);
    }

    setActive(value: boolean) {
        this.active.set(value);
    }

    reload(clients: AstalHyprland.Client[]) {
        this.clients.set(clients.filter((client) => client.workspace.id === this.id));
    }

    remove(addr: string) {
        this.clients.set(this.clients.get().filter((client) => client.address !== addr));
    }
}

function HyprToGdkMonitor(monitor: AstalHyprland.Monitor): Gdk.Monitor | undefined {
    try {
        return Gdk.Display?.get_default()?.get_monitor_at_point(monitor.x + 1, monitor.y + 1);
    } catch (_err) {
        return undefined;
    }
}


function fetchWorkspaces(monitor: Gdk.Monitor): Workspace[] {
    const hyprland = AstalHyprland.get_default();

    const workspaces = hyprland.get_workspaces()
        .filter(ws => HyprToGdkMonitor(ws.monitor) === monitor)
        .sort((a, b) => a.get_id() - b.get_id())
        .map(ws =>
            new Workspace({
                id: ws.get_id(),
                name: ws.get_name(),
                translatedId: workspaceRename[ws.get_id()],
            })
        );

    console.log(workspaces);

    return workspaces;
    // return hyprland.workspaces
    //     .filter((ws) => HyprToGdkMonitor(ws.monitor) === monitor)
    //     .sort((a, b) => a.id - b.id)
    //     .map((ws) => new Workspace({ id: ws.id, translatedId: workspaceRename[ws.id], name: ws.name }));
}

export default function Workspaces(props: { gdkmonitor: Gdk.Monitor }) {
    const hyprland = AstalHyprland.get_default();
    const workspaces = Variable(fetchWorkspaces(props.gdkmonitor));
    workspaces
        .get()
        .find((ws) => ws.id === hyprland.focusedWorkspace.id)
        ?.setActive(true);

    hyprland.connect("workspace-added", (_, _workspace) => {
        workspaces.set(fetchWorkspaces(props.gdkmonitor));
    });

    hyprland.connect("workspace-removed", (_, _id) => {
        workspaces.set(fetchWorkspaces(props.gdkmonitor));
    });

    hyprland.connect("urgent", (_, client) => {
        if (HyprToGdkMonitor(client?.monitor) !== props.gdkmonitor) {
            return;
        }
        const workspace = workspaces.get().find((ws) => ws.id === client.workspace.id);
        workspace?.setUrgent(true);
    });

    hyprland.connect("event", async (_, eventName, data) => {
        if (eventName === "activewindowv2") {
            const address = data;
            const client = hyprland.clients.find((client) => address === client.address);
            const workspace = workspaces.get().find((ws) => ws.id === client?.workspace.id);
            workspace?.setUrgent(false);

            for (const ws of workspaces.get()) {
                ws.setActive(ws.id === workspace?.id);
            }
        }

        if (eventName === "focusedmon" || eventName === "workspacev2") {
            const wsName = data.split(",")[1];
            for (const ws of workspaces.get()) {
                ws.setActive(ws.name === wsName);
            }
        }

        if (eventName === "openwindow") {
            workspaces.set(fetchWorkspaces(props.gdkmonitor));
        }

        if (eventName === "movewindowv2" || eventName === "closewindow") {
            workspaces.set(fetchWorkspaces(props.gdkmonitor));
        }
    });

    return <eventbox valign={Gtk.Align.CENTER} onScroll={(_, event) =>
        event.delta_y > 0 ?
            AstalHyprland.get_default().dispatch("workspace", "e-1")
            : AstalHyprland.get_default().dispatch("workspace", "e+1")}>
        <box
            className="workspaces"
            spacing={10}
        >
            {bind(workspaces).as((workspaces) => workspaces.map((ws) => ws.widget))}
        </box>
    </eventbox>;

}


