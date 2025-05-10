{ pkgs, lib, ... }:

{
  
  services.syncthing = {
    enable = false;
    user = "gmartins";
    dataDir = "/home/gmartins/Documents";    
    configDir = "/home/gmartins/.config/syncthing"; 
  };


}
