{ config, inputs, pkgs, ... }:

{
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    mangohud # For fps monitoring

    prismlauncher # Minecraft Launcher
  ];


  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  programs.gamemode.enable = true;

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
}
