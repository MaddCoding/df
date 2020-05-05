#! /bin/bash

download_dotfiles() {
	mkdir dotfiles
	cd dotfiles
	git clone https://github.com/MaddCoding/df.git
        cd	
}

untar_dorfiles() {
	cd dotfiles
        cd df
	tar xfvz dotfiles.tar.gz
	cd
}


mkdir_directory() {
	mkdir /home/kernel/.config 
	mkdir /home/kernel/.config/bspwm
	mkdir /home/kernel/.config/dunst
	mkdir /home/kernel/.config/gtk-3.0
	mkdir /home/kernel/.config/mpv
	mkdir /home/kernel/.config/polybar
	mkdir /home/kernel/.config/ranger
	mkdir /home/kernel/.config/sxhkd
	mkdir /home/kernel/.local
	mkdir /home/kernel/.local/bin
	mkdir /home/kernel/.root
	mkdir /home/kernel/.root/etc
	mkdir /home/kernel/.root/usr
	mkdir /home/kernel/.root/etc/systemd
	mkdir /home/kernel/.root/etc/X11
	mkdir /home/kernel/.root/etc/systemd/system
	mkdir /home/kernel/.root/etc/systemd/system/getty@tty1.service.d
	mkdir /home/kernel/.root/etc/X11/xorg.conf.d
	mkdir /home/kernel/.root/usr/share
	mkdir /home/kernel/.root/usr/share/X11
	mkdir /home/kernel/.root/usr/share/X11/xkb
	mkdir /home/kernel/.root/usr/share/X11/xkb/symbols
	mkdir /home/kernel/Pictures
	mkdir /home/kernel/Pictures/Wallpapers
	mkdir /home/kernel/.config/neofetch
}

install_dotfiles() {
	cd /home/kernel/dotfiles/df/home/kernel/ss
	cd .config
	cp -f bspwm/bspwmrc /home/kernel/.config/bspwm/bspwmrc
	chmod +x /home/kernel/.config/bspwm/bspwmrc
	cp -f dunst/dunstrc /home/kernel/.config/dunst/dunstrc
	cp -f gtk-3.0/settings.ini /home/kernel/.config/gtk-3.0/settings.ini
	cp -f mpv/input.conf /home/kernel/.config/mpv/input.conf
	cp -f mpv/mpv.conf /home/kernel/.config/mpv/mpv.conf
	cp -f polybar/config /home/kernel/.config/polybar/config
	cp -f polybar/launch /home/kernel/.config/polybar/launch
	chmod +x /home/kernel/.config/polybar/launch
	cp -f ranger/rc.conf /home/kernel/.config/ranger/rc.conf
	cp -f sxhkd/sxhkdrc /home/kernel/.config/sxhkd/sxhkdrc
	chmod +x /home/kernel/.config/sxhkd/sxhkdrc
	cp -f chromium-flags.conf /home/kernel/.config/chromium-flags.conf
	cp -f compton.conf /home/kernel/.config/compton.conf
	cd ..
	cd .local/bin
	cp dmenu-bookmarks /home/kernel/.local/bin/dmenu-bookmarks
	cp dmenu-calc /home/kernel/.local/bin/calc
	cp dmenu-help /home/kernel/.local/bin/help
	cp dmenu-power /home/kernel/.local/bin/dmenu-power
	cp dmenu-switcher /home/kernel/.local/bin/dmenu-switcher
	cp dmenu-trans /home/kernel/.local/bin/dmenu-trans
	cp dmenu-bookmarks /home/kernel/.local/bin/dmenu-bookmarks
	cp dmenu-vbox /home/kernel/.local/bin/dmenu-vbox
	cp dmenu-wifi /home/kernel/.local/bin/dmenu-wifi
	cp umpv /home/kernel/.local/bin/umpv
	cd ..
	cd ..
	cp -f .root/etc/systemd/system/getty@tty1.service.d/override.conf /home/kernel/.root/etc/systemd/system/getty@tty1.service.d/override.conf
	cp -f .root/etc/X11/xorg.conf.d/20-intel.conf /home/kernel/.root/etc/X11/xorg.conf.d/20-intel.conf
	cp -f .root/etc/X11/xorg.conf.d/30-touchpad.cond /home/kernel/.root/etc/X11/xorg.conf.d/30-touchpad.conf
	cp -f .root/etc/intel-undervolt.conf /home/kernel/.root/etc/intel-undervolt.conf
	cp -f .root/usr/share/X11/xkb/symbols/us /home/kernel/.root/usr/share/X11/xkb/symbols/us
	cp -f Pictures/Wallpapers/Waterfall.jpg /home/kernel/Pictures/Wallpapers/Waterfall.jpg
	cp -f .alacritty.yml /home/kernel/.alacritty.yml
	cp -f .hushlogin /home/kernel/.hushlogin
	cp -f .tmux.conf /home/kernel/.tmux.conf
	cp -f .vimrc /home/kernel/.vimrc
	cp -f .xinitrc /home/kernel/.xinitrc
	cp -f .zprofile /home/kernel/.zprofile
	cp -f .zshrc /home/kernel/.zshrc
	cd
}


