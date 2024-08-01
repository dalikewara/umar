#!/bin/sh

version="v1.0.2"

umar="I am Umar ($version), your little Linux assistant. I can help you with the common tasks listed below.
I will continue to be updated indefinitely, as my creator may need to add new features,
update my logic, fix issues, or make other changes. So, I may get smarter every day."
invalid_command="Sorry, I can't understand your command"
command_open_empty="You didn't provide any names to open!"
command_open_name_not_found="is not found!"
command_kill_empty="You didn't provide any names to kill!"
command_kill_confirmation="All processes listed above will be terminated. Are you sure? [N/y]"
command_kill_confirmation_y="All processes have been terminated!"
command_kill_confirmation_n="Aborted!"
command_install_empty="You didn't provide any names to install!"
command_remove_empty="You didn't provide any names to remove!"

pid=$$
search_url="https://www.google.com/search?q="
distro="unknown"
user_package_dir="/usr/local/bin"
color_green='\033[0;32m'
color_reset='\033[0m'
repo_url="https://raw.githubusercontent.com/dalikewara/umar/master"
script_name="umar.sh"
install_dir="/usr/local/bin"
target_name="umar"

distro_is_unknown="Unknown distribution"
package_not_installed="is not installed. Do you want to install it? [N/y]"
package_is_needed="I need that package to process the command"
package_needed_installed="The required package(s) have been installed. Refresh the current console/terminal session and run the command again"

commands="get smarter:Once I’ve been installed, you can upgrade me to the latest version
:using this command
version:Show my current version
open:Open package(s)
kill:Kill package(s) process
search:Search for the given keyword(s) using a search engine
install:Install package(s)
remove:Remove package(s)
upgrade:Upgrade package(s)
"

umar() {
    if is_no_argument "$@"; then
        echo "
$umar
"

        echo "$commands" | while IFS=: read -r _a _b; do
            printf "${color_green}%-15s ${color_reset}%s\n" "$_a" "$_b"
        done
        
        exit 0
    fi

    if [ "$1" = "open" ]; then
        shift
        open_i3wm "$@"
    elif [ "$1" = "kill" ]; then
        shift
        kill_process "$@"
    elif [ "$1" = "search" ]; then
        shift
        search_i3wm "$@"
    elif [ "$1" = "install" ]; then
        shift
        install "$@"
    elif [ "$1" = "remove" ]; then
        shift
        remove "$@"
    elif [ "$1" = "upgrade" ]; then
        shift
        upgrade "$@"
    elif [ "$1" = "version" ]; then
        echo "$version"
    elif [ "$1 $2" = "get smarter" ]; then
        get_smarter
    else
        echo_exit "$invalid_command"
    fi
}

echo_exit() {
    echo $1
    exit 0
}

