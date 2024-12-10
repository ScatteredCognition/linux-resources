## Launch arguments and flags for Electron apps
Various launch arguments and flags for 
Electron apps.

### Launch arguments :
**You need to copy the app's `.desktop` file to `~/.local/share/applications/` and append it after `Exec=` in all entry fields.**

- `--ozone-platform-hint=auto` <br>
Runs the app with Wayland support.
- `--enable-wayland-ime` <br>
Enables iBus/Fcitx support.
- `--enable-features=TouchpadOverscrollHistoryNavigation` <br>
(Use for browsers. e.g. Brave)
Enables navigation via touchpad gestures.

### Flags (set with `chrome://flags`) (mainly for browsers)

- `#ozone-platform-hint` - **Auto** <br>
Enables Wayland support.
- `#wayland-ui-scaling` - **Enabled** <br>
Enables Fractional Scaling support under Wayland.
- `#wayland-per-window-scaling` - **Enabled** <br>
Enables per-window scaling support.
- `#wayland-text-input-v3` - **Enabled** <br>
idk.
- `#middle-button-autoscroll` - **Enabled** <br>
Enables middle-click autoscroll.
- `#web-app-universal-install` - **Enabled** <br>
Enables installation of normal websites as webapps.