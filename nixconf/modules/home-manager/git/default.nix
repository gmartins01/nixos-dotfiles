{ pkgs, inputs, ... }:

{
  programs.git = {
		enable = true;
		userName = "Gonçalo Martins";
		userEmail = "goncallo.c.martins@gmail.com";
		includes = [
				{ path = "~/.gitconfig.local"; }
		];
  };

}
