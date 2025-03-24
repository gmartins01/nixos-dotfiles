{ config, inputs, pkgs, ... }:

{
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
      #amf
      #amdvlk
    ];
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  programs.gamemode.enable = true;

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
}
