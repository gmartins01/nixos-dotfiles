#!/usr/bin/env bash

QUICKSHELL_CONFIG_NAME="ii"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
CONFIG_DIR="$XDG_CONFIG_HOME/quickshell/$QUICKSHELL_CONFIG_NAME"
CACHE_DIR="$XDG_CACHE_HOME/quickshell"
STATE_DIR="$XDG_STATE_HOME/quickshell"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SHELL_CONFIG_FILE="$XDG_CONFIG_HOME/quickshell/settings/config.json"
MATUGEN_DIR="$XDG_CONFIG_HOME/matugen"
terminalscheme="$SCRIPT_DIR/terminal/scheme-base.json"

handle_kde_material_you_colors() {
    # Check if Qt app theming is enabled in config
    if [ -f "$SHELL_CONFIG_FILE" ]; then
        enable_qt_apps=$(jq -r '.appearance.wallpaperTheming.enableQtApps' "$SHELL_CONFIG_FILE")
        if [ "$enable_qt_apps" == "false" ]; then
            return
        fi
    fi

    # Map $type_flag to allowed scheme variants for kde-material-you-colors-wrapper.sh
    local kde_scheme_variant=""
    case "$type_flag" in
        scheme-content|scheme-expressive|scheme-fidelity|scheme-fruit-salad|scheme-monochrome|scheme-neutral|scheme-rainbow|scheme-tonal-spot)
            kde_scheme_variant="$type_flag"
            ;;
        *)
            kde_scheme_variant="scheme-tonal-spot" # default
            ;;
    esac
    "$XDG_CONFIG_HOME"/matugen/templates/kde/kde-material-you-colors-wrapper.sh --scheme-variant "$kde_scheme_variant"
}



set_wallpaper_path() {
    local path="$1"
    if [ -f "$SHELL_CONFIG_FILE" ]; then
        jq --arg path "$path" \
           '.background.wallpaperPath = $path' \
           "$SHELL_CONFIG_FILE" \
        > "$SHELL_CONFIG_FILE.tmp" \
        && mv "$SHELL_CONFIG_FILE.tmp" "$SHELL_CONFIG_FILE"
    fi
}

set_qt_kvantum_theme() {
    local mode="$1"
    local kvconfig="$HOME/.config/Kvantum/kvantum.kvconfig"

    mkdir -p "$(dirname "$kvconfig")"

    if [[ "$mode" == "dark" ]]; then
        echo "[General]
theme=KvLibadwaitaDark" > "$kvconfig"
    else
        echo "[General]
theme=KvLibadwaita" > "$kvconfig"
    fi
}

set_qt_theme() {
    local theme="$1"

    mkdir -p "$XDG_CONFIG_HOME/qt5ct"
    mkdir -p "$XDG_CONFIG_HOME/qt6ct"

    # Use same config for both
    local conf="[Appearance]
style=$theme
icon_theme=Papirus-Dark
standard_dialogs=xdgdesktopportal
custom_palette=false

[Fonts]
general=Sans,10,-1,5,50,0,0,0,0,0
fixed=Monospace,10,-1,5,50,0,0,0,0,0"

    echo "$conf" > "$XDG_CONFIG_HOME/qt5ct/qt5ct.conf"
    echo "$conf" > "$XDG_CONFIG_HOME/qt6ct/qt6ct.conf"
}

