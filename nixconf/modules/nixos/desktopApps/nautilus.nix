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

  # Open alacrity terminal in nautilus
  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "alacritty";
  };
}