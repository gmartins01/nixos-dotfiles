{ pkgs, lib, ... }:

{
  
  services.syncthing = {
    enable = true;
    user = "gmartins";
    dataDir = "/home/gmartins/Documents";    
    configDir = "/home/gmartins/.config/syncthing"; 
  };


}