
# There is no place like `$HOME`

My configuration files for Arch Linux.

[![Last commit](https://img.shields.io/github/last-commit/MahtoSujeet/.dotfiles?&logo=github)](https://github.com/MahtoSujeet/.dotfiles)
[![Size](https://img.shields.io/github/repo-size/MahtoSujeet/.dotfiles?color=green)](https://github.com/MahtoSujeet/.dotfiles)


# Installation
1. Install `git stow`
2. Clone the repo
```
git clone https://github.com/mahtosujeet/.dotfiles.git ~/.dotfiles
```
3. Stow the configs you want to use (see below for stow commands)

# Some Important stow commands
1. To stow a config
  ```sh
  stow <config-name>
  ```
2. To unstow a config
  ```sh
  stow -D <config-name>
  ```
3. To stow all configs (*/ skips .git and README.md)
  ```sh
  stow */
  ```
4. To unstow all configs
  ```sh
  stow -D */
  ```
5. To stow a config to a specific location
  ```sh
  stow -t <target-location> <config-name>
  ```


# Auto sync of Git repos

The list of repo is mentioned in `~/.local/bin/gitsync.sh`

## setup
```
systemctl --user daemon-reload
systemctl --user enable --now gitsync.timer
```

* To check the logs

```
systemctl --user status gitsync.service
```

* Timer lists

```
 systemctl --user list-timers gitsync.timer
```

# Config installation

Following are the general packages that you need.

```txt
neovim zsh zsh-completions zsh-syntax-highlighting \
zsh-autosuggestions starship ntfs-3g intel-ucode npm
```


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

[Official Installation Guide](https://aur.chaotic.cx/docs)

## To mount NTFS

1. Get UUID of disk with `lsblk -f`
1. Add following to `/etc/fstab`

```
UUID=<UUID>     <mount-point>   ntfs    rw,uid=1000,gid=1000,umask=0022,fmask=0022  0 0
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


# Better Mirrorlist
```
Server = https://mirror.osbeck.com/archlinux/$repo/os/$arch
Server = https://appuals.com/archlinux/$repo/os/$arch
Server = http://mirror.bizflycloud.vn/archlinux/$repo/os/$arch
Server = http://mirror.faizuladib.com/archlinux/$repo/os/$arch
Server = http://vpsmurah.jagoanhosting.com/archlinux/$repo/os/$arch
Server = https://mirror.sahil.world/archlinux/$repo/os/$arch
Server = http://mirror.sahil.world/archlinux/$repo/os/$arch
Server = https://in-mirror.garudalinux.org/archlinux/$repo/os/$arch
Server = https://mirror.4v1.in/archlinux/$repo/os/$arch
Server = https://in.mirrors.cicku.me/archlinux/$repo/os/$arch
Server = https://mirrors.nxtgen.com/archlinux-mirror/$repo/os/$arch
Server = http://mirrors.nxtgen.com/archlinux-mirror/$repo/os/$arch
Server = http://mirror.albony.in/archlinux/$repo/os/$arch
Server = http://mirror.4v1.in/archlinux/$repo/os/$arch
Server = http://in.mirrors.cicku.me/archlinux/$repo/os/$arch
Server = http://in-mirror.garudalinux.org/archlinux/$repo/os/$arch
```
