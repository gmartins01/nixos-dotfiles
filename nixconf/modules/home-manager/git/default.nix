{
  pkgs,
  inputs,
  ...
}: {
  programs.git = {
    enable = true;
    signing.format = null;
    settings.user = {
      name = "Gonçalo Martins";
      email = "goncallo.c.martins@gmail.com";
    };
    includes = [
      {path = "~/.gitconfig.local";}
    ];
  };
}
