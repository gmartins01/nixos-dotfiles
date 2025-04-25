#!/usr/bin/env bash

hyprctl dispatch dpms on && ddcutil -l 'G27QC' setvcp 10 55 && ddcutil -l 'LG ULTRAGEAR' setvcp 10 50

hyprpanel -q; hyprpanel &
