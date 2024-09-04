{ pkgs, lib, ... }:

{
  hardware = {
    bluetooth = {
        enable = true;
        powerOnBoot = false;
        settings.General.Experimental = true;
    };
};
  

}