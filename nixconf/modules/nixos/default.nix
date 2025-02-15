{ config, inputs, pkgs, ... }:

{
  imports = [
    ./system
    ./services
    ./windowManager
    ./styles
    ./pkgs
    ./features/gaming
  ];

}
