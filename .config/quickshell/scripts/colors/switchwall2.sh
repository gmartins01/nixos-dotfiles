#!/usr/bin/env bash

gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
dconf write /org/gnome/desktop/interface/gtk-theme "'adw-gtk3-dark'"

