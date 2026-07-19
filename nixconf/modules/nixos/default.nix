{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./system
    ./services
    ./windowManager
    ./pkgs
    ./features/gaming
  ];

  fonts.fontDir.enable = true;
}