is_no_argument() {
    [ $# -eq 0 ]
}

is_arch() {
    [ "$distro" = "arch" ] || [ "$distro" = "manjaro" ]
}

is_debian() {
    [ "$distro" = "debian" ] || [ "$distro" = "ubuntu" ]
}

is_fedora() {
    [ "$distro" = "fedora" ] || [ "$distro" = "centos" ]
}

is_unknown() {
    [ "$distro" = "unknown" ]
}

is_package_exist() {
    command -v $1 > /dev/null 2>&1
}

is_user_package_exist() {
    test -f "$user_package_dir/$1"
}

install_arch() {
    if is_arch; then
        sudo pacman -S "$@"
    fi
}

install_debian() {
    if is_debian; then
        sudo apt update
        sudo apt install "$@"
    fi
}

install_fedora() {
    if is_fedora; then
        sudo dnf install "$@"
    fi
}

install_combine() {
    install_arch "$@"
    install_debian "$@"
    install_fedora "$@"
}

install_needed() {
    if is_package_exist "$1"; then
        echo ""
    else
        if is_user_package_exist "$1"; then
            echo ""
        else
            echo "\"$1\" $package_not_installed"

            read _a

            if [ "$_a" = "y" ]; then
                if is_unknown; then
                    echo "$distro_is_unknown"
                    echo_exit "$package_is_needed"
                fi

                install_combine "$1"

                echo_exit "$package_needed_installed"
            fi

            echo_exit "$package_is_needed"
        fi
    fi
}

remove_arch() {
    if is_arch; then
        sudo pacman -Rsd --cascade "$@"
    fi
}

remove_debian() {
    if is_debian; then
        sudo apt autoremove --purge "$@"
    fi
}

remove_fedora() {
    if is_fedora; then
        sudo dnf remove "$@"
    fi
}

remove_combine() {
    remove_arch "$@"
    remove_debian "$@"
    remove_fedora "$@"
}

upgrade_arch() {
    if is_arch; then
        sudo pacman -Syu "$@"
    fi
}

upgrade_debian() {
    if is_debian; then
        sudo apt update
        sudo apt autoremove --purge
        sudo apt upgrade "$@"
    fi
}

upgrade_fedora() {
    if is_fedora; then
        sudo dnf upgrade "$@"
    fi
}

upgrade_combine() {
    upgrade_arch "$@"
    upgrade_debian "$@"
    upgrade_fedora "$@"
}

exec_async_no_std_out() {
    exec "$@" > /dev/null 2>&1 &
}

exec_default() {
    exec "$@" 2> /dev/null
}

i3wm_split_lr() {
    i3-msg split h > /dev/null 2>&1
}

i3wm_focus_r() {
    i3-msg focus right > /dev/null 2>&1
}

i3wm_focus_l() {
    i3-msg focus left > /dev/null 2>&1
}

i3wm_exec_async_no_std_out_r() {
    i3wm_split_lr
    exec_async_no_std_out "$@"
    i3wm_focus_r
    i3wm_focus_l
}

i3wm_exec_default_r() {
    i3wm_split_lr
    exec_default "$@"
    i3wm_focus_r
    i3wm_focus_l
}

i3wm_kill() {
    i3-msg kill > /dev/null 2>&1
}

determine_distro() {
    if [ -f /etc/os-release ]; then
        distro=$(awk -F= '/^ID=/ { print $2 }' /etc/os-release | tr -d '"')
    fi

    case "$distro" in
        arch*) distro="arch" ;;
        debian*) distro="debian" ;;
        ubuntu*) distro="ubuntu" ;;
        fedora*) distro="fedora" ;;
        centos*) distro="centos" ;;
        #opensuse*) distro="opensuse" ;;
        manjaro*) distro="manjaro" ;;
        *) distro="unknown" ;;
    esac
}

open_i3wm() {
    if is_no_argument "$@"; then
        echo_exit "$command_open_empty"
    fi

    a=""

    for arg in "$@"; do 
        if is_package_exist $arg; then
            i3wm_exec_async_no_std_out_r $arg
        else
	        if is_user_package_exist $arg; then
	            i3wm_exec_async_no_std_out_r $arg
            else
                a="yes"
		        echo "\"$arg\" $command_open_name_not_found"
	        fi
        fi
    done

    if [ "$a" != "yes" ]; then
        i3wm_kill
    fi
}

kill_process() {
    if is_no_argument "$@"; then
        echo_exit "$command_kill_empty"
    fi

    a=""

    for arg in "$@"; do
        a="$a\n$(ps -ef | grep $arg | grep -v "$pid" | awk '{print $2}')"
        ps aux | grep $arg | grep -v "$pid"
    done

    a=$(printf "$a")

    echo "
$command_kill_confirmation"

    read -r b

    if [ "$b" = "y" ]; then
        echo "$a" | while IFS= read -r line; do
            if [ "$line" != "" ]; then
                sudo kill -9 "$line" > /dev/null 2>&1
            fi
        done

        echo "$command_kill_confirmation_y"

        exit 0
    fi

    echo "$command_kill_confirmation_n"
}

search_i3wm() {
    a="w3m"

    install_needed $a
    i3wm_exec_default_r $a "$search_url$(echo "$*" | sed 's/ /+/g')"
    i3wm_kill
}

install() {
    if is_no_argument "$@"; then
        echo_exit "$command_install_empty"
    fi

    install_combine "$@"
}

remove() {
    if is_no_argument "$@"; then
        echo_exit "$command_remove_empty"
    fi

    remove_combine "$@"
}

upgrade() {
    upgrade_combine "$@"
}

get_smarter() {
    echo "Downloading the latest version of $script_name from $repo_url..."
    curl -L "$repo_url/$script_name" -o "/tmp/$script_name"

    echo "Installing $target_name to $install_dir..."
    sudo mv "/tmp/$script_name" "$install_dir/$target_name"

    echo "Making $target_name executable..."
    sudo chmod +x "$install_dir/$target_name"

    if [ -x "$install_dir/$target_name" ]; then
        echo "$target_name installed/upgraded successfully!"
    else
        echo "Failed to install/upgrade $target_name"
        exit 0
    fi
}

determine_distro
umar "$@"

