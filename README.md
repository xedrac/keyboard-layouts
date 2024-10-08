# Custom Keyboard Layout Collection for Linux
Simple script to install a collection of alternative keyboard layouts on Linux

### Requirements
Wayland

### Install
```
git clone https://github.com/xedrac/keyboard-layouts.git
cd keyboard-layouts/linux
./local-install.sh
```
<b>*** NOTICE *** </b>
You *must* logout before the layouts can be activated


### Activate
```
$> ./activate.sh
Please specify which layout to activate:

    aptv3
    canary
    canary_noangle
    colemak
    colemak_dh
    dvorak
    engram
    engrammer
    enigmak
    gallium
    gallium_angle
    gallium_punc
    graphite
    meteorite
    meteorite_punc
    mtgap
    pinev4
    qwerty
    recurva
    semimak
    semimak_angle
    sturdy
    workman
```

Once you know which layout you want, go ahead and activate it like so:
```
$> ./activate.sh graphite

graphite layout is now the active layout
```

Alternatively, you can add it from your window manager's GUI.

#### Gnome
Open the settings dialog and go to `Keyboard -> Add Input Source -> (vertical dots at the bottom) -> Other`.  The custom layouts can be found in this list.

#### KDE
Open the system settings dialog, and go to `Keyboard -> Layouts -> Add` then just search for the layout name you want to add.

### Add more layouts to the install list
Just drop new xkb file(s) into the `linux/xkb` directory.  Then re-run the install script.