install_aur_helper() {
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
}

install_core_packages() {
    sudo pacman --noconfirm --needed -S vim zsh wget alsa-utils bc dunst feh fzf git libnotify maim npm playerctl translate-shell ttf-dejavu wmctrl xautolock xcape xclip xdotool xorg-server xorg-setxkbmap xorg-xbacklight xorg-xinit xorg-xrandr xorg-xsetroot xss-lock
    yay --noconfirm --needed -S mons nerd-fonts-source-code-pro polybar-git sxhkd-git bspwm-git

    # zsh plugins
    sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    chsh -s /bin/zsh kernel
    systemctl mask systemd-backlight@backlight:acpi_video0 systemd-backlight@backlight:acpi_video1
    cd
    git clone https://github.com/Zay4ik/configs.git
    cd configs
    sudo cp neofetch/neofetch /usr/bin/neofetch
    sudo cp neofetch/config.conf ~/.config/neofetch/
    cd ..
    git clone https://github.com/popstas/zsh-command-time.git ~/.oh-my-zsh/custom/plugins/command-time
    sudo mkdir /usr/share/zsh/plugins
    cd /usr/share/zsh/plugins
    sudo git clone https://github.com/zsh-users/zsh-autosuggestions
    sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting
    sudo pacman -S pkgfile
    sudo pkgfile --update
    cd 

    # compton
    sudo pacman --noconfirm --needed -S asciidoc libconfig
    git clone https://github.com/tryone144/compton.git
    cd compton
    make PREFIX=/usr/local
    make docs
    sudo make PREFIX=/usr/local install
    cd ..
    rm -rf compton

    # alacritty
    sudo pacman --noconfirm --needed -S alacritty

    # dmenu
    git clone https://github.com/khuedoan98/dmenu
    cd dmenu
    sudo make clean install && sudo make clean
    cd ..
    rm -rf dmenu

    # slock
    git clone https://github.com/khuedoan98/slock
    cd slock
    sudo make clean install && sudo make clean
    cd ..
    rm -rf slock

    # pfetch
    yay --noconfirm --needed -S pfetch-git

    # lxdm
    sudo pacman --noconfirm --needed -S lxdm
    sudo systemctl enable lxdm
}

install_extra_packages() {
    sudo pacman --noconfirm --needed -S lxappearance arc-gtk-theme aria2 glances gvfs htop man mpv noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ntfs-3g papirus-icon-theme pcmanfm-gtk3 firefox ranger tmux tree unrar unzip w3m xarchiver xdg-user-dirs-gtk youtube-dl zathura zathura-pdf-mupdf zip
    gpg --recv-keys EB4F9E5A60D32232BB52150C12C87A28FEAC6B20
    yay --noconfirm --needed -S chromium-widevine ttf-ms-fonts xdg-user-dirs-update
}


install_intel_graphics() {
    sudo pacman --noconfirm --needed -S xf86-video-intel libva-intel-driver
}

install_amd_graphics() {
    sudo pacman --noconfirm --needed -S xf86-video-ati
}

install_unikey() {
    sudo pacman --noconfirm --needed -S ibus-unikey
}

create_ssh_key(){
    mkdir /home/kernel/.ssh
    ssh-keygen -t rsa
    ssh-add /home/kernel/.ssh/id_rsa
}

install_dev_tools() {
    # Docker
    sudo pacman --noconfirm --needed -S docker-compose
    sudo usermod -aG docker $USER
    # Python
    sudo pacman --noconfirm --needed -S python-pipenv
    # Markdown to PDF
    sudo pacman --noconfirm --needed -S wkhtmltopd
    curl -s https://raw.githubusercontent.com/khuedoan98/mdtopdf/master/mdtopdf > /home/kernel/.local/bin/mdtopdf
    chmod +x /home/kernel/.local/bin/mdtopdf
}

download_dotfiles 
untar_dorfiles 
mkdir_directory 
install_dotfiles 
install_aur_helper
install_core_packages
install_extra_packages
install_intel_graphics
install_amd_graphics
install_unikey
install_battery_saver
create_ssh_key
install_dev_tools







