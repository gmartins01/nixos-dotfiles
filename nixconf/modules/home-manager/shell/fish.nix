{ pkgs, lib, config,... }:

{

    options = {
        fish.enable = lib.mkEnableOption "Enable fish shell";
    };

    config = lib.mkIf config.fish.enable {
        programs.fish = {
            enable = true;
            interactiveShellInit = ''
                set fish_greeting # Disable greeting
            '';
            plugins = [ ];
            shellAliases = {
                config = "git --git-dir=/home/gmartins/.cfg/ --work-tree=/home/gmartins";
                la = "eza -al --color=always --group-directories-first"; # ls -la
                ls = "eza -a --color=always --group-directories-first";  # all files and dirs
                ll = "eza -l --color=always --group-directories-first";  # long format
                lt = "eza -aT --color=always --group-directories-first"; # tree listing
                "l." = "eza -a | egrep '^\.'"; # dot files

                rebuild="sudo nixos-rebuild switch --flake ~/nixconf#";
            };
        };
    };

}
