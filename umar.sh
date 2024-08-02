#!/bin/sh

version="v1.0.4"

umar="I am Umar ($version), your little Linux assistant. I can help you with the common tasks listed below.
I will continue to be updated indefinitely, as my creator may need to add new features,
update my logic, fix issues, or make other changes. So, I may get smarter every day."
invalid_command="Sorry, I can't understand your command"
command_open_name_not_found="is not found!"
command_kill_confirmation="All processes listed above will be terminated. Are you sure? [N/y]"
command_kill_confirmation_y="All processes have been terminated!"
command_kill_confirmation_n="Aborted!"

kill_empty="You didn't provide any names to kill!"
open_empty="You didn't provide any names to open!"
install_empty="You didn't provide any names to install!"
remove_empty="You didn't provide any names to remove!"
show_empty="You didn't provide any names to show!"

pid=$$
search_url="https://www.google.com/search?q="
distro="unknown"
de="unknown"
user_package_dir="/usr/local/bin"
color_green='\033[0;32m'
color_reset='\033[0m'
repo_url="https://raw.githubusercontent.com/dalikewara/umar/master"
script_name="umar.sh"
install_dir="/usr/local/bin"
target_name="umar"
browser="w3m"
img_display="feh"

distro_is_unknown="Unknown distribution"
package_not_installed="is not installed. Do you want to install it? [N/y]"
package_is_needed="I need that package to process the command"
package_needed_installed="The required package(s) have been installed. Refresh the current console/terminal session and run the command again"

commands="get smarter:Upgrade me to the latest version
version:Show my current version
open:Open package(s)
kill:Kill package(s) process
search:Search for the given keyword(s) using a search engine
install:Install package(s)
remove:Remove package(s)
upgrade:Upgrade package(s)
show image:Show image
"

umar() {
  check_umar_empty "$@"

  if [ "$1" = "open" ]; then
    shift
    u_open "$@"
  elif [ "$1" = "kill" ]; then
    shift
    u_kill_process "$@"
  elif [ "$1" = "search" ]; then
    shift
    u_search "$@"
  elif [ "$1" = "install" ]; then
    shift
    u_install "$@"
  elif [ "$1" = "remove" ]; then
    shift
    u_remove "$@"
  elif [ "$1" = "upgrade" ]; then
    shift
    u_upgrade "$@"
  elif [ "$1" = "version" ]; then
    echo "$version"
  elif [ "$1 $2" = "get smarter" ]; then
    u_get_smarter
  elif [ "$1 $2" = "show image" ]; then
    shift
    shift
    u_show_image "$@"
  else
    echo_exit "$invalid_command"
  fi
}

u_open() {
  check_open_empty "$@"

  a=""

  for arg in "$@"; do
    if is_package_exist "$arg"; then
      exec_combine_async_no_std_out "$arg"
    else
      if is_user_package_exist "$arg"; then
        exec_combine_async_no_std_out "$arg"
      else
        a="yes"

        echo "\"$arg\" $command_open_name_not_found"
      fi
    fi
  done

  if [ "$a" != "yes" ]; then
    kill_combine
  fi
}

