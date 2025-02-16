{
  pkgs,
  inputs,
  ...
}: {
  programs.ags = {
    enable = true;

    configDir = ./.;

    extraPackages = with pkgs; [
      bun
    ];
  };

  home.packages = with pkgs; [
    bun
  ];

}