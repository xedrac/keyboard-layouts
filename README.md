# Alternate Keyboard Layout Installer for Linux
Simple script to install a collection of alternative keyboard layouts on Linux, without the need for sudo/root.

Keyboard layouts on Linux are a bit of a pain to work with, so I created this repo to make it dead simple to install a large collection of alternative keyboard layouts, and switch between them quickly.
This script works with Wayland, and is untested on X11.  It does not require any third party software.

### Install Layouts
This will install the layouts to `$XDG_CONFIG_HOME/xkb`, which means they will only be available to the current user, and root access is not needed.
```
git clone https://github.com/xedrac/keyboard-layouts.git
cd keyboard-layouts/linux
./local-install.sh
```

Log out and log back in


### Active a Layout

One way to change the layout quickly is to use the `activate.sh` script.
```
$> ./activate.sh
Please specify which layout to activate:

    graphite
    enigmak
    engram
    dvorak
    colemak
    colemak_dh
    workman
    qwerty
```

Once you know which layout you want, go ahead and activate it like so:
```
$> ./activate.sh graphite

custom+graphite layout is now the active layout
```

Alternatively, you can add it from your window manager's GUI, but you may have to dig a little to find it.

#### Gnome
Open the settings dialog and go to `Keyboard -> Add Input Source -> (vertical dots at the bottom) -> Other`.  The custom layouts can be found in this list.

### Adding new Layouts
Just drop new a new xkb file into the `linux/xkb` directory and rename it to the name of your layout.  Then re-run the install script.
