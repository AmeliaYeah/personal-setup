# Personal I3/ZSH setup script
* Adds (keybind modded) I3 WM
	* Closing a window is `$mod+q` versus the old `$mod+Shift+Q`
	* Resizing windows are now `$mod+Ctrl+ARROW_KEY` verus the old resize mode thin
	* Screen can be locked with `$mod+x`
	* FN key brightness keys automatically set the brightness (couldn't get polybar brightness working)
		* Change these in the i3 config, as your computer key input may be different to mine
* Uses black "cuts" polybar theme (to change properly, `setup.sh` and the i3 config must be changed accordingly.)
	* **If the battery icon does not show on the polybar, for whatever theme you choose,** please set it by going to `~/.config/polybar/[THEME]/modules.ini` and modifying the battery module to whichever model you have.
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
git clone https://github.com/AmeliaYeah/personal-setup
cd personal-setup
chmod +x setup.sh
./setup.sh
cd ..
rm -rf personal-setup
```
**Script should be fully automated once you get passed the APT package installations (macchanger might spawn a yes/no dialog)**

### Misc.
1. If you're going to use `i3`, use XFCE as the desktop environment (preferrably in Debian, as Ubuntu tends to get bloated)
	* Use Noto Mono Regular 10pt for the terminal, with an underscore in xfce-terminal (looks cool)