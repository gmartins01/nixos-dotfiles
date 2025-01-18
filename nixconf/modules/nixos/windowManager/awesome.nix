{ config, pkgs, ... }:
let
  awesome-git = pkgs.awesome.overrideAttrs (oa: {
    version = "git-a35fced";
    src = pkgs.fetchFromGitHub {
      owner = "awesomeWM";
      repo = "awesome";
      rev = "a35fceda14c39b4a2b1c52947288b378f410f32a";
      hash = "sha256-IH/20D+qrgk5l6Zmu9egif7aVTUhMtLTVSgKY2i47BU=";
    };

    patches = [ ];

    postPatch = ''
      patchShebangs tests/examples/_postprocess.lua
    '';
  });
in
{

  environment.systemPackages = with pkgs; [
    alacritty
    dmenu
    sxiv
    xsel
    xwallpaper
    lua
    cmake
    picom
    clipster
    clipmenu
    numlockx
    xorg.xinput
    xorg.xset
    polkit
    polkit_gnome
    playerctl
    rofi
    imagemagick
    inotify-tools
    colord
    pamixer
    xclip
    maim
    jq
  ];

  services.xserver.windowManager.awesome = {
    enable = true;
    package = awesome-git;
  };
  services.dbus.enable = true;
  security.polkit.enable = true;

}
