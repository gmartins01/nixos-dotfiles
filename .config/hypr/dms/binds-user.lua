-- DMS user keybind overrides (edit via Control Center or dms; do not remove this header)

hl.unbind("SUPER + R")
hl.bind("SUPER + R", hl.dsp.exec_cmd("dms ipc call spotlight toggle"), { description = "Default Launcher: Toggle" })
hl.unbind("SUPER + V")
hl.bind("SUPER + V", hl.dsp.exec_cmd("dms ipc call clipboard toggle"), { description = "Clipboard: Open" })
hl.unbind("SUPER + SHIFT + R")
hl.bind("SUPER + SHIFT + R", hl.dsp.force_renderer_reload(), { description = "Force Renderer Reload" })
