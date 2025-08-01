{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    mangohud # For fps monitoring

    prismlauncher # Minecraft Launcher

    libva-utils # For checking if hardware acceleration is working
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa
      libva
      rocmPackages.clr.icd
      # amf
      # amdvlk
    ];
  };

  services.xserver.videoDrivers = ["amdgpu"];

  programs.gamemode.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    package = pkgs.steam.override {
      extraLibraries = pkgs: [pkgs.xorg.libxcb];
      extraPkgs = pkgs:
        with pkgs; [
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
          gamemode
        ];
    };
    extraCompatPackages = [pkgs.proton-ge-bin];
  };

  programs.gamescope = {
    enable = true;
    package = pkgs.gamescope;
  };
}