function reload_gtk_theme() {
    local current_theme=$(dconf read /org/gnome/desktop/interface/gtk-theme | tr -d \')
    echo $current_theme
    dconf write /org/gnome/desktop/interface/gtk-theme "''"
    sleep 1
    dconf write /org/gnome/desktop/interface/gtk-theme "'$current_theme'"
    #settings set org.gnome.desktop.interface gtk-theme $current_theme
}

pre_process() {
    local mode_flag="$1"
    # Set GNOME color-scheme if mode_flag is dark or light
    if [[ "$mode_flag" == "dark" ]]; then
        dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
    elif [[ "$mode_flag" == "light" ]]; then
        dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'"
    fi

}

post_process() {
    #local screen_width="$1"
    #local screen_height="$2"
    #local wallpaper_path="$3"

    local mode_flag="$1"
    # Set GNOME color-scheme if mode_flag is dark or light
    if [[ "$mode_flag" == "dark" ]]; then
        echo "message"
        dconf write /org/gnome/desktop/interface/gtk-theme "'adw-gtk3-dark'"
    elif [[ "$mode_flag" == "light" ]]; then
        dconf write /org/gnome/desktop/interface/gtk-theme "'adw-gtk3'"
    fi

    #handle_kde_material_you_colors &

    # Determine the largest region on the wallpaper that's sufficiently un-busy to put widgets in
    # if [ ! -f "$MATUGEN_DIR/scripts/least_busy_region.py" ]; then
    #     echo "Error: least_busy_region.py script not found in $MATUGEN_DIR/scripts/"
    # else
    #     "$MATUGEN_DIR/scripts/least_busy_region.py" \
    #         --screen-width "$screen_width" --screen-height "$screen_height" \
    #         --width 300 --height 200 \
    #         "$wallpaper_path" > "$STATE_DIR"/user/generated/wallpaper/least_busy_region.json
    # fi
}

check_and_prompt_upscale() {
    local img="$1"
    min_width_desired="$(hyprctl monitors -j | jq '([.[].width] | max)' | xargs)" # max monitor width
    min_height_desired="$(hyprctl monitors -j | jq '([.[].height] | max)' | xargs)" # max monitor height

    if command -v identify &>/dev/null && [ -f "$img" ]; then
        local img_width img_height
        if is_video "$img"; then # Not check resolution for videos, just let em pass
            img_width=$min_width_desired
            img_height=$min_height_desired
        else
            img_width=$(identify -format "%w" "$img" 2>/dev/null)
            img_height=$(identify -format "%h" "$img" 2>/dev/null)
        fi
        if [[ "$img_width" -lt "$min_width_desired" || "$img_height" -lt "$min_height_desired" ]]; then
            action=$(notify-send "Upscale?" \
                "Image resolution (${img_width}x${img_height}) is lower than screen resolution (${min_width_desired}x${min_height_desired})" \
                -A "open_upscayl=Open Upscayl"\
                -a "Wallpaper switcher")
            if [[ "$action" == "open_upscayl" ]]; then
                if command -v upscayl &>/dev/null; then
                    nohup upscayl > /dev/null 2>&1 &
                else
                    action2=$(notify-send \
                        -a "Wallpaper switcher" \
                        -c "im.error" \
                        -A "install_upscayl=Install Upscayl (Arch)" \
                        "Install Upscayl?" \
                        "yay -S upscayl-bin")
                    if [[ "$action2" == "install_upscayl" ]]; then
                        kitty -1 yay -S upscayl-bin
                        if command -v upscayl &>/dev/null; then
                            nohup upscayl > /dev/null 2>&1 &
                        fi
                    fi
                fi
            fi
        fi
    fi
}

THUMBNAIL_DIR="/tmp/mpvpaper_thumbnails"
CUSTOM_DIR="$XDG_CONFIG_HOME/hypr/custom"
RESTORE_SCRIPT_DIR="$CUSTOM_DIR/scripts"
RESTORE_SCRIPT="$RESTORE_SCRIPT_DIR/__restore_video_wallpaper.sh"
VIDEO_OPTS="no-audio loop hwdec=auto scale=bilinear interpolation=no video-sync=display-resample panscan=1.0 video-scale-x=1.0 video-scale-y=1.0 video-align-x=0.5 video-align-y=0.5 load-scripts=no"







switch() {
    imgpath="$1"
    mode_flag="$2"
    type_flag="$3"
    color_flag="$4"
    color="$5"

    # Determine mode if not set
    if [[ -z "$mode_flag" ]]; then
        current_mode=$(dconf read /org/gnome/desktop/interface/color-scheme | tr -d \')
        if [[ "$current_mode" == "prefer-dark" ]]; then
            mode_flag="dark"
        else
            mode_flag="light"
        fi
    fi

    # Set wallpaper path
    set_wallpaper_path "$imgpath"

    pre_process "$mode_flag"

    matugen image "/home/gmartins/Downloads/teste/wallpaperflare.com_wallpaper.jpg" -m $mode_flag

    echo $mode_flag

    post_process "$mode_flag"
    
    reload_gtk_theme

}

main() {
    imgpath=""
    mode_flag=""
    type_flag=""
    color_flag=""
    color=""
    noswitch_flag=""

  get_type_from_config() {
        jq -r '.appearance.palette.type' "$SHELL_CONFIG_FILE" 2>/dev/null || echo "auto"
    }

    echo $(get_type_from_config)

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --mode)
                mode_flag="$2"
                shift 2
                ;;
            --type)
                type_flag="$2"
                shift 2
                ;;
            --color)
                color_flag="1"
                if [[ "$2" =~ ^#?[A-Fa-f0-9]{6}$ ]]; then
                    color="$2"
                    shift 2
                else
                    color=$(hyprpicker --no-fancy)
                    shift
                fi
                ;;
            --image)
                imgpath="$2"
                shift 2
                ;;
            --noswitch)
                noswitch_flag="1"
                imgpath=$(jq -r '.background.wallpaperPath' "$SHELL_CONFIG_FILE" 2>/dev/null || echo "")
                shift
                ;;
            *)
                if [[ -z "$imgpath" ]]; then
                    imgpath="$1"
                fi
                shift
                ;;
        esac
    done

    # If type_flag is not set, get it from config
    if [[ -z "$type_flag" ]]; then
        type_flag="$(get_type_from_config)"
    fi

    # Validate type_flag (allow 'auto' as well)
    allowed_types=(scheme-content scheme-expressive scheme-fidelity scheme-fruit-salad scheme-monochrome scheme-neutral scheme-rainbow scheme-tonal-spot auto)
    valid_type=0
    for t in "${allowed_types[@]}"; do
        if [[ "$type_flag" == "$t" ]]; then
            valid_type=1
            break
        fi
    done
    if [[ $valid_type -eq 0 ]]; then
        echo "[switchwall.sh] Warning: Invalid type '$type_flag', defaulting to 'auto'" >&2
        type_flag="auto"
    fi

    # Only prompt for wallpaper if not using --color and not using --noswitch and no imgpath set
    if [[ -z "$imgpath" && -z "$color_flag" && -z "$noswitch_flag" ]]; then
        cd "$(xdg-user-dir PICTURES)/Wallpapers/showcase" 2>/dev/null || cd "$(xdg-user-dir PICTURES)/Wallpapers" 2>/dev/null || cd "$(xdg-user-dir PICTURES)" || return 1
        imgpath="$(kdialog --getopenfilename . --title 'Choose wallpaper')"
    fi

    # If type_flag is 'auto', detect scheme type from image (after imgpath is set)
    if [[ "$type_flag" == "auto" ]]; then
        if [[ -n "$imgpath" && -f "$imgpath" ]]; then
            detected_type="$(detect_scheme_type_from_image "$imgpath")"
            # Only use detected_type if it's valid
            valid_detected=0
            for t in "${allowed_types[@]}"; do
                if [[ "$detected_type" == "$t" && "$detected_type" != "auto" ]]; then
                    valid_detected=1
                    break
                fi
            done
            if [[ $valid_detected -eq 1 ]]; then
                type_flag="$detected_type"
            else
                echo "[switchwall] Warning: Could not auto-detect a valid scheme, defaulting to 'scheme-tonal-spot'" >&2
                type_flag="scheme-tonal-spot"
            fi
        else
            echo "[switchwall] Warning: No image to auto-detect scheme from, defaulting to 'scheme-tonal-spot'" >&2
            type_flag="scheme-tonal-spot"
        fi
    fi

    switch "$imgpath" "$mode_flag" "$type_flag" "$color_flag" "$color"
}

main "$@"
