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
    ./cli
    ./shell
  ];
}
