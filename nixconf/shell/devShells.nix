{ pkgs ? import <nixpkgs> { } }:

{
  default = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
      nodejs
      git
      vim
    ];
  };

}