u_kill_process() {
  check_kill_empty "$@"

  a=""

  for arg in "$@"; do
    a="$a\n$(ps -ef | grep "$arg" | grep -v "$pid" | awk '{print $2}')"
    ps aux | grep "$arg" | grep -v "$pid"
  done

  a=$(printf '..%s..' "$a")

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

u_search() {
  install_needed $browser
  exec_combine_default $browser "$search_url$(echo "$*" | sed 's/ /+/g')"
  kill_combine
}

u_install() {
  check_install_empty "$@"
  install_combine "$@"
}

u_remove() {
  check_remove_empty "$@"
  remove_combine "$@"
}

u_upgrade() {
  upgrade_combine "$@"
}

u_get_smarter() {
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

u_show_image() {
  check_show_empty "$@"
  install_needed $img_display
  exec_combine_async_no_std_out $img_display "$@"
}

# echo

echo_exit() {
  echo "$1"
  exit 0
}

# check

check_umar_empty() {
  if is_no_argument "$@"; then
    echo "
$umar
"

    echo "$commands" | while IFS=: read -r _a _b; do
      printf "${color_green}%-15s ${color_reset}%s\n" "$_a" "$_b"
    done

    exit 0
  fi
}

check_kill_empty() {
  if is_no_argument "$@"; then
    echo_exit "$kill_empty"
  fi
}

check_open_empty() {
  if is_no_argument "$@"; then
    echo_exit "$open_empty"
  fi
}

check_install_empty() {
  if is_no_argument "$@"; then
    echo_exit "$install_empty"
  fi
}

check_remove_empty() {
  if is_no_argument "$@"; then
    echo_exit "$remove_empty"
  fi
}

check_show_empty() {
  if is_no_argument "$@"; then
    echo_exit "$show_empty"
  fi
}

# is

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

is_de_i3wm() {
  [ "$de" = "i3wm" ] || [ "$de" = "i3" ] || [ "$de" = "I3WM" ] || [ "$de" = "I3" ]
}

is_package_exist() {
  command -v "$1" > /dev/null 2>&1
}

is_user_package_exist() {
  test -f "$user_package_dir/$1"
}

# install

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

      read -r _a

      if [ "$_a" = "y" ]; then
        if is_unknown; then
          echo "$distro_is_unknown"
          echo_exit "$package_is_needed"
        fi

        install_combine "$1"

        echo "$package_needed_installed"

        return 0
      fi

      echo_exit "$package_is_needed"
    fi
  fi
}

# remove

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

# upgrade

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

# exec

exec_async_no_std_out() {
  exec "$@" > /dev/null 2>&1 &
}

exec_async_no_std_out_i3wm() {
  i3wm_split_lr
  exec_async_no_std_out "$@"
  i3wm_focus_r
  i3wm_focus_l
}

exec_default() {
  exec "$@" 2> /dev/null
}

exec_default_i3wm() {
  i3wm_split_lr
  exec_default "$@"
  i3wm_focus_r
  i3wm_focus_l
}

exec_combine_async_no_std_out() {
  if is_de_i3wm; then
    exec_async_no_std_out_i3wm "$@"
  else
    exec_async_no_std_out "$@"
  fi
}

exec_combine_default() {
  if is_de_i3wm; then
    exec_default_i3wm "$@"
  else
    exec_default "$@"
  fi
}

# kill

kill_i3wm() {
  i3-msg kill > /dev/null 2>&1
}

kill_combine() {
  if is_de_i3wm; then
    kill_i3wm
  fi
}

# determine

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

determine_de() {
  if [ -n "$XDG_CURRENT_DESKTOP" ]; then
    de="$XDG_CURRENT_DESKTOP"
    return 0
  fi

  if [ -f /etc/X11/xinit/xinitrc.d/50-gnome-session.sh ]; then
    de="gnome"
    return 0
  elif [ -f /etc/X11/xinit/xinitrc.d/50-kde.sh ]; then
    de="kde"
    return 0
  elif [ -f /etc/X11/xinit/xinitrc.d/50-xfce.sh ]; then
    de="xfce"
    return 0
  elif [ -f /etc/X11/xinit/xinitrc.d/50-lxde.sh ]; then
    de="lxde"
    return 0
  elif [ -f /etc/X11/xinit/xinitrc.d/50-i3.sh ]; then
    de="i3wm"
    return 0
  fi

  if [ -f /usr/share/xsessions/gnome.desktop ]; then
    de="gnome"
    return 0
  elif [ -f /usr/share/xsessions/kde.plasma.desktop ]; then
    de="kdeplasma"
    return 0
  elif [ -f /usr/share/xsessions/xfce.desktop ]; then
    de="xfce"
    return 0
  elif [ -f /usr/share/xsessions/lxde.desktop ]; then
    de="lxde"
    return 0
  elif [ -f /usr/share/xsessions/i3.desktop ]; then
    de="i3wm"
    return 0
  fi

  de="unknown"
}

# i3wm

i3wm_split_lr() {
  i3-msg split h > /dev/null 2>&1
}

i3wm_focus_r() {
  i3-msg focus right > /dev/null 2>&1
}

i3wm_focus_l() {
  i3-msg focus left > /dev/null 2>&1
}

determine_distro
determine_de
umar "$@"
