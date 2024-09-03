{ pkgs, lib, ... }:

{
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    vesktop
    keepassxc
    vscode 
  ];
  
  programs.firefox.enable = true;

}