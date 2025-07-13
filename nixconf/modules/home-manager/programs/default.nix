{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.config = {
    allowUnfree = true;
  };

  imports = [
    ./desktop
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      global = {
        hide_env_diff = true;
      };
    };
  };
}
