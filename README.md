# Personal I3/ZSH setup script
* Adds (keybind modded) I3 WM
	* Closing a window is `$mod+q` versus the old `$mod+Shift+Q`
	* Resizing windows are now `$mod+Ctrl+ARROW_KEY` verus the old resize mode thin
* Uses black "cuts" polybar theme (to change properly, `setup.sh` and the i3 config must be changed accordingly.)
* Uses type 1 (style 8) rofi theme (this can be changed in the i3 config, though)
	* Keybind `$mod+Space`
* NetworkManager_dmenu replaces regular dmenu (in favor of rofi) at `$mod+d`
* epic dr robotnik hackerman wallpaper/lockscreen
* ZSH uses powerlevel10k with a dotfile
	* batcat and lsd are installed for just some extra spice

## Information

### Supported distros
Currently, this only works on Debian/Ubuntu based distros. This was tested on pure Debian; intended for use with Kali for pentesting engagements and whatnot and for my own general personal use. Very simple script though; so it could work for Arch if it's modified enough.

### Installation
```bash
git clone https://github.com/AmeliaYeah/i3-zsh-setup
cd i3-zsh-setup
chmod +x setup.sh
./setup.sh
cd ..
rm -rf i3-zsh-setup
```
**Script should be fully automated once you get passed the APT package installations (macchanger might spawn a yes/no dialog)**