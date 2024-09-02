{ pkgs ? import <nixpkgs> { } }:

{
  # Default development environment
  default = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
      nodejs
      git
      vim
    ];
    COLOR = "blue";
  };

  # Python development environment
  python = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
      python3
      pip
      poetry
    ];
    PYTHON_ENV = "development";
  };

  # Web development environment
  webdev = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
      nodejs
      yarn
      webpack
    ];
    WEBDEV_MODE = "debug";
  };

  # C/C++ development environment
  cpp = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
      gcc
      gdb
      cmake
      make
    ];
    CXXFLAGS = "-O2 -g";
  };
}
