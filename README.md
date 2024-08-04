# Alternate Keyboard Layout Installer for Linux
Simple script to install a collection of alternative keyboard layouts on Linux, without the need for sudo/root.

Keyboard layouts on Linux are a bit of a pain to work with, so I created this repo to make it dead simple to install a large collection of alternative keyboard layouts, and switch between them quickly.
This script will work with both X11 and Wayland, and does not require any third party software.  To add additional layouts, just drop the xkb file in the `linux/xkb` directory and make sure you rename the file to the name of your layout.

# Install
```
git clone https://github.com/xedrac/keyboard-layouts.git
cd keyboard-layouts/linux
./local-install.sh
```

Log out and log back in


# Change Active Layout via script

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

# Change Active Layout via Window Manager

You can also simply add the layout from your window manager GUI.  But you may have to dig a little to find the custom layouts.

For example, in Gnome, I had to go to Settings->Keyboard->Add Input Source, then click the little 3 vertical dots at the bottom, then select "Other", then I could find all of the custom layouts.







