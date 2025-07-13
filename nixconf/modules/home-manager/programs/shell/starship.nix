{ pkgs, lib, config,... }:

{

    options = {
        starship.enable = lib.mkEnableOption "Enable starship propmt";
    };

    config = lib.mkIf config.starship.enable {
        programs.starship = {
            enable = true;
            settings = {
            # add_newline = false;

            # character = {
            #   success_symbol = "[➜](bold green)";
            #   error_symbol = "[➜](bold red)";
            # };

            # package.disabled = true;
            };
        };
    };

}
