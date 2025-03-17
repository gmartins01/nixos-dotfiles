{ lib, pkgs, inputs, ... }:

{
  options = {
    enable = lib.mkEnableOption "Hypr Dynamic Cursors plugin";
    
    package = lib.mkOption {
      type = lib.types.package;
      default = inputs.hypr-dynamic-cursors.packages.${pkgs.system}.hypr-dynamic-cursors;
      description = "Package for the Hypr Dynamic Cursors plugin";
    };

    settings = lib.mkOption {
      type = lib.types.attrs;
      default = {
        "plugin:dynamic-cursors" = {

          mode = "none";

          shake = {

          # enables shake to find
          enabled = true;

          # use nearest-neighbour (pixelated) scaling when shaking
          # may look weird when effects are enabled
          nearest = true;

          # controls how soon a shake is detected
          # lower values mean sooner
          threshold = 6.0;

          # magnification level immediately after shake start
          base = 4.0;
          # magnification increase per second when continuing to shake
          speed = 4.0;
          # how much the speed is influenced by the current shake intensitiy
          influence = 0.0;

          # maximal magnification the cursor can reach
          # values below 1 disable the limit (e.g. 0)
          limit = 0.0;

          timeout = 2000;

          effects = false;

          ipc = true;
          };
        };
      };
      description = "Configuration settings for the plugin";
    };
  };
}