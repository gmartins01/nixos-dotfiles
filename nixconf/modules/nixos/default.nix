{ config, inputs, pkgs, ... }:

{
  imports = [
    ./system
    ./services
    ./windowManager
    ./pkgs
    ./features/gaming
  ];

}
