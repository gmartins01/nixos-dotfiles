{ pkgs, lib, inputs,config, ... }:

{

  programs.hyprlock = {
    enable = false;
    package = inputs.hyprlock.packages.${pkgs.system}.hyprlock;
   
  };
  
}
