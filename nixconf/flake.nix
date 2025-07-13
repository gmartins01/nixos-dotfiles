{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprwm
    hyprland.url = "github:hyprwm/hyprland";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # hyprlock = {
    #   url = "github:hyprwm/hyprlock";
    #   inputs = {
    #     hyprlang.follows = "hyprland/hyprlang";
    #     hyprutils.follows = "hyprland/hyprutils";
    #     nixpkgs.follows = "hyprland/nixpkgs";
    #     systems.follows = "hyprland/systems";
    #   };
    # };

    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    stylix.url = "github:danth/stylix";

    ags.url = "github:Aylur/ags";

    clipboard-sync.url = "github:dnut/clipboard-sync";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    hypr-dynamic-cursors = {
      url = "github:VirtCode/hypr-dynamic-cursors";
      inputs.hyprland.follows = "hyprland"; # to make sure that the plugin is built for the correct version of hyprland
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    nix-flatpak,
    chaotic,
    nixos-wsl,
    hyprland,
    ...
  } @ inputs: let
    inherit (self) outputs;

    username = "gmartins";
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    devShells = import ./shell/devShells.nix {pkgs = pkgs;};
  in {
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    overlays = import ./overlays {inherit inputs outputs;};

    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/laptop/configuration.nix
          inputs.home-manager.nixosModules.default
          ./modules/nixos
        ];
      };

      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
        };
        modules = [
          ./hosts/desktop/configuration.nix
          ./modules/nixos
          inputs.clipboard-sync.nixosModules.default
          nix-flatpak.nixosModules.nix-flatpak
          chaotic.nixosModules.default
        ];
      };

      wsl = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        system = "x86_64-linux";
        modules = [
          nixos-wsl.nixosModules.default
          ./hosts/wsl/configuration.nix
        ];
      };
    };

    homeConfigurations."${username}@desktop" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {inherit inputs outputs;};
      modules = [
        ./hosts/desktop/home.nix
        inputs.ags.homeManagerModules.default
        hyprland.homeManagerModules.default
        inputs.stylix.homeModules.stylix
      ];
    };

    homeConfigurations."${username}@wsl" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {inherit inputs outputs;};
      modules = [
        ./hosts/wsl/home.nix
      ];
    };

    devShells.${system} = devShells;
  };
}
