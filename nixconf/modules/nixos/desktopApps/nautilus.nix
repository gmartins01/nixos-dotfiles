{
  pkgs,
  lib,
  ...
}: let
  nautEnv = pkgs.buildEnv {
    name = "nautilus-env";

    paths = with pkgs; [
      nautilus
      nautilus-python
      nautilus-open-any-terminal
    ];
  };
in {
  environment = {
    systemPackages = [nautEnv];
    pathsToLink = [
      "/share/nautilus-python/extensions"
    ];
    sessionVariables = {
      FILE_MANAGER = "nautilus";
      NAUTILUS_4_EXTENSION_DIR = lib.mkDefault "${nautEnv}/lib/nautilus/extensions-4";
    };
  };

  # Fix Nautilus -> Your GStreamer installation is missing a plug-in.
  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" (with pkgs.gst_all_1; [
    gst-plugins-good
    gst-plugins-bad
    gst-plugins-ugly
    gst-libav
  ]);

  #services.dbus.packages = [ pkgs.gnome-settings-daemon ]; # Show Images and files properties on Nautilus (right click -> properties)
}