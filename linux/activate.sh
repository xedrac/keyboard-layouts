#!/usr/bin/env bash
#set -x
#set -e

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

LAYOUT=custom
VARIANT=$1  # user-specified variant to activate

# Get an array of the variants available
VARIANTS=$(find $SCRIPT_DIR/xkb -type f ! -name "evdev.xml" -exec basename '{}' \; | xargs)
BUILTINS=" dvorak colemak colemak_dh workman qwerty"
VARIANTS+="$BUILTINS "

show_usage_and_exit() {
    echo "Please specify which layout to activate:"
    echo ""
    for v in $VARIANTS; do
        echo "    $v"
    done
    echo ""
    exit 1
}

if test -z $VARIANT; then
    show_usage_and_exit
fi

FOUND=$(echo "$VARIANTS" | grep "$VARIANT ")
if test -z "$FOUND"; then
    echo "ERROR: The variant \"$VARIANT\" is not available."
    show_usage_and_exit
fi

# builtin layouts/variants need to be handled a little differently
IS_BUILTIN=$(echo "$BUILTINS" | grep "$VARIANT ")
if test ! -z "$IS_BUILTIN"; then
    LAYOUT="us"
    # qwerty isn't considered a variant
    if [[ "$VARIANT" == "qwerty" ]]; then
        VARIANT=""
    fi
fi

if [ "$XDG_CURRENT_DESKTOP" == "GNOME" ]; then
    if test -z $VARIANT; then
        gsettings set org.gnome.desktop.input-sources sources "[('xkb', '${LAYOUT}')]"
    else
        gsettings set org.gnome.desktop.input-sources sources "[('xkb', '${LAYOUT}+${VARIANT}')]"
    fi

    #gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"

elif [ "$XDG_CURRENT_DESKTOP" == "KDE" ]; then
    kwriteconfig6 --file kxkbrc --group Layout --key LayoutList $LAYOUT
    kwriteconfig6 --file kxkbrc --group Layout --key VariantList $VARIANT
    #kwriteconfig6 --file kxkbrc --group Layout --key Options caps:backspace # Uncomment for CAPS to be BKSP
    #kwriteconfig6 --file kxkbrc --group Layout --key Options ctrl:nocaps    # Uncomment for CAPS to be CTRL
    dbus-send --session --type=signal --reply-timeout=100 --dest=org.kde.keyboard /Layouts org.kde.keyboard.reloadConfig

else
    if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
        echo "You're running Wayland with a compositor other than Gnome or KDE"
        echo "I don't know how to enable the layout for your compositor."
        echo "You will need to manually enable it in your window manager."
        exit 1
    else
        if test -z $VARIANT; then
            setxkbmap $LAYOUT
            #setxkbmap $LAYOUT -option ctrl:nocaps
        else
            setxkbmap $LAYOUT -variant $VARIANT
            #setxkbmap $LAYOUT -variant $VARIANT -option ctrl:nocaps
        fi
    fi
fi

echo ""
if test -z $VARIANT; then
    echo "$LAYOUT layout should now be active"
else
    echo "$LAYOUT+$VARIANT layout should now be active"
fi
echo ""
