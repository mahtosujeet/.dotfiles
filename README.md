
# There is no place like `$HOME`

This configuration uses `Hyprdots` project as base for hyprland configuration.

[![Last commit](https://img.shields.io/github/last-commit/MahtoSujeet/.dotfiles?&logo=github)](https://github.com/MahtoSujeet/.dotfiles)
[![Size](https://img.shields.io/github/repo-size/MahtoSujeet/.dotfiles?color=green)](https://github.com/MahtoSujeet/.dotfiles)

--------------------------------

## Installation

1. Start with minimal install of Arch Linux.

    - Set `parallel_downloads` to 30 in `/etc/pacman.conf`
    - Set mirrorlist to `Server = https://mirror.osbeck.com/archlinux/$repo/os/$arch`

1. Now for Hyprdots Installation

    - `pacman -S --needed git base-devel`
    - Install paru

      ```bash
      git clone <https://aur.archlinux.org/paru-bin> && cd paru-bin && makepkg -si
      ```

    - Install hyde-cli-git
      `paru -Sy hyde-cli-git`

    - Install Hyde interactively
      `Hyde-install`

1. Now to add dotfiles
    Run the following piece of code in `$HOME` directory.

    ```bash
    git clone --bare https://github.com/MahtoSujeet/.dotfiles.git $HOME/.dotfiles
    function dotfiles {
      /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
    }
    mkdir -p .dotfiles-backup
    dotfiles checkout
    if [ $? = 0 ]; then
      echo "Checked out dotfiles.";
      else
        echo "Backing up pre-existing dot files.";
        dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
    fi;
    dotfiles checkout
    dotfiles config status.showUntrackedFiles no
    ```

    It takes the backup of current config files in `.dotfiles-backup` folder and installs remote config.

-------------------------------------------------

# Config installation

Following are the general packages that you need.

```txt
kitty neovim zsh zsh-completions zsh-syntax-highlighting \
zsh-autosuggestions starship ntfs-3g intel-ucode npm
```

## Waybar config

Add following lines to the top of `~/.config/waybar/config.ctl`

```txt
0|36|bottom|( cpu memory custom/cpuinfo ) ( hyprland/workspaces mpris )|( idle_inhibitor clock ) |( network backlight pulseaudio pulseaudio#microphone custom/keybindhint ) ( privacy tray battery custom/power )
1|36|top|( cpu memory custom/cpuinfo ) ( hyprland/workspaces mpris )|( idle_inhibitor clock ) |( network backlight pulseaudio pulseaudio#microphone custom/keybindhint ) ( privacy tray battery custom/power )
```

------------------------------------

# Other Useful stuff and fixes

## Bluetooth

1. Install ```bluez blueman bluez-utils pulseaudio-bluetooth```
1. `sudo systemctl enable bluetooth.service`
1. `sudo systemctl start bluetooth.service`

## Thumbnail fix

- Dolphin - Install `ffmpegthumbs` package.
- Thunar/Nautilus - Install `ffmpeg ffmpegthumbnailer gst-libav`

In case installing these alone doesn't work, remove `~/.thumbnails`,
then `ln -s $HOME/.cache/thumbnails $HOME/.thumbnails`

## Prompt only the password for a default user in virtual console login

Getty can be used to login from a virtual console with a default user, typing the password but without needing to insert the username. For instance, to prompt the password for username on tty1:

`/etc/systemd/system/getty@tty1.service.d/skip-username.conf`
```bash
[Service]
ExecStart=
ExecStart=-/sbin/agetty -o '-p -- sujeet' --noclear --skip-login - $TERM
```

## Chaotic AUR

First, install the primary key - it can then be used to install Chaotic AUR's keyring and mirrorlist.

```bash
pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
pacman-key --lsign-key 3056513887B78AEB
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
```

Append (adding to the end of the file) to `/etc/pacman.conf`:

```
[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
```

## To mount NTFS

1. Get UUID of disk with `lsblk -f`
1. Add following to `/etc/fstab`

```
UUID=<UUID>     <mount-point>   ntfs    rw,uid=1000,gid=1000,umask=0022,fmast=0022  0 0
```

## Add WARP+

1. Install `cloudflare-warp-bin`
1. `sudo systemctl enable --now warp-svc.service`
1. `sudo systemctl stop systemd-resolved`
1. `sudo systemctl disable systemd-resolved`
1. `warp-cli register`
1. `warp-cli set-license <enter your key>`
1. To set different modes `warp-cli set-mode <your-mode>`
1. `warp-cli connect`

## Keyring related issue

Here is the required commands to reset the keys.

```bash
mv /etc/pacman.d/gnupg /root/pacman-key.bak
pacman-key --init
pacman-key --populate archlinux

pacman -Syy archlinux-keyring
```

Make sure to update the system after this.

## Disable wake on mouse move
1. `lsusb`
 output should be something like this:
```
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 002: ID 5986:211b Bison Electronics Inc. HD Webcam
Bus 001 Device 003: ID 046d:c534 Logitech, Inc. Nano Receiver
Bus 001 Device 004: ID 8087:0033 Intel Corp. AX211 Bluetooth
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
```

here `046d` is the vendor id and `c534` is the product id of the mouse.

2. Create the udev rule
`sudoedit /etc/udev/rules.d/99-disable-logitech-wakeup.rules`

  Paste the following content in the file

```txt
ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="046d", ATTR{idProduct}=="c534", TEST=="power/wakeup", ATTR{power/wakeup}="disabled"
```


## Other Apps

- `evince` - PDF Reader
- `mpv` - Video Player (VLC sucks in Linux)
- `imv` - Image Viewer
