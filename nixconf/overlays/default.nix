{inputs, ...}: {
  additions = final: _prev: import ../pkgs final.pkgs;

  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };

  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  unstable-small-packages = final: _prev: {
    unsmall = import inputs.nixpkgs-unsmall {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
