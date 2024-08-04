#!/usr/bin/env bash
# Installs or reinstalls the given keyboard layout to $XDG_CONFIG_HOME/xkb, which
# works on a per-user basis and does not require sudo/root.  It also works with both
# X11 and Wayland.  No third-party tools required.

#set -x
set -e

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# Get a list of the variants available
VARIANTS=$(find $SCRIPT_DIR/xkb -type f -exec basename '{}' \; | xargs)

XKB_DIR=$XDG_CONFIG_HOME/xkb
RULES_DIR=$XKB_DIR/rules
EVDEV_FILE=$RULES_DIR/evdev.xml
SYMBOLS_DIR=$XKB_DIR/symbols
SYMBOLS_FILE=$SYMBOLS_DIR/custom

install_variants() {
    mkdir -p $RULES_DIR $SYMBOLS_DIR
    cp -f $SYMBOLS_FILE $SYMBOLS_FILE.bak
    rm -f $SYMBOLS_FILE
    for v in $VARIANTS; do
        echo "Installing $v"
        cat $SCRIPT_DIR/xkb/$v >> $SYMBOLS_FILE
    done
    generate_evdev_file
    echo ""
    echo "Success!"
    echo "You may need to logout or reboot before the layout variants are available."
    echo ""
}

uninstall_variants() {
    rm -f $SYMBOLS_FILE $EVDEV_FILE
    echo "Custom layouts removed.  Logout and log back in to take effect."
}

# Generates the evdev.xml file from the list of xkb files
# This makes it easy to just drop new layouts in the xkb folder
# and the install script will pick them up
generate_evdev_file() {
    cat <<EOF > $EVDEV_FILE
<?xml version="1.0"?>
<!DOCTYPE xkbConfigRegistry SYSTEM "xkb.dtd">
<xkbConfigRegistry version="1.1">
  <layoutList>
    <layout>
      <configItem>
        <name>custom</name>
      </configItem>
      <variantList>
EOF
    for variant in $VARIANTS; do
        cat <<EOF >> $EVDEV_FILE
        <variant>
          <configItem>
            <name>$variant</name>
            <description>${variant^}</description>
          </configItem>
        </variant>
EOF
    done
    cat <<EOF >> $EVDEV_FILE
      </variantList>
    </layout>
  </layoutList>
</xkbConfigRegistry>
EOF
}

install_variants
