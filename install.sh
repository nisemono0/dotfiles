#!/bin/bash

# Path of this script
script_path="$(pwd)"
pkgs_path="$script_path"/pkgs
sys_configs_path="$script_path"/sys_configs

# Colors
WH=$(echo -ne '\033[1;37m')
YE=$(echo -ne '\033[1;33m')
PU=$(echo -ne '\033[1;35m')
NC=$(echo -ne '\033[0m')

# Install yay
function install_aur_helper () {
    echo -en "${PU}Do you want to install ${YE}yay ${PU}(y/n): ${NC}"
    read -r yay
    if [ "${yay}" = "y" ] || [ "${yay}" = "" ]; then
        cmd="$(whereis yay)"
        if [[ $cmd != */* ]]; then
            echo -e "${YE}Installing yay...${NC}"
            sleep 1
            git clone https://aur.archlinux.org/yay.git
            cd yay && makepkg --noconfirm -sic
            cd "${script_path}" || exit
            echo -e "${WH}Done installing ${YE}yay!${NC}"
        else
            echo -e "${YE}yay ${PU}already installed${NC}"
        fi
    else
        echo -e "${YE}yay ${PU}not installed${NC}"
    fi
}

# Install GPU drivers
function install_gpu_drivers () {
    echo -e "${YE}[!!!] ${PU}This will install open source drivers ${YE}[!!!] ${NC}"
    echo -e "${YE}[!!!] ${PU}You should check the wiki/manually install them ${YE}[!!!] ${NC}"
    echo -en "${PU}Do you want to install ${YE}GPU drivers (will install multilib packages as well) (y/n): ${NC}"
    read -r gpudrv
    if [ "${gpudrv}" = "y" ] || [ "${gpudrv}" = "" ]; then
        sudo -E pacman -S --noconfirm --color=always --needed mesa lib32-mesa
        PS3="${PU}Please select your ${YE}GPU:${NC}"
        options=("AMD" "Nvidia" "Intel GPU")
        select sel in "${options[@]}"
        do
            case $sel in
                "AMD")
                    echo -e "${PU}Installing ${YE}AMD drivers...${NC}"
                    sleep 1
                    sudo -E pacman -S --noconfirm --color=always --needed xf86-video-amdgpu vulkan-radeon lib32-vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau
                    echo -e "${WH}Done !${NC}"
                    break
                    ;;
                "Nvidia")
                    echo -e "${PU}Installing ${YE}Nvidia drivers...${NC}"
                    sleep 1
                    yay -S --color=always --needed nouveau-fw
                    sudo -E pacman -S --noconfirm --color=always --needed xf86-video-nouveau vulkan-nouveau lib32-vulkan-nouveau libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau
                    echo -e "${WH}Done !${NC}"
                    break
                    ;;
                "Intel GPU")
                    echo -e "${PU}Installing ${YE}Intel GPU drivers...${NC}"
                    sleep 1
                    sudo -E pacman -S --noconfirm --color=always --needed xf86-video-intel vulkan-intel lib32-vulkan-intel
                    PS3="${PU}Please select your ${YE}Intel chip:${NC}"
                    chip_opts=("Broadwell (2014) and newer" "GMA 4500 (2008) up to Coffee Lake (2017)")
                    select chip_sel in "${chip_opts[@]}"
                    do
                        case $chip_sel in
                            "Broadwell (2014) and newer")
                                sudo -E pacman --color=always --needed intel-media-driver
                                break
                                ;;
                            "GMA 4500 (2008) up to Coffee Lake (2017)")
                                sudo -E pacman --color=always --needed libva-intel-driver lib32-libva-intel-driver
                                break
                                ;;
                            *)
                                echo -e "${PU}Invalid option $REPLY ${NC}" ;;
                        esac
                    done
                    echo -e "${WH}Done !${NC}"
                    break
                    ;;
                *)
                    echo -e "${PU}Invalid option $REPLY ${NC}" ;;
            esac
        done
    else
        echo -e "${YE}GPU Drivers ${PU}not installed${NC}"
    fi
}

# Install CPU Microcode
function install_cpu_ucode () {
    echo -en "${PU}Do you want to install ${YE}CPU Microcode ${PU}(y/n): ${NC}"
    read -r cpuucode
    if [ "${cpuucode}" = "y" ] || [ "${cpuucode}" = "" ]; then
        PS3="${PU}Please select your ${YE}CPU:${NC}"
        options=("AMD" "Intel")
        select sel in "${options[@]}"
        do
            case $sel in
                "AMD")
                    echo -e "${PU}Installing ${YE}AMD microcode...${NC}"
                    sleep 1
                    sudo -E pacman -S --noconfirm --color=always --needed amd-ucode
                    echo -e "${WH}Done !${NC}"
                    break
                    ;;
                "Intel")
                    echo -e "${PU}Installing ${YE}Intel microcode...${NC}"
                    sudo -E pacman -S --noconfirm --color=always --needed intel-ucode
                    echo -e "${WH}Done !${NC}"
                    break
                    ;;
                *)
                    echo -e "${PU}Invalid option $REPLY ${NC}" ;;
            esac
        done
    else
        echo -e "${YE}CPU Microcode ${PU}not installed${NC}"
    fi
}

# Install main packages
function install_main_packages () {
    echo -e "${PU}Installing ${YE}main packages${PU}...${NC}"
    mainpkgs="$pkgs_path/mainpkgs.txt"
    sleep 1
    sudo -E pacman -S --noconfirm --color=always --needed - < "$mainpkgs"
    echo -e "${WH}Done installing ${YE}main packages!${NC}"
}

# Install AUR packages
function install_aur_packages () {
    echo -e "${PU}Installing ${YE}AUR packages...${NC}"
    aurpkgs="$pkgs_path/foreignpkgs.txt"
    sleep 1
    yay -S --color=always --needed - < "$aurpkgs"
    echo -e "${WH}Done installing ${YE}AUR packages!${NC}"
}

# Install optional dependencies
function install_optdeps () {
    echo -e "${PU}Installing ${YE}optional dependencies...${NC}"
    optpkgs="$pkgs_path/optdeplist.txt"
    sleep 1
    sudo -E pacman -S --noconfirm --color=always --needed --asdeps - < "$optpkgs"
    echo -e "${WH}Done installing ${YE}opt deps!${NC}"
}

# Copy some /etc/ config files and grub theme
function install_sysconfigs () {
    echo -e "${PU}Copying ${YE}sys configs...${NC}"
    sleep 1
    issue_conf="$sys_configs_path/etc_issue"
    default_grub="$sys_configs_path/etc_default_grub"
    pacman_conf="$sys_configs_path/etc_pacman.conf"
    makepkg_conf="$sys_configs_path/etc_makepkg.conf"
    polkit_rules="$sys_configs_path/usr_share_polkit-1_rules.d_10-udisks.rules"
    modprobe_rule="$sys_configs_path/etc_modprobe.d_nontfs3.conf"
    cat < "$issue_conf" | sudo -E tee /etc/issue 1> /dev/null
    cat < "$default_grub" | sudo -E tee /etc/default/grub 1> /dev/null
    cat < "$pacman_conf" | sudo -E tee /etc/pacman.conf 1> /dev/null
    cat < "$makepkg_conf" | sudo -E tee /etc/makepkg.conf 1> /dev/null
    sudo -E mkdir -p /usr/share/polkit-1/rules.d/
    cat < "$polkit_rules" | sudo -E tee /usr/share/polkit-1/rules.d/10-udisks.rules 1> /dev/null
    cat < "$modprobe_rule" | sudo -E tee /etc/modprobe.d/nontfs3.conf 1> /dev/null
    sudo -E pacman -Syu # Update for pacman.conf
    echo -e "${WH}Done installing ${YE}sys configs!${NC}"
}

# Install oh-my-zsh
function install_ohmyzsh () {
    echo -e "${PU}Installing ${YE}oh-my-zsh...${NC}"
    sleep 1
    # Get the omz install script and change the default location to ~/.config/oh-my-zsh
    curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sed "s/\${ZSH:-\$HOME\/.oh-my-zsh}/\${ZSH:-\$HOME\/.config\/oh-my-zsh}/g" > zsh_install.sh
    chmod +x zsh_install.sh
    sh zsh_install.sh --unattended
    echo -e "${WH}Done installing ${YE}oh-my-zsh!${NC}"
}

# Copy dotfiles
function install_dotfiles () {
    echo -e "${PU}Copying ${YE}dotfiles...${NC}"
    sleep 1
    cp -rvT "$script_path" "$HOME"/ # Copy all configs
    echo -e "${WH}Done installing ${YE}dotfiles!${NC}"
}

# Clean home from unwanted dirs
function clean_home () {
    echo -e "${PU}Cleaning home directory...${NC}"
    sleep 1
    home_script="$HOME/$(basename "$0")"
    zsh_install_script="$HOME/zsh_install.sh"
    home_pkgs="$HOME/$(basename "$pkgs_path")"
    home_sys_config="$HOME/$(basename "$sys_configs_path")"
    yay_folder="$HOME/yay"
    git_cp_folder="$HOME/.git"
    rm -f "$home_script"
    rm -f "$zsh_install_script"
    rm -fr "$home_pkgs"
    rm -fr "$home_sys_config"
    rm -fr "$yay_folder"
    rm -fr "$git_cp_folder"
    echo -e "${WH}Done cleaning ${YE}home directory!${NC}"
}

# Post install stuff
function post_install () {
    echo -e "${PU}Staring post install...${NC}"

    # Hacky way
    sudo ln -s /usr/bin/nsxiv /usr/bin/sxiv

    chsh -s /bin/zsh
    echo -e "${WH}Changed default shell for $USER to ${YE}zsh!${NC}"

    to_modify_arr=("i3cmds/mousespeed.sh" "i3cmds/wall-change/wall-web.sh" "polybar/polybar-systemps.sh" "polybar/weather-forecast.sh" "polybar/weather.sh" "mpd/mpdsong.sh" "ncmpcpp/ncmpcpp_cover_art.sh")
    echo -e "${WH}Please modify the following scripts, adding api keys, gpu/cpu names, custom paths, etc.:${NC}"
    for scr in "${to_modify_arr[@]}"; do
        echo -e "${PU}\t==>$HOME/.scripts/${scr}${NC}"
    done
}

# Start install
function start_install () {
    echo -e "${PU}Staring install... (This will do a system upgrade first)${NC}"
    sleep 1
    install_sysconfigs
    install_aur_helper
    install_gpu_drivers
    install_cpu_ucode
    install_main_packages
    install_aur_packages
    install_optdeps
    install_ohmyzsh
    install_dotfiles
    clean_home
    post_install
    echo -e "${WH}Finished installing!${NC}"
    echo -e "${WH}Check if cleanup is needed in home dir!${NC}"
}

# Start
start_install
