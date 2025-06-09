import { bind, GLib, Variable } from "astal";
import { Astal, Gdk, Gtk } from "astal/gtk4";
import AstalHyprland from "gi://AstalHyprland?version=0.1";

const hypr = AstalHyprland.get_default();

const ws = Variable(hypr.get_workspaces().sort((a, b) => a.id - b.id))
  .observe(hypr, "workspace-added", () =>
    hypr.get_workspaces().sort((a, b) => a.id - b.id),
  )
  .observe(hypr, "workspace-removed", () =>
    hypr.get_workspaces().sort((a, b) => a.id - b.id),
  )
  .observe(hypr, "client-added", () =>
    hypr.get_workspaces().sort((a, b) => a.id - b.id),
  )
  .observe(hypr, "client-removed", () =>
    hypr.get_workspaces().sort((a, b) => a.id - b.id),
  )
  .observe(hypr, "client-moved", () =>
    hypr.get_workspaces().sort((a, b) => a.id - b.id),
  );

function WorkspaceItem(item: AstalHyprland.Workspace) {
  let popover: Gtk.Popover;

  return (
    <button
      hexpand
      cssClasses={["workspaces"]}
      halign={Gtk.Align.START}
      onHoverEnter={() => popover.popup()}
      onHoverLeave={(self) => popover.popdown()}
      onClicked={() => hypr.dispatch("workspace", item.get_id().toString())}
    >
      <box halign={Gtk.Align.CENTER}>
        <label label={item.get_id().toString()} />
        <popover
          hasArrow={false}
          canFocus={false}
          focusable={false}
          autohide={false}
          setup={(self) => {
            popover = self;
            self.set_offset(-20, 0);
          }}
          heightRequest={20}
          position={Gtk.PositionType.BOTTOM}
        >
          <box cssClasses={["popover_item"]} halign={Gtk.Align.END} spacing={5}>
            {item.get_clients().map((client) => {
              if (client.get_class()) {
                return (
                  <image
                    iconName={client.get_class()}
                    pixelSize={20}
                    tooltipText={client.get_title()}
                  />
                );
              } else {
                return <></>;
              }
            })}
          </box>
        </popover>

      </box>
    </button>
  );
}

export default function Workspaces(monitor: number) {
  return (
    <box orientation={0} cssClasses={["worspaces", "bar_item"]} spacing={10}>
      {bind(ws).as((workspaces) =>
        workspaces
        .filter((w: AstalHyprland.Workspace) => w.get_monitor() === monitor)
        .map((workspace: AstalHyprland.Workspace) =>
          WorkspaceItem(workspace),
        ),
      )}
    </box>
  );
}
