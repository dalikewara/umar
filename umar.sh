#!/bin/sh

# LAST COUNTER FOR FUNCTION VARIABLE = 32

version="v2.6.0"
pid=$$
distro=""
de=""
target_name="umar"
typing_speed=0.005
http_header="X-HELLO:X-WORLD"

config_dir="$HOME/.umar"
config_run_list_filepath="$config_dir/run-list.cfg"
config_ai_filepath="$config_dir/ai.cfg"
config_tmp_value_filepath="$config_dir/tmp_value.cfg"
config_macbook_audio_driver1_dir="$config_dir/macbook/audio"
config_macbook_audio_driver1_installation_script_name="install.cirrus.driver.sh"
config_macbook_camera_driver1_dir="$config_dir/macbook/camera1"
config_macbook_camera_driver2_dir="$config_dir/macbook/camera2"
config_datagrip_dir="$config_dir/datagrip"
config_go_dir="$config_dir/go"
config_goland_dir="$config_dir/goland"
config_idea_dir="$config_dir/idea"
config_postman_dir="$config_dir/postman"
config_pycharm_dir="$config_dir/pycharm"
config_rustrover_dir="$config_dir/rustrover"
config_webstorm_dir="$config_dir/webstorm"
config_nodejs_dir="$config_dir/nodejs"
config_pyenv_dir="$HOME/.pyenv"
config_config_dir="$HOME/.config"
config_i3wm_dir="$config_config_dir/i3"
config_i3wm_filepath="$config_i3wm_dir/config"
config_i3wm_system_filepath="/etc/i3/config"
config_i3status_dir="$config_config_dir/i3status"
config_i3status_filepath="$config_i3status_dir/config"
config_i3status_system_filepath="/etc/i3status.conf"
config_polybar_dir="$config_config_dir/polybar"
config_polybar_filepath="$config_polybar_dir/config.ini"
config_polybar_system_filepath="/etc/polybar/config.ini"
config_polybarlaunch_filepath="$config_polybar_dir/launch.sh"
config_xfce4_dir="$config_config_dir/xfce4"
config_xfce4_xfconf_dir="$config_xfce4_dir/xfconf"
config_xfce4_xfconf_xfce_perchannel_xml_dir="$config_xfce4_dir/xfce-perchannel-xml"
config_xfce4_filepath="$config_xfce4_xfconf_xfce_perchannel_xml_dir/xfce4-terminal.xml"
config_xfce4launch_filepath="$config_xfce4_xfconf_xfce_perchannel_xml_dir/xfce4-terminal-launch.sh"
bash_profile_filepath="$HOME/.bash_profile"
bashrc_filepath="$HOME/.bashrc"
profile_filepath="$HOME/.profile"
zshrc_filepath="$HOME/.zshrc"
xinitrc_filepath="$HOME/.xinitrc"
xinitrc_system_filepath="/etc/X11/xinit/xinitrc"
user_package_dir="/usr/local/bin"
install_dir="/usr/local/bin"
script_name="umar.sh"
macbook_platform_smc_dir="/sys/devices/platform/applesmc.768"
macbook_platform_fan_min_filepath="$macbook_platform_smc_dir/fan1_min"
macbook_platform_fan_max_filepath="$macbook_platform_smc_dir/fan1_max"
macbook_platform_fan_manual_filepath="$macbook_platform_smc_dir/fan1_manual"
macbook_platform_fan_output_filepath="$macbook_platform_smc_dir/fan1_output"
datagrip_version_tar_filename="datagrip-2023.3.3.tar.gz"
datagrip_version_dir_name="DataGrip-2023.3.3"
datagrip_downloaded_filepath="$config_datagrip_dir/$datagrip_version_tar_filename"
datagrip_extracted_dir="$config_datagrip_dir/$datagrip_version_dir_name"
datagrip_script_filepath="$datagrip_extracted_dir/bin/datagrip.sh"
datagrip_chrome_sandbox_filepath="$datagrip_extracted_dir/jbr/lib/chrome-sandbox"
datagrip_installed_filepath="/usr/local/bin/datagrip"
go_version_tar_filename="go1.23.2.linux-amd64.tar.gz"
go_dir="$HOME/go"
go_src_dir="$go_dir/src"
go_pkg_dir="$go_dir/pkg"
go_bin_dir="$go_dir/bin"
go_version_dir_name="go1.23.2"
go_downloaded_filepath="$config_go_dir/$go_version_tar_filename"
go_extracted_dir="$config_go_dir/$go_version_dir_name"
go_extracted_dir_path="$config_go_dir/go"
go_installed_filepath="/usr/local/go"
go_installed_bin_dir="/usr/local/go/bin"
goland_version_tar_filename="goland-2023.3.2.tar.gz"
goland_version_dir_name="GoLand-2023.3.2"
goland_downloaded_filepath="$config_goland_dir/$goland_version_tar_filename"
goland_extracted_dir="$config_goland_dir/$goland_version_dir_name"
goland_script_filepath="$goland_extracted_dir/bin/goland.sh"
goland_chrome_sandbox_filepath="$goland_extracted_dir/jbr/lib/chrome-sandbox"
goland_installed_filepath="/usr/local/bin/goland"
idea_version_tar_filename="ideaIU-2023.3.2.tar.gz"
idea_version_dir_name="idea-IU-233.13135.103"
idea_downloaded_filepath="$config_idea_dir/$idea_version_tar_filename"
idea_extracted_dir="$config_idea_dir/$idea_version_dir_name"
idea_script_filepath="$idea_extracted_dir/bin/idea.sh"
idea_chrome_sandbox_filepath="$idea_extracted_dir/jbr/lib/chrome-sandbox"
idea_installed_filepath="/usr/local/bin/idea"
postman_version_tar_filename="postman.tar.gz"
postman_version_dir_name="Postman"
postman_downloaded_filepath="$config_postman_dir/$postman_version_tar_filename"
postman_script_filepath="$config_postman_dir/$postman_version_dir_name/app/Postman"
postman_installed_filepath="/usr/local/bin/postman"
pycharm_version_tar_filename="pycharm-professional-2023.3.2.tar.gz"
pycharm_version_dir_name="pycharm-2023.3.2"
pycharm_downloaded_filepath="$config_pycharm_dir/$pycharm_version_tar_filename"
pycharm_extracted_dir="$config_pycharm_dir/$pycharm_version_dir_name"
pycharm_script_filepath="$pycharm_extracted_dir/bin/pycharm.sh"
pycharm_chrome_sandbox_filepath="$pycharm_extracted_dir/jbr/lib/chrome-sandbox"
pycharm_installed_filepath="/usr/local/bin/pycharm"
rustrover_version_tar_filename="RustRover-2024.1.tar.gz"
rustrover_version_dir_name="RustRover-2024.1"
rustrover_downloaded_filepath="$config_rustrover_dir/$rustrover_version_tar_filename"
rustrover_extracted_dir="$config_rustrover_dir/$rustrover_version_dir_name"
rustrover_script_filepath="$rustrover_extracted_dir/bin/rustrover.sh"
rustrover_chrome_sandbox_filepath="$rustrover_extracted_dir/jbr/lib/chrome-sandbox"
rustrover_installed_filepath="/usr/local/bin/rustrover"
webstorm_version_tar_filename="WebStorm-2024.1.3.tar.gz"
webstorm_version_dir_name="WebStorm-241.17011.90"
webstorm_downloaded_filepath="$config_webstorm_dir/$webstorm_version_tar_filename"
webstorm_extracted_dir="$config_webstorm_dir/$webstorm_version_dir_name"
webstorm_script_filepath="$webstorm_extracted_dir/bin/webstorm.sh"
webstorm_chrome_sandbox_filepath="$webstorm_extracted_dir/jbr/lib/chrome-sandbox"
webstorm_installed_filepath="/usr/local/bin/webstorm"
nodejs_version_tar_filename="node-v21.6.1-linux-x64.tar.xz"
nodejs_dir="$HOME/nodejs"
nodejs_npm_global_dir="$HOME/.npm-global"
nodejs_npm_global_bin_dir="$nodejs_npm_global_dir/bin"
nodejs_version_dir_name="v21.6.1"
nodejs_downloaded_filepath="$config_nodejs_dir/$nodejs_version_tar_filename"
nodejs_extracted_dir="$config_nodejs_dir/$nodejs_version_dir_name"
nodejs_extracted_dir_path="$config_nodejs_dir/node-v21.6.1-linux-x64"
nodejs_installed_filepath="/usr/local/lib/nodejs"
nodejs_installed_version_filepath="$nodejs_installed_filepath/node-v21.6.1-linux-x64"
nodejs_installed_version_bin_dir="$nodejs_installed_version_filepath/bin"
ssh_keygen_dir="$HOME/.ssh/id_ed25519"
ssh_keygen_filepath="$HOME/.ssh/id_ed25519.pub"

color_green='\033[0;32m'
color_cyan='\033[0;36m'
color_blue='\033[0;34m'
color_red='\033[0;31m'
color_yellow='\033[1;33m'
color_reset='\033[0m'

repo_url="https://raw.githubusercontent.com/dalikewara/umar/master"
search_url="https://www.google.com/search?q="
generative_ai_url="https://generativelanguage.googleapis.com/v1beta/models"
macbook_audio_driver1_url="https://github.com/davidjo/snd_hda_macbookpro.git"
macbook_camera_driver1_url="https://github.com/patjak/facetimehd-firmware.git"
macbook_camera_driver2_url="https://github.com/patjak/facetimehd.git"
datagrip_download_url="https://download.jetbrains.com/datagrip/$datagrip_version_tar_filename"
go_download_url="https://go.dev/dl/$go_version_tar_filename"
goland_download_url="https://download.jetbrains.com/go/$goland_version_tar_filename"
idea_download_url="https://download-cdn.jetbrains.com/idea/$idea_version_tar_filename"
postman_download_url="https://dl.pstmn.io/download/latest/linux_64"
pycharm_download_url="https://download.jetbrains.com/python/$pycharm_version_tar_filename"
rustrover_download_url="https://download.jetbrains.com/rustrover/$rustrover_version_tar_filename"
webstorm_download_url="https://download.jetbrains.com/webstorm/$webstorm_version_tar_filename"
nodejs_download_url="https://nodejs.org/dist/$nodejs_version_dir_name/$nodejs_version_tar_filename"
rust_download_url="https://sh.rustup.rs"
pyenv_download_url="https://pyenv.run"

# shellcheck disable=SC2034
gemini_model_1="gemini-1.0-pro"
# shellcheck disable=SC2034
gemini_model_2="gemini-1.5-pro"
# shellcheck disable=SC2034
gemini_model_3="gemini-1.5-flash"

ai_type=""
ai_model=""
ai_api_key=""
ai_url=""

umar() {
  if is_file_exist "/etc/os-release"; then
    distro=$(awk -F= '/^ID=/ { print $2 }' /etc/os-release | tr -d '"')
  fi

  case "$distro" in
    arch*) distro="arch" ;;
    debian*) distro="debian" ;;
    ubuntu*) distro="ubuntu" ;;
    fedora*) distro="fedora" ;;
    centos*) distro="centos" ;;
    manjaro*) distro="manjaro" ;;
    *) distro="unknown" ;;
  esac

  if [ -n "$XDG_CURRENT_DESKTOP" ]; then
    de="$XDG_CURRENT_DESKTOP"
  elif is_file_exist "/etc/X11/xinit/xinitrc.d/50-gnome-session.sh"; then
    de="gnome"
  elif is_file_exist "/etc/X11/xinit/xinitrc.d/50-kde.sh"; then
    de="kde"
  elif is_file_exist "/etc/X11/xinit/xinitrc.d/50-xfce.sh"; then
    de="xfce"
  elif is_file_exist "/etc/X11/xinit/xinitrc.d/50-lxde.sh"; then
    de="lxde"
  elif is_file_exist "/etc/X11/xinit/xinitrc.d/50-i3.sh"; then
    de="i3wm"
  elif is_file_exist "/usr/share/xsessions/gnome.desktop"; then
    de="gnome"
  elif is_file_exist "/usr/share/xsessions/kde.plasma.desktop"; then
    de="kdeplasma"
  elif is_file_exist "/usr/share/xsessions/xfce.desktop"; then
    de="xfce"
  elif is_file_exist "/usr/share/xsessions/lxde.desktop"; then
    de="lxde"
  elif is_file_exist "/usr/share/xsessions/i3.desktop"; then
    de="i3wm"
  fi

  if is_file_exist "$config_ai_filepath"; then
    ai_type=$(read_file_content_line "1" "$config_ai_filepath")
    ai_model=$(read_file_content_line "2" "$config_ai_filepath")
    ai_api_key=$(read_file_content_line "3" "$config_ai_filepath")

    if is_ai_google; then
      ai_url="$generative_ai_url"
    fi
  fi

  create_dir "$config_dir"
  create_file "$config_run_list_filepath"
  create_file "$config_ai_filepath"
  check_requirements "sh"

  if is_no_argument "$@"; then
    printout "
I am Umar ($version), your Linux assistant. I can help you with the common tasks listed below. \
I will continue to be updated indefinitely, as my creator may need to add new features, update my logic, fix issues, \
or make other changes. I may get smarter every day. I can also use AI, but you need to manually set up the configuration first.
"

    printout "\
getsmarter:Upgrade me to the latest version
version:Show my current version
reveal:Reveal my source code
window:Open my command window. ${color_yellow}**You may create a keyboard shortcut for this command to open my command window directly**${color_reset}
--------------:--------------------------
run:Run custom command(s)
listrun:List registered custom command(s)
setrun:Set new custom command
removerun:Remove custom command(s)
changerundesc:Change custom command description
changeruncommand:Change custom command execution command
--------------:--------------------------
prompt:Prompt anything to AI
chat:Start a new chat session with AI
setai:Set new AI configuration
showai:Show AI information
changeaitype:Change AI type
changeaimodel:Change AI model
changeaiapikey:Change AI API key
--------------:--------------------------
open:Open package(s)
kill:Kill package(s) process
search:Search for the given keyword(s) using a terminal browser
install:Install package(s)
remove:Remove package(s)
upgrade:Upgrade package(s)
--------------:--------------------------
audio:Open audio setting
audiocard:List audio cards
playaudio:Play audio(s)
--------------:--------------------------
showimage:Show image(s)
--------------:--------------------------
playvideo:Play video(s)
--------------:--------------------------
output:Show available output device(s)
resolution:Set screen resolution. ${color_blue}**Argument 1**${color_reset} is the output device name and ${color_blue}**Argument 2**${color_reset} is the screen resolution
brightness:Set screen brightness. ${color_blue}**Argument 1**${color_reset} is the output device name and ${color_blue}**Argument 2**${color_reset} is the brightness value
--------------:--------------------------
touchpad:Configure touchpad device
--------------:--------------------------
wifi:Scan or connect to a Wi-Fi using iwd. ${color_blue}**Argument 1**${color_reset} is the device name. The next arguments are the Wi-Fi SSID and any required parameters
testhttp:Test and benchmark HTTP URL -> \`${color_cyan}**-c** ${color_blue}**NUM** ${color_cyan}**-r** ${color_blue}**NUM** ${color_cyan}**-t** \
${color_blue}**SECONDS** ${color_cyan}**-header** ${color_blue}**TEXT** ${color_cyan}**-userAgent** ${color_blue}**TEXT** ${color_cyan}**-contentType** \
${color_blue}**TEXT** ${color_cyan}**-u** ${color_blue}**URL**${color_reset}\`
--------------:--------------------------
setupfresharch:Set up a fresh Arch Linux installation
setupfresharchi3wm:Install and set up i3-wm on a fresh Arch Linux installation
setupdeveloper:Install some developer tools
--------------:--------------------------
macbookaudio:Configure audio for Intel Macbook. ${color_yellow}**Tested on MBP 2017**${color_reset}
macbookcamera:Configure camera for Intel Macbook. ${color_yellow}**Tested on MBP 2017**${color_reset}
macbookfan:Set fan speed for Intel Macbook. ${color_yellow}**Tested on MBP 2017**${color_reset}. ${color_blue}**Argument 1**${color_reset} is the fan speed RPM
" | while IFS=: read -r _1_name _1_description; do
      printf "${color_green}%-17s ${color_reset}%b\n" "$_1_name" "$(printout "$_1_description" | markdown_parse)"
    done

    printout "$(printout "${color_red}**BE CAREFUL ABOUT WHAT YOU TYPE, MAKE SURE THERE IS NOTHING THAT CAN BREAK YOUR SYSTEM**${color_reset}" | markdown_parse)\n"
    return 0
  fi

  _1_command="command_$1"

  shift
  $_1_command "$@" || printout "Sorry, I can't understand your command"
}

# ---------------------------------------------------------------------------------------------------------------------
#
# `command`
# Provides available Umar's command(s)
#
# ---------------------------------------------------------------------------------------------------------------------

command_setupfresharch() {
  if ! is_arch; then
    printout_exit "You're not using Arch Linux!"
  fi

  printout_markdown "${color_yellow}**THIS WILL SET UP A FRESH ARCH LINUX INSTALLATION. ${color_red}WARNING!!! THIS WILL REPLACE YOUR EXISTING CONFIGURATION!!! DON'T DO THIS IF YOU'RE NOT AWARE!!!**${color_reset}"

  printout_blank_line

  printout_no_enter "Are you sure to continue this process [N/y] "

  _32_confirmation=$(read_input)

  if ! is_equal "$_32_confirmation" "y"; then
    printout_exit "Aborted!"
  fi

  install_package "git" "vim" "curl" "htop" "neofetch" "bash" "zsh" "chromium" "make" "xorg-xrandr" "libinput" "xf86-input-libinput" \
  "xorg-server" "xorg-xinput" "polkit" "pulsemixer" "xfce4-terminal" "iwd" "amd-ucode" "intel-ucode" "lm_sensors" "bc" "base-devel" \
  "linux-lts-headers" "pipewire" "pipewire-pulse" "wget" "xsensors" "unzip"

  if ! is_file_exist "$ssh_keygen_filepath"; then
    ssh-keygen -t ed25519
    eval "$(ssh-agent -s)"
    ssh-add "$ssh_keygen_dir"
  fi

  printout_no_enter "Enter your git user.email...  "

  _32_git_email=$(read_input)

  printout_no_enter "Enter your git user.name...  "

  _32_git_name=$(read_input)

  git config --global user.email "$_32_git_email"
  git config --global user.name "$_32_git_name"

  sudo ln -sf /dev/null /etc/udev/rules.d/80-net-setup-link.rules

  sudo sed -i -E 's/GRUB_TIMEOUT=([0-9]+)/GRUB_TIMEOUT=0/g' /etc/default/grub
  sudo grub-mkconfig -o /boot/grub/grub.cfg
  sudo sensors-detect
  sudo sensors
  sudo pwmconfig
}

command_setupfresharchi3wm() {
  if ! is_arch; then
    printout_exit "You're not using Arch Linux!"
  fi

  printout_markdown "${color_yellow}**THIS WILL INSTALL & SET UP I3WM ON A FRESH ARCH LINUX INSTALLATION. ${color_red}WARNING!!! THIS WILL REPLACE YOUR EXISTING WINDOW MANAGER OR DESKTOP ENVIRONMENT!!! DON'T DO THIS IF YOU'RE NOT AWARE!!!**${color_reset}"

  printout_blank_line

  printout_no_enter "Are you sure to continue this process [N/y] "

  _31_confirmation=$(read_input)

  if ! is_equal "$_31_confirmation" "y"; then
    printout_exit "Aborted!"
  fi

  install_package "i3" "xorg" "xorg-xinit" "xfce4-terminal" "polybar" "pavucontrol"

  printout "Configuring..."

  if ! is_file_exist "$xinitrc_filepath"; then
    cp "$xinitrc_system_filepath" "$xinitrc_filepath"
  fi

  if ! grep -q "exec i3" "$xinitrc_filepath"; then
    echo "exec i3" >> "$xinitrc_filepath"
  fi

  if ! grep -q "
if [ -z \"\$DISPLAY\" ] && [ \"\$XDG_VTNR\" = 1 ]; then
  exec startx
fi
" "$xinitrc_filepath"; then
    echo "
if [ -z \"\$DISPLAY\" ] && [ \"\$XDG_VTNR\" = 1 ]; then
  exec startx
fi
" >> "$xinitrc_filepath"
  fi

  create_dir "$config_config_dir"
  create_dir "$config_i3wm_dir"
  create_dir "$config_i3status_dir"
  create_dir "$config_polybar_dir"

  if ! is_file_exist "$config_i3wm_filepath"; then
    cp "$config_i3wm_system_filepath" "$config_i3wm_filepath"
  fi

  if ! is_file_exist "$config_i3status_filepath"; then
    cp "$config_i3status_system_filepath" "$config_i3status_filepath"
  fi

  if ! is_file_exist "$config_polybar_filepath"; then
    cp "$config_polybar_system_filepath" "$config_polybar_filepath"
  fi

   if ! is_file_exist "$config_polybarlaunch_filepath"; then
    create_file "$config_polybarlaunch_filepath"
    echo "
#!/usr/bin/env bash

killall -q polybar
echo \"---\" | tee -a /tmp/polybar1.log
polybar bar 2>&1 | tee -a /tmp/polybar1.log & disown
" > "$config_polybarlaunch_filepath"
    chmod +x "$config_polybarlaunch_filepath"
  fi

  sed -i '/^bar {$/,/^}/s/^/#/' "$config_i3wm_filepath"

  if ! grep -q "bindsym \$mod+Return exec xfce4-terminal" "$config_i3wm_filepath"; then
    echo "bindsym \$mod+Return exec xfce4-terminal" >> "$config_i3wm_filepath"
  fi

  if ! grep -q "default_border pixel 0px" "$config_i3wm_filepath"; then
    echo "default_border pixel 0px" >> "$config_i3wm_filepath"
  fi

  if ! grep -q "gaps inner 0px" "$config_i3wm_filepath"; then
    echo "gaps inner 0px" >> "$config_i3wm_filepath"
  fi

  if ! grep -q "gaps outer 0px" "$config_i3wm_filepath"; then
    echo "gaps outer 0px" >> "$config_i3wm_filepath"
  fi

  if ! grep -q "exec_always --no-startup-id $config_polybarlaunch_filepath" "$config_i3wm_filepath"; then
    echo "exec_always --no-startup-id $config_polybarlaunch_filepath" >> "$config_i3wm_filepath"
  fi

  sed -i 's/background = #282A2E/background = #000000/' "$config_polybar_filepath"
  sed -i 's/background-alt = #373B41/background-alt = #000000/' "$config_polybar_filepath"
  sed -i 's/[bar\/example]/[bar\/bar]/' "$config_polybar_filepath"
  sed -i 's/height = 24pt/height = 18pt/' "$config_polybar_filepath"
  sed -i 's/radius = 6/radius = 0/' "$config_polybar_filepath"
  sed -i 's/line-size = 3pt/line-size = 1pt/' "$config_polybar_filepath"
  sed -i 's/modules-right = filesystem pulseaudio xkeyboard memory cpu wlan eth date/modules-right = filesystem pulseaudio xkeyboard memory cpu battery wlan eth date/' "$config_polybar_filepath"
  sed -i 's/label = %title:0:60:...%/label = %title:0:40:...%\nlabel-maxlen = 40/' "$config_polybar_filepath"
  sed -i 's/format-volume-prefix = "VOL "/format-volume-prefix = "AV"/' "$config_polybar_filepath"
  sed -i 's/format-prefix = "RAM "/format-prefix = "R"/' "$config_polybar_filepath"
  sed -i 's/format-prefix = "CPU "/format-prefix = "C"/' "$config_polybar_filepath"
  sed -i 's/label-connected = %{F#F0C674}%ifname%%{F-} %essid% %local_ip%/label-connected = %{F#F0C674}%ifname%%{F-} %essid:0:10:...% %local_ip%\nlabel-maxlen = 40/' "$config_polybar_filepath"
  sed -i 's/label-connected = %{F#F0C674}%ifname%%{F-} %local_ip%/label-connected = %{F#F0C674}%ifname%%{F-} %local_ip%\nlabel-maxlen = 40/' "$config_polybar_filepath"
  sed -i 's/date = %H:%M/date = %Y-%m-%d %H:%M:%S/' "$config_polybar_filepath"

  if ! grep -q "[module/battery]" "$config_polybar_filepath"; then
    echo "
[module/battery]
type = internal/battery
;format_prefix = \"B\"
full-at = 99
low-at = 5
battery = BAT0
adapter = ADP1
poll-interval = 5
time-format = \"%H:%M\"
format-charging-prefix = \"BC\"
format-charging-prefix-foreground = \${colors.primary}
format-discharging-prefix = \"BD\"
format-discharging-prefix-foreground = \${colors.primary}
format-full = \"B_FULL\"
format-full-foreground = \${colors.primary}
format-low-prefix = \"BL\"
format-low-prefix-foreground = \${colors.primary}
label-charging = %percentage%%
label-discharging = %percentage%%
label-full = %percentage%%
label-low = %percentage%%
" >> "$config_polybar_filepath"
  fi

  create_dir "$config_xfce4_dir"
  create_dir "$config_xfce4_xfconf_dir"
  create_dir "$config_xfce4_xfconf_xfce_perchannel_xml_dir"

  if ! is_file_exist "$config_xfce4_filepath"; then
    create_file "$config_xfce4_filepath"
  fi

  if ! is_file_exist "$config_xfce4launch_filepath"; then
    create_file "$config_xfce4launch_filepath"
    chmod +x "$config_xfce4launch_filepath"
  fi

  echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>

<channel name=\"xfce4-terminal\" version=\"1.0\">
  <property name=\"font-use-system\" type=\"bool\" value=\"false\"/>
  <property name=\"font-allow-bold\" type=\"bool\" value=\"true\"/>
  <property name=\"misc-copy-on-select\" type=\"bool\" value=\"false\"/>
  <property name=\"misc-menubar-default\" type=\"bool\" value=\"false\"/>
  <property name=\"misc-borders-default\" type=\"bool\" value=\"true\"/>
  <property name=\"misc-slim-tabs\" type=\"bool\" value=\"false\"/>
  <property name=\"scrolling-bar\" type=\"string\" value=\"TERMINAL_SCROLLBAR_NONE\"/>
  <property name=\"cell-width-scale\" type=\"double\" value=\"1\"/>
  <property name=\"cell-height-scale\" type=\"double\" value=\"1\"/>
  <property name=\"misc-cursor-blinks\" type=\"bool\" value=\"true\"/>
  <property name=\"misc-cursor-shape\" type=\"string\" value=\"TERMINAL_CURSOR_SHAPE_IBEAM\"/>
</channel>
" > "$config_xfce4_filepath"

  echo "#!/bin/sh
xfconf-query -c xfce4-terminal -p /misc-show-unsafe-paste-dialog -n -t bool -s false
xfconf-query -c xfce4-terminal -p /misc-confirm-close -n -t bool -s false
" > "$config_xfce4launch_filepath"

  if ! grep -q "exec $config_xfce4launch_filepath" "$xinitrc_filepath"; then
    echo "exec $config_xfce4launch_filepath" >> "$xinitrc_filepath"
  fi
}

command_setupdeveloper() {
  printout_markdown "${color_yellow}**THIS WILL INSTALL DEVELOPER TOOLS. ${color_red}WARNING!!! THIS WILL REPLACE YOUR EXISTING PACKAGES!!! DON'T DO THIS IF YOU'RE NOT AWARE!!!**${color_reset}"

  printout_blank_line

  printout_no_enter "Are you sure to continue this process [N/y] "

  _30_confirmation=$(read_input)

  if ! is_equal "$_30_confirmation" "y"; then
    printout_exit "Aborted!"
  fi

  check_requirements "tar" "wget" "gzip"

  install_package "git" "vim" "curl" "meld" "htop" "neofetch" "bash" "zsh" "docker" "docker-compose" "make"

  if ! is_file_exist "$ssh_keygen_filepath"; then
    ssh-keygen -t ed25519
    eval "$(ssh-agent -s)"
    ssh-add "$ssh_keygen_dir"
  fi

  if ! is_dir_exist "$datagrip_extracted_dir"; then
    create_dir "$config_datagrip_dir"
    wget -c --timeout=10 --tries=1 -O "$datagrip_downloaded_filepath" "$datagrip_download_url" &
  fi

  if ! is_dir_exist "$go_extracted_dir"; then
    create_dir "$config_go_dir"
    wget -c --timeout=10 --tries=1 -O "$go_downloaded_filepath" "$go_download_url" &
  fi

  if ! is_dir_exist "$goland_extracted_dir"; then
    create_dir "$config_goland_dir"
    wget -c --timeout=10 --tries=1 -O "$goland_downloaded_filepath" "$goland_download_url" &
  fi

  if ! is_dir_exist "$idea_extracted_dir"; then
    create_dir "$config_idea_dir"
    wget -c --timeout=10 --tries=1 -O "$idea_downloaded_filepath" "$idea_download_url" &
  fi

  create_dir "$config_postman_dir"
  wget -c --timeout=10 --tries=1 -O "$postman_downloaded_filepath" "$postman_download_url" &

  if ! is_dir_exist "$pycharm_extracted_dir"; then
    create_dir "$config_pycharm_dir"
    wget -c --timeout=10 --tries=1 -O "$pycharm_downloaded_filepath" "$pycharm_download_url" &
  fi

  if ! is_dir_exist "$rustrover_extracted_dir"; then
    create_dir "$config_rustrover_dir"
    wget -c --timeout=10 --tries=1 -O "$rustrover_downloaded_filepath" "$rustrover_download_url" &
  fi

  if ! is_dir_exist "$webstorm_extracted_dir"; then
    create_dir "$config_webstorm_dir"
    wget -c --timeout=10 --tries=1 -O "$webstorm_downloaded_filepath" "$webstorm_download_url" &
  fi

  if ! is_dir_exist "$nodejs_extracted_dir"; then
    create_dir "$config_nodejs_dir"
    wget -c --timeout=10 --tries=1 -O "$nodejs_downloaded_filepath" "$nodejs_download_url" &
  fi

  wait

  if is_file_exist "$datagrip_downloaded_filepath"; then
    tar -v -C "$config_datagrip_dir" -xzf "$datagrip_downloaded_filepath" &
  fi

  if is_file_exist "$go_downloaded_filepath"; then
    tar -v -C "$config_go_dir" -xzf "$go_downloaded_filepath" &
  fi

  if is_file_exist "$goland_downloaded_filepath"; then
    tar -v -C "$config_goland_dir" -xzf "$goland_downloaded_filepath" &
  fi

  if is_file_exist "$idea_downloaded_filepath"; then
    tar -v -C "$config_idea_dir" -xzf "$idea_downloaded_filepath" &
  fi

  if is_file_exist "$postman_downloaded_filepath"; then
    tar -v -C "$config_postman_dir" -xzf "$postman_downloaded_filepath" &
  fi

  if is_file_exist "$pycharm_downloaded_filepath"; then
    tar -v -C "$config_pycharm_dir" -xzf "$pycharm_downloaded_filepath" &
  fi

  if is_file_exist "$rustrover_downloaded_filepath"; then
    tar -v -C "$config_rustrover_dir" -xzf "$rustrover_downloaded_filepath" &
  fi

  if is_file_exist "$webstorm_downloaded_filepath"; then
    tar -v -C "$config_webstorm_dir" -xzf "$webstorm_downloaded_filepath" &
  fi

  if is_file_exist "$nodejs_downloaded_filepath"; then
    tar -v -C "$config_nodejs_dir" -xJvf "$nodejs_downloaded_filepath" &
  fi

  wait

  curl --proto '=https' --tlsv1.2 -sSf "$rust_download_url" | sh || true
  curl "$pyenv_download_url" | bash || true

  if is_file_exist "$go_downloaded_filepath"; then
    mv "$go_extracted_dir_path" "$go_extracted_dir"
  fi

  if is_file_exist "$nodejs_downloaded_filepath"; then
    mv "$nodejs_extracted_dir_path" "$nodejs_extracted_dir"
  fi

  sudo chmod 4755 "$datagrip_chrome_sandbox_filepath"
  sudo chmod 4755 "$datagrip_extracted_dir"
  sudo ln -sf "$datagrip_script_filepath" "$datagrip_installed_filepath" || true
  rm -rf "$datagrip_downloaded_filepath"
  mkdir "$go_dir" > /dev/null 2>&1 || true
  mkdir "$go_src_dir" > /dev/null 2>&1 || true
  mkdir "$go_pkg_dir" > /dev/null 2>&1 || true
  mkdir "$go_bin_dir" > /dev/null 2>&1 || true
  sudo cp -rf "$go_extracted_dir" "$go_installed_filepath"
  rm -rf "$go_downloaded_filepath"
  sudo chmod 4755 "$goland_chrome_sandbox_filepath"
  sudo chmod 4755 "$goland_extracted_dir"
  sudo ln -sf "$goland_script_filepath" "$goland_installed_filepath" || true
  rm -rf "$goland_downloaded_filepath"
  sudo chmod 4755 "$idea_chrome_sandbox_filepath"
  sudo chmod 4755 "$idea_extracted_dir"
  sudo ln -sf "$idea_script_filepath" "$idea_installed_filepath" || true
  rm -rf "$idea_downloaded_filepath"
  sudo ln -sf "$postman_script_filepath" "$postman_installed_filepath" || true
  rm -rf "$postman_downloaded_filepath"
  sudo chmod 4755 "$pycharm_chrome_sandbox_filepath"
  sudo chmod 4755 "$pycharm_extracted_dir"
  sudo ln -sf "$pycharm_script_filepath" "$pycharm_installed_filepath" || true
  rm -rf "$pycharm_downloaded_filepath"
  sudo chmod 4755 "$rustrover_chrome_sandbox_filepath"
  sudo chmod 4755 "$rustrover_extracted_dir"
  sudo ln -sf "$rustrover_script_filepath" "$rustrover_installed_filepath" || true
  rm -rf "$rustrover_downloaded_filepath"
  sudo chmod 4755 "$webstorm_chrome_sandbox_filepath"
  sudo chmod 4755 "$webstorm_extracted_dir"
  sudo ln -sf "$webstorm_script_filepath" "$webstorm_installed_filepath" || true
  rm -rf "$webstorm_downloaded_filepath"
  mkdir "$nodejs_dir" > /dev/null 2>&1 || true
  mkdir "$nodejs_npm_global_dir" > /dev/null 2>&1 || true
  sudo mkdir -p "$nodejs_installed_filepath"
  sudo cp -rf "$nodejs_extracted_dir" "$nodejs_installed_version_filepath"
  rm -rf "$nodejs_downloaded_filepath"

  if is_file_exist "$bash_profile_filepath"; then
    if ! grep -q "export PATH=\$PATH:$go_installed_bin_dir" "$bash_profile_filepath"; then
      echo "export PATH=\$PATH:$go_installed_bin_dir" >> "$bash_profile_filepath"
    fi

    if ! grep -q "export GOPATH=$go_dir" "$bash_profile_filepath"; then
      echo "export GOPATH=$go_dir" >> "$bash_profile_filepath"
    fi

    if ! grep -q "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" "$bash_profile_filepath"; then
      echo "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" >> "$bash_profile_filepath"
    fi

    if ! grep -q "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" "$bash_profile_filepath"; then
      echo "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" >> "$bash_profile_filepath"
    fi

    if ! grep -q "export PATH=$nodejs_installed_version_bin_dir:\$PATH" "$bash_profile_filepath"; then
      echo "export PATH=$nodejs_installed_version_bin_dir:\$PATH" >> "$bash_profile_filepath"
    fi

    if ! grep -q "export PATH=$nodejs_npm_global_bin_dir:\$PATH" "$bash_profile_filepath"; then
      echo "export PATH=$nodejs_npm_global_bin_dir:\$PATH" >> "$bash_profile_filepath"
    fi

    if ! grep -q "export PYENV_ROOT=$config_pyenv_dir" "$bash_profile_filepath"; then
      echo "export PYENV_ROOT=$config_pyenv_dir" >> "$bash_profile_filepath"
    fi

    if ! grep -q "[[ -d \$PYENV_ROOT/bin ]] && export PATH=\$PYENV_ROOT/bin:\$PATH" "$bash_profile_filepath"; then
      echo "[[ -d \$PYENV_ROOT/bin ]] && export PATH=\$PYENV_ROOT/bin:\$PATH" >> "$bash_profile_filepath"
    fi
  fi

  if is_file_exist "$bashrc_filepath"; then
    if ! grep -q "export PATH=\$PATH:$go_installed_bin_dir" "$bashrc_filepath"; then
      echo "export PATH=\$PATH:$go_installed_bin_dir" >> "$bashrc_filepath"
    fi

    if ! grep -q "export GOPATH=$go_dir" "$bashrc_filepath"; then
      echo "export GOPATH=$go_dir" >> "$bashrc_filepath"
    fi

    if ! grep -q "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" "$bashrc_filepath"; then
      echo "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" >> "$bashrc_filepath"
    fi

    if ! grep -q "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" "$bashrc_filepath"; then
      echo "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" >> "$bashrc_filepath"
    fi

    if ! grep -q "export PATH=$nodejs_installed_version_bin_dir:\$PATH" "$bashrc_filepath"; then
      echo "export PATH=$nodejs_installed_version_bin_dir:\$PATH" >> "$bashrc_filepath"
    fi

    if ! grep -q "export PATH=$nodejs_npm_global_bin_dir:\$PATH" "$bashrc_filepath"; then
      echo "export PATH=$nodejs_npm_global_bin_dir:\$PATH" >> "$bashrc_filepath"
    fi

    if ! grep -q "export PYENV_ROOT=$config_pyenv_dir" "$bashrc_filepath"; then
      echo "export PYENV_ROOT=$config_pyenv_dir" >> "$bashrc_filepath"
    fi

    if ! grep -q "command -v pyenv >/dev/null || export PATH=\$PYENV_ROOT/bin:\$PATH" "$bashrc_filepath"; then
      echo "command -v pyenv >/dev/null || export PATH=\$PYENV_ROOT/bin:\$PATH" >> "$bashrc_filepath"
    fi
  fi

  if is_file_exist "$profile_filepath"; then
    if ! grep -q "export PATH=\$PATH:$go_installed_bin_dir" "$profile_filepath"; then
      echo "export PATH=\$PATH:$go_installed_bin_dir" >> "$profile_filepath"
    fi

    if ! grep -q "export GOPATH=$go_dir" "$profile_filepath"; then
      echo "export GOPATH=$go_dir" >> "$profile_filepath"
    fi

    if ! grep -q "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" "$profile_filepath"; then
      echo "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" >> "$profile_filepath"
    fi

    if ! grep -q "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" "$profile_filepath"; then
      echo "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" >> "$profile_filepath"
    fi

    if ! grep -q "export PATH=$nodejs_installed_version_bin_dir:\$PATH" "$profile_filepath"; then
      echo "export PATH=$nodejs_installed_version_bin_dir:\$PATH" >> "$profile_filepath"
    fi

    if ! grep -q "export PATH=$nodejs_npm_global_bin_dir:\$PATH" "$profile_filepath"; then
      echo "export PATH=$nodejs_npm_global_bin_dir:\$PATH" >> "$profile_filepath"
    fi

    if ! grep -q "export PYENV_ROOT=$config_pyenv_dir" "$profile_filepath"; then
      echo "export PYENV_ROOT=$config_pyenv_dir" >> "$profile_filepath"
    fi

    if ! grep -q "command -v pyenv >/dev/null || export PATH=\$PYENV_ROOT/bin:\$PATH" "$profile_filepath"; then
      echo "command -v pyenv >/dev/null || export PATH=\$PYENV_ROOT/bin:\$PATH" >> "$profile_filepath"
    fi
  fi

  if is_file_exist "$zshrc_filepath"; then
    if ! grep -q "export PATH=\$PATH:$go_installed_bin_dir" "$zshrc_filepath"; then
      echo "export PATH=\$PATH:$go_installed_bin_dir" >> "$zshrc_filepath"
    fi

    if ! grep -q "export GOPATH=$go_dir" "$zshrc_filepath"; then
      echo "export GOPATH=$go_dir" >> "$zshrc_filepath"
    fi

    if ! grep -q "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" "$zshrc_filepath"; then
      echo "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" >> "$zshrc_filepath"
    fi

    if ! grep -q "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" "$zshrc_filepath"; then
      echo "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" >> "$zshrc_filepath"
    fi

    if ! grep -q "export PATH=$nodejs_installed_version_bin_dir:\$PATH" "$zshrc_filepath"; then
      echo "export PATH=$nodejs_installed_version_bin_dir:\$PATH" >> "$zshrc_filepath"
    fi

    if ! grep -q "export PATH=$nodejs_npm_global_bin_dir:\$PATH" "$zshrc_filepath"; then
      echo "export PATH=$nodejs_npm_global_bin_dir:\$PATH" >> "$zshrc_filepath"
    fi

    if ! grep -q "export PYENV_ROOT=$config_pyenv_dir" "$zshrc_filepath"; then
      echo "export PYENV_ROOT=$config_pyenv_dir" >> "$zshrc_filepath"
    fi

    if ! grep -q "[[ -d \$PYENV_ROOT/bin ]] && export PATH=\$PYENV_ROOT/bin:\$PATH" "$zshrc_filepath"; then
      echo "[[ -d \$PYENV_ROOT/bin ]] && export PATH=\$PYENV_ROOT/bin:\$PATH" >> "$zshrc_filepath"
    fi
  fi

  npm config set prefix "$nodejs_npm_global_dir" > /dev/null 2>&1 || true
}

command_macbookfan() {
  if is_no_argument "$@"; then
    printout_exit "Current Macbook fan speed is $(read_file_content "$macbook_platform_fan_output_filepath")"
  fi

  _29_min_speed=$(read_file_content "$macbook_platform_fan_min_filepath")

  if [ "$1" -lt "$_29_min_speed" ]; then
    printout_exit "Value under minimum!"
  fi

  _29_max_speed=$(read_file_content "$macbook_platform_fan_max_filepath")

  if [ "$1" -gt "$_29_max_speed" ]; then
    printout_exit "Value above maximum!"
  fi

  printout_markdown "${color_yellow}**This will configure Macbook Fan Speed. If you're not using Macbook device, you SHOULD NOT execute this command**${color_reset}"

  printout_blank_line

  printout_no_enter "Are you sure to continue this process [N/y] "

  _29_confirmation=$(read_input)

  if ! is_equal "$_29_confirmation" "y"; then
    printout_exit "Aborted!"
  fi

  su -c "echo 1 > $macbook_platform_fan_manual_filepath && echo $1 > $macbook_platform_fan_output_filepath"
}

command_macbookcamera() {
  printout_markdown "${color_yellow}**This will configure Macbook Camera. If you're not using Macbook device, you SHOULD NOT execute this command**${color_reset}"

  printout_blank_line

  printout_no_enter "Are you sure to continue this process [N/y] "

  _28_confirmation=$(read_input)

  if ! is_equal "$_28_confirmation" "y"; then
    printout_exit "Aborted!"
  fi

  check_requirements "git" "sudo" "make"

  if ! is_dir_exist "$config_macbook_camera_driver1_dir"; then
    git clone "$macbook_camera_driver1_url" "$config_macbook_camera_driver1_dir"
  fi

  if ! is_dir_exist "$config_macbook_camera_driver2_dir"; then
    git clone "$macbook_camera_driver2_url" "$config_macbook_camera_driver2_dir"
  fi

  cd "$config_macbook_camera_driver1_dir" || printout_exit "Camera driver1 not found!"
  make clean

  make

  sudo make install
  cd "$config_macbook_camera_driver2_dir" || printout_exit "Camera driver2 not found!"
  make clean

  make

  sudo make install
  sudo depmod
  sudo modprobe -r bdc_pci
  sudo modprobe facetimehd

  printout_blank_line

  printout_markdown "${color_yellow}**Camera successfully configured. If it not working, try to reboot your system**${color_reset}"
}

command_macbookaudio() {
  printout_markdown "${color_yellow}**This will configure Macbook Audio. If you're not using Macbook device, you SHOULD NOT execute this command**${color_reset}"

  printout_blank_line

  printout_no_enter "Are you sure to continue this process [N/y] "

  _27_confirmation=$(read_input)

  if ! is_equal "$_27_confirmation" "y"; then
    printout_exit "Aborted!"
  fi

  check_requirements "git" "sudo"

  if ! is_dir_exist "$config_macbook_audio_driver1_dir"; then
    git clone "$macbook_audio_driver1_url" "$config_macbook_audio_driver1_dir"
  fi

  cd "$config_macbook_audio_driver1_dir" || printout_exit "Audio driver1 not found!"
  sudo "./$config_macbook_audio_driver1_installation_script_name"

  printout_blank_line

  printout_markdown "${color_yellow}**Audio successfully configured. You may need to reboot your system or restart your audio service(s)**${color_reset}"
}

command_resolution() {
  check_requirements "xrandr"

  if is_no_argument "$@"; then
    printout_exit "Current screen resolution is $(xrandr | grep '\*' | awk '{print $1}')"
  fi

  if is_empty "$1" || is_empty "$2"; then
    printout_exit "Current screen resolution is $(xrandr | grep '\*' | awk '{print $1}')"
  fi

  xrandr --output "$1" --mode "$2"
}

command_output() {
  check_requirements "xrandr"
  xrandr --current
}

command_brightness() {
  check_requirements "xrandr" "bc"

  if is_no_argument "$@"; then
    printout_exit "Current brightness value is $(xrandr --verbose | awk '/Brightness/ { print $2 * 100; exit}')"
  fi

  if is_empty "$1" || is_empty "$2"; then
    printout_exit "Current brightness value is $(xrandr --verbose | awk '/Brightness/ { print $2 * 100; exit}')"
  fi

  _26_brightness=$(printout "scale=2; ${2} / 100" | bc)

  printout "${_26_brightness} < 0.10" | bc | grep -q 1

  if is_equal "$?" "0"; then
    printout_exit "Value under minimum!"
  fi

  printout "${_26_brightness} > 1.00" | bc | grep -q 1

  if is_equal "$?" "0"; then
    printout_exit "Value above maximum!"
  fi

  xrandr --output "$1" --brightness "$_26_brightness"
}

command_touchpad() {
  check_requirements "xinput"
  printout_markdown "${color_yellow}**This will configure touchpad device**${color_reset}"

  printout_blank_line

  xinput list

  printout_blank_line

  printout_no_enter "Enter your Touchpad Device ID..."

  _25_device_id=$(read_input)

  if is_empty "$_25_device_id"; then
    printout_exit "Device ID can't be empty!"
  fi

  printout_no_enter "
You're about to configure this Touchpad Device:

$(xinput list | grep "id=${_25_device_id}")

Are you sure? [N/y] "

  _25_confirmation=$(read_input)

  if ! is_equal "$_25_confirmation" "y"; then
    printout_exit "Aborted!"
  fi

  xinput set-prop $_25_device_id "libinput Tapping Enabled" 1
  xinput set-prop $_25_device_id "libinput Natural Scrolling Enabled" 0
}

command_audiocard() {
  check_requirements "pactl"
  pactl list cards
}

command_audio() {
  check_requirements "pulsemixer"
  pulsemixer
}

command_changeaiapikey() {
  check_ai_config
  configure_ai_api_key
  change_file_content_line "3" "$ai_api_key" "$config_ai_filepath"
  printout "OK"
}

command_changeaitype() {
  check_ai_config
  configure_ai_type
  change_file_content_line "1" "$ai_type" "$config_ai_filepath"
  printout "OK"
}

command_changeaimodel() {
  check_ai_config
  configure_ai_model
  change_file_content_line "2" "$ai_model" "$config_ai_filepath"
  printout "OK"
}

command_changerundesc() {
  printout_no_enter "Enter a name... "

  _2_name=$(read_input)

  if is_empty "$_2_name"; then
    printout_exit "The name can't be empty!"
  fi

  if is_contain "$_2_name" ":"; then
    printout_exit "The name can't contain a colon!"
  fi

  _2_name_exist=$(read_file_content "$config_run_list_filepath" | while IFS=: read -r _2_name_config _ _; do
    if is_equal "$_2_name" "$_2_name_config" && ! is_empty "$_2_name_config"; then
      printout_exit "exist"
    fi
  done)

  if ! is_equal "$_2_name_exist" "exist"; then
    printout_exit "${color_green}$_2_name${color_reset} command not found!"
  fi

  printout_no_enter "Enter a description... "

  _2_description=$(read_input)

  if is_contain "$_2_description" ":"; then
    printout_exit "The description can't contain a colon!"
  fi

  read_file_content "$config_run_list_filepath" | while IFS=: read -r _2_name_config _ _2_command_config; do
    if is_equal "$_2_name" "$_2_name_config" && ! is_empty "$_2_name_config"; then
      change_file_content_line_by_keyword "$_2_name_config:" "$_2_name_config:$_2_description:$_2_command_config" "$config_run_list_filepath"
      break
    fi
  done
}

command_changeruncommand() {
  printout_no_enter "Enter a name... "

  _3_name=$(read_input)

  if is_empty "$_3_name"; then
    printout_exit "The name can't be empty!"
  fi

  if is_contain "$_3_name" ":"; then
    printout_exit "The name can't contain a colon!"
  fi

  _3_name_exist=$(read_file_content "$config_run_list_filepath" | while IFS=: read -r _3_name_config _ _; do
    if is_equal "$_3_name" "$_3_name_config" && ! is_empty "$_3_name_config"; then
      printout_exit "exist"
    fi
  done)

  if ! is_equal "$_3_name_exist" "exist"; then
    printout_exit "${color_green}$_3_name${color_reset} command not found!"
  fi

  printout_no_enter "Enter the execution command... "

  _3_command=$(read_input)

  if is_empty "$_3_command"; then
    printout_exit "The execution command can't be empty!"
  fi

  read_file_content "$config_run_list_filepath" | while IFS=: read -r _3_name_config _3_description_config _; do
    if is_equal "$_3_name" "$_3_name_config" && ! is_empty "$_3_name_config"; then
      change_file_content_line_by_keyword "$_3_name_config:" "$_3_name_config:$_3_description_config:$_3_command" "$config_run_list_filepath"
      break
    fi
  done
}

command_getsmarter() {
  check_requirements "curl" "sudo"
  curl -L "$repo_url/$script_name" -o "/tmp/$script_name"
  sudo mv "/tmp/$script_name" "$install_dir/$target_name"
  sudo chmod +x "$install_dir/$target_name"

  if [ -x "$install_dir/$target_name" ]; then
    printout_exit "OK"
  else
    printout_exit "Operation failed!"
  fi
}

command_listrun() {
  _4_cfg="$(read_file_content "$config_run_list_filepath")"

  if is_empty "$_4_cfg"; then
    printout_exit "No custom commands have been set"
  fi

  printout "$_4_cfg" | while IFS=: read -r _4_name _4_description _4_command; do
    if is_empty "$_4_name" && is_empty "$_4_description" && is_empty "$_4_command"; then
      continue
    fi

    printf "${color_green}%-20s ${color_reset}%-30s ${color_cyan}%b${color_reset}\n" "$_4_name" "$_4_description" "$_4_command"
  done
}

command_setrun() {
  printout_no_enter "Enter a name... "

  _5_name=$(read_input)

  if is_empty "$_5_name"; then
    printout_exit "The name can't be empty!"
  fi

  if is_contain "$_5_name" ":"; then
    printout_exit "The name can't contain a colon!"
  fi

  _5_name_exist=$(read_file_content "$config_run_list_filepath" | while IFS=: read -r _5_name_config _ _; do
    if is_equal "$_5_name" "$_5_name_config"; then
      printout_exit "exist"
    fi
  done)

  if is_equal "$_5_name_exist" "exist"; then
    printout_exit "The name already exists!"
  fi

  printout_no_enter "Enter a description... "

  _5_description=$(read_input)

  if is_contain "$_5_description" ":"; then
    printout_exit "The description can't contain a colon!"
  fi

  printout_no_enter "Enter the execution command... "

  _5_command=$(read_input)

  if is_empty "$_5_command"; then
    printout_exit "The execution command can't be empty!"
  fi

  _5_cfg=$(append_content_to_file "$_5_name:$_5_description:$_5_command" "$config_run_list_filepath")

  write_to_file "$_5_cfg" "$config_run_list_filepath"
  printout "OK"
}

command_showimage() {
  if is_no_argument "$@"; then
    printout_exit "You didn't provide any names to show!"
  fi

  check_requirements "feh"
  feh "$@" &
}

command_playaudio() {
  if is_no_argument "$@"; then
    printout_exit "You didn't provide any names to play!"
  fi

  check_requirements "mpg123"
  mpg123 -v "$@"
}

command_playvideo() {
  if is_no_argument "$@"; then
    printout_exit "You didn't provide any names to play!"
  fi

  check_requirements "mpv"
  mpv "$@" > /dev/null 2>&1 &
}

command_testhttp() {
  check_requirements "siege"

  _6_concurrent="10"
  _6_time=""
  _6_retry=""
  _6_url=""
  _6_url_header="$http_header"
  _6_url_user_agent=""
  _6_url_content_type=""

  while [ $# -gt 0 ]; do
    case "$1" in
      -c)
        _6_concurrent="${1#-c}"

        if [ -z "$_6_concurrent" ]; then
          shift

          _6_concurrent="$1"
        fi
        ;;
      -t)
        _6_time="${1#-t}"

        if [ -z "$_6_time" ]; then
          shift

          _6_time="$1"
        fi
        ;;
      -r)
        _6_retry="${1#-r}"

        if [ -z "$_6_retry" ]; then
          shift

          _6_retry="$1"
        fi
        ;;
      -u)
        _6_url="${1#-u}"

        if [ -z "$_6_url" ]; then
          shift

          _6_url="$1"
        fi
        ;;
      -userAgent)
        _6_url_user_agent="${1#-userAgent}"

        if [ -z "$_6_url_user_agent" ]; then
          shift

          _6_url_user_agent="$1"
        fi
        ;;
      -header)
        _6_url_header="${1#-header}"

        if [ -z "$_6_url_header" ]; then
          shift

          _6_url_header="$1"
        fi
        ;;
      -contentType)
        _6_url_content_type="${1#-contentType}"

        if [ -z "$_6_url_content_type" ]; then
          shift

          _6_url_content_type="$1"
        fi
        ;;
    esac

    shift
  done

  if is_empty "$_6_url"; then
    printout_exit "Please provide a URL to test!\nUse this option: ${color_cyan}-u ${color_blue}URL${color_reset}"
  fi

  printout "url=$_6_url | concurrent=$_6_concurrent | time=${_6_time}S | retry=$_6_retry | header=$_6_url_header | userAgent=$_6_url_user_agent | contentType=$_6_url_content_type\n"

  if ! is_empty "$_6_time"; then
     execute siege -vbp "-c$_6_concurrent" "-t${_6_time}S" --header="$_6_url_header" --user-agent="$_6_url_user_agent" --content-type="$_6_url_content_type" "$_6_url"
  elif ! is_empty "$_6_retry"; then
     execute siege -vbp "-c$_6_concurrent" "-r$_6_retry" --header="$_6_url_header" --user-agent="$_6_url_user_agent" --content-type="$_6_url_content_type" "$_6_url"
  else
    execute siege -vbp "-c$_6_concurrent" "-t10S" --header="$_6_url_header" --user-agent="$_6_url_user_agent" --content-type="$_6_url_content_type" "$_6_url"
  fi
}

command_setai() {
  configure_ai_type
  configure_ai_model
  configure_ai_api_key
  write_to_file "$(printout "$ai_type\n$ai_model\n$ai_api_key")" "$config_ai_filepath"
  printout "AI configuration registered"
}

command_chat() {
  check_ai_config
  printout "${color_yellow}$ai_type ($ai_model)${color_reset}\n"

  _7_prompt=""

  while true; do
    printout_no_enter "${color_yellow}>_${color_reset} "

    _7_chat_prompt="$(read_input)"
    _7_chat_prompt="{\"role\": \"user\", \"parts\":[{\"text\": \"$(printout "$_7_chat_prompt" | escape_json_string)\"}]},"

    if is_empty "$_7_prompt"; then
      _7_prompt="$_7_chat_prompt"
    else
      _7_prompt="$_7_prompt $_7_chat_prompt"
    fi

    _7_response=""

    printout_blank_line

    if is_ai_google; then
      _7_response=$(http_request_google_ai "$(printout "$_7_prompt" | remove_trailing_comma)")
    fi

    _7_prompt="$_7_prompt {\"role\": \"model\", \"parts\":[{\"text\": \"$(printout "$_7_response" | escape_json_string)\"}]},"

    printout_typing "$(printout "$_7_response" | markdown_parse)"
  done
}

command_showai() {
  check_ai_config

  _8_api_key="* * * * *"

  if is_empty "$ai_api_key"; then
    _8_api_key=""
  fi

  printout "Type: ${color_yellow}$ai_type\n${color_reset}Model: ${color_yellow}$ai_model\n${color_reset}API key: ${color_blue}$_8_api_key${color_reset}"
}

command_removerun() {
  if is_no_argument "$@"; then
    printout_exit "You didn't provide any custom command(s) to remove!"
  fi

  for _9_arg in "$@"; do
    read_file_content "$config_run_list_filepath" | while IFS=: read -r _9_name_config _ _; do
      if is_equal "$_9_arg" "$_9_name_config" && ! is_empty "$_9_name_config"; then
        delete_line_from_file_by_keyword "$_9_name_config:" "$config_run_list_filepath"
        break
      fi
    done
  done

  printout "OK"
}

command_open() {
  if is_no_argument "$@"; then
    printout_exit "You didn't provide any names to open!"
  fi

  _10_not_exist=""

  for _10_arg in "$@"; do
    if is_package_exist "$_10_arg" || is_user_package_exist "$_10_arg"; then
      execute_async_no_std_out "$_10_arg"
      continue
    fi

    _10_not_exist="yes"

    printout "${color_red}$_10_arg ${color_reset}package not found!"
  done

  if ! is_equal "$_10_not_exist" "yes"; then
    clear_shell
  fi
}

command_kill() {
  if is_no_argument "$@"; then
    printout_exit "You didn't provide any names to kill!"
  fi

  check_requirements "sudo"

  _11_process_list=""

  printout_blank_line

  for _11_arg in "$@"; do
    # shellcheck disable=SC2009
    _11_process_list="$_11_process_list\n$(ps -ef | grep "$_11_arg" | grep -v "$pid" | awk '{print $2}')"

    # shellcheck disable=SC2009
    ps aux | grep "$_11_arg" | grep -v "$pid"
  done

  _11_process_list=$(printout "$_11_process_list")

  printout_no_enter "\nAll processes listed above will be terminated. Are you sure? [N/y] "

  _11_confirmation=$(read_input)

  if ! is_equal "$_11_confirmation" "y"; then
    printout "\nOperation aborted!"
    return 0
  fi

  printout "$_11_process_list" | while IFS= read -r _11_line; do
    if ! is_empty "$_11_line"; then
      sudo kill -9 "$_11_line" > /dev/null 2>&1
    fi
  done

  printout "\nAll processes have been terminated!"
}

command_search() {
  if is_no_argument "$@"; then
    printout_exit "You didn't provide any keywords to search!"
  fi

  check_requirements "w3m"
  execute w3m "$search_url$(printout "$*" | sed 's/ /+/g')"
  clear_shell
}

command_install() {
  if is_no_argument "$@"; then
    printout_exit "You didn't provide any names to install!"
  fi

  install_package "$@"
}

command_remove() {
  if is_no_argument "$@"; then
    printout_exit "You didn't provide any names to remove!"
  fi

  remove_package "$@"
}

command_upgrade() {
  upgrade_package "$@"
}

command_version() {
  printout "$version"
}

command_reveal() {
  check_requirements "vim"
  execute vim -R "$install_dir/$target_name"
}

command_run() {
  if is_no_argument "$@"; then
    printout_exit "You didn't provide any commands to run!"
  fi

  write_to_file "not exist" "$config_tmp_value_filepath"

  for _12_arg in "$@"; do
    read_file_content "$config_run_list_filepath" | while IFS=: read -r _12_name _12_description _12_command; do
      if is_empty "$_12_name" && is_empty "$_12_description" && is_empty "$_12_command"; then
        continue
      fi

      if is_equal "$_12_arg" "$_12_name"; then
        write_to_file "exist" "$config_tmp_value_filepath"
        printout "\n${color_green}$_12_name${color_reset} >_ ${color_cyan}$_12_command${color_reset}\n"
        execute_eval "$_12_command"
        printout_blank_line
        break
      fi
    done

    if ! is_equal "$(get_tmp_value)" "exist"; then
      printout "${color_green}$_12_arg${color_reset} command not found!"
    fi
  done
}

command_prompt() {
  if is_no_argument "$@"; then
    printout_exit "You didn't provide any prompt text!"
  fi

  check_ai_config
  printout "${color_yellow}$ai_type ($ai_model)${color_reset}\n"

  _13_response=""

  if is_ai_google; then
    _13_response=$(http_request_google_ai "$(printout "{\"role\": \"user\", \"parts\":[{\"text\": \"$(printout "$*" | escape_json_string)\"}]}," | remove_trailing_comma)")
  fi

  printout_typing "$(printout "$_13_response" | markdown_parse)"
}

command_window() {
  check_requirements "yad"

  _14_command=$(yad --entry --sticky --no-buttons --width=400 --title "" --text "BE CAREFUL ABOUT WHAT YOU TYPE, MAKE SURE THERE IS NOTHING THAT CAN BREAK YOUR SYSTEM" --text-align "fill" --undecorated)

  if is_empty "$_14_command"; then
    return 0
  fi

  if ! is_start_with "$_14_command" "umar"; then
    _14_command="umar $_14_command"
  fi

  if is_start_with "$_14_command" "umar help"; then
    open_terminal_and_execute_wait "umar"
  elif is_start_with "$_14_command" "umar show image" || is_start_with "$_14_command" "umar play video"; then
    execute_eval "$_14_command"
  elif is_start_with "$_14_command" "umar open"; then
    $_14_command
  elif is_start_with "$_14_command" "umar search" || is_start_with "$_14_command" "umar play audio"; then
    open_terminal_and_execute "$_14_command"
  else
    open_terminal_and_execute_wait "$_14_command"
  fi
}

command_wifi() {
  check_requirements "iwctl"

  _15_device="wlan0"

  if ! [ "$1" = "" ]; then
    _15_device="$1"
  fi

  if [ "$2" = "" ]; then
    printout "Scanning..."
    iwctl station "$_15_device" scan || return 0
    sleep 1
    iwctl station "$_15_device" get-networks || return 0
    return 0
  fi

  shift
  printout "Refreshing device..."
  iwctl device "$_15_device" set-property Powered off || return 0
  sleep 1
  iwctl device "$_15_device" set-property Powered on || return 0
  sleep 1
  printout "OK"
  printout "Scanning..."
  iwctl station "$_15_device" scan || return 0
  printout "OK"
  printout "Connecting..."
  sleep 1
  # shellcheck disable=SC2048
  iwctl station "$_15_device" connect $* || return 0
  printout "OK"
}

# ---------------------------------------------------------------------------------------------------------------------
#
# `printout`
# Prints to std out
#
# ---------------------------------------------------------------------------------------------------------------------

printout() {
  printf "%b" "$1\n"
}

printout_no_enter() {
  printf "%b" "$1"
}

printout_as_is() {
  printf "%s" "$1"
}

printout_exit() {
  printout "$1"
  exit 0
}

printout_blank_line() {
  printout ""
}

printout_markdown() {
  printout "$(printout "$1" | markdown_parse)"
}

printout_markdown_no_enter() {
  printout_no_enter "$(printout_no_enter "$1" | markdown_parse)"
}

printout_typing() {
  _16_text=$(printout_no_enter "$1" | sed 's/$/\\n/' | tr -d '\n')
  _16_i=0

  while [ $_16_i -lt ${#_16_text} ]; do
    # shellcheck disable=SC2004
    _16_char=$(printout_as_is "$_16_text" | cut -c $(($_16_i+1)))

    if is_equal "$_16_char" "\\"; then
      # shellcheck disable=SC2004
      _16_next_char=$(printout_as_is "$_16_text" | cut -c $(($_16_i+2)))

      if is_equal "$_16_next_char" "n"; then
        printout_blank_line

        # shellcheck disable=SC2004
        _16_i=$(($_16_i + 1))
      fi
    else
      printout_no_enter "$_16_char"
    fi

    sleep "$typing_speed"

    # shellcheck disable=SC2004
    _16_i=$(($_16_i + 1))
  done

  printout_blank_line
}

# ---------------------------------------------------------------------------------------------------------------------
#
# `check`
# Checks certain conditions
#
# ---------------------------------------------------------------------------------------------------------------------

check_ai_config() {
  if is_empty "$ai_type"; then
    printout_exit "You didn't provide any AI type to process!\nYou can use this command to set up a new one: ${color_cyan}umar set ai${color_reset}"
  fi

  if is_empty "$ai_url"; then
    printout_exit "You didn't provide any AI URL to process!\nYou can use this command to set up a new one: ${color_cyan}umar set ai${color_reset}"
  fi

  if is_empty "$ai_model"; then
    printout_exit "You didn't provide any AI model to process!\nYou can use this command to set up a new one: ${color_cyan}umar set ai${color_reset}"
  fi
}

check_requirements() {
  _17_not_exist=""
  _17_iwd=""

  for _17_arg in "$@"; do
    if is_package_exist "$_17_arg" || is_user_package_exist "$_17_arg"; then
        continue
    fi

    if is_equal "$_17_arg" "iwctl"; then
      _17_arg="iwd"
      _17_iwd="yes"
    fi

    if is_equal "$_17_arg" "pactl"; then
      _17_arg="pulseaudio-utils"
    fi

    if is_equal "$_17_arg" "xinput"; then
      _17_arg="xorg-xinput"
    fi

    if is_equal "$_17_arg" "xrandr"; then
      _17_arg="xorg-xrandr"
    fi

    if is_empty "$_17_not_exist"; then
      _17_not_exist="$_17_arg"
    else
      _17_not_exist="$_17_not_exist $_17_arg"
    fi
  done

  if is_empty "$_17_not_exist"; then
    return 0
  fi

  if is_equal "$_17_iwd" "yes"; then
    printout_markdown "${color_yellow}**It seems you want to install **${color_red}**iwd**${color_yellow}**. If you have any other network or wireless daemon installed, it might cause a conflict between them**${color_reset}"
  fi

  printout_markdown_no_enter "${color_red}**$_17_not_exist** ${color_reset}package(s) are not installed. Do you want to install them? [N/y] "

  _17_confirmation=$(read_input)

  if ! is_equal "$_17_confirmation" "y"; then
    printout_exit "I need that package(s) to process the command!"
  fi

  if is_unknown; then
    printout "Unknown distribution!"
    printout_exit "I need that package(s) to process the command!"
  fi

  install_package_arg_split "$_17_not_exist"

  if is_equal "$_17_iwd" "yes"; then
    sudo systemctl stop iwd.service > /dev/null 2>&1
    sudo systemctl start iwd.service > /dev/null 2>&1
    sleep 2
  fi

  printout "The required package(s) have been installed. Refresh the current console/terminal session and run the command again"
}

# ---------------------------------------------------------------------------------------------------------------------
#
# `is`
# Provides conditional statements
#
# ---------------------------------------------------------------------------------------------------------------------

is_equal() {
  [ "$1" = "$2" ]
}

is_empty() {
  is_equal "$1" ""
}

is_contain() {
  printout "$1" | grep -q "$2"
}

is_start_with() {
  [ "${1#$2}" != "$1" ]
}

is_no_argument() {
  [ $# -eq 0 ]
}

is_arch() {
  is_equal "$distro" "arch" || is_equal "$distro" "manjaro"
}

is_debian() {
  is_equal "$distro" "debian" || is_equal "$distro" "ubuntu"
}

is_fedora() {
  is_equal "$distro" "fedora" || is_equal "$distro" "centos"
}

is_unknown() {
  is_equal "$distro" ""
}

is_de_i3wm() {
  is_equal "$de" "i3wm" || is_equal "$de" "i3" || is_equal "$de" "I3WM" || is_equal "$de" "I3"
}

is_package_exist() {
  command -v "$1" > /dev/null 2>&1
}

is_user_package_exist() {
  test -f "$user_package_dir/$1"
}

is_file_exist() {
  [ -f "$1" ]
}

is_dir_exist() {
  [ -d "$1" ]
}

is_ai_google() {
  is_equal "$ai_type" "google"
}

# ---------------------------------------------------------------------------------------------------------------------
#
# `get`
# Gets value from certain source
#
# ---------------------------------------------------------------------------------------------------------------------

get_tmp_value() {
  if ! is_file_exist "$config_tmp_value_filepath"; then
    return 0
  fi

  read_file_content "$config_tmp_value_filepath"
  clear_tmp_value
}

# ---------------------------------------------------------------------------------------------------------------------
#
# `install`
# Installs something
#
# ---------------------------------------------------------------------------------------------------------------------

install_package() {
  if is_arch; then
    sudo pacman -S "$@"
  fi

  if is_debian; then
    sudo apt update
    sudo apt install "$@"
  fi

  if is_fedora; then
    sudo dnf install "$@"
  fi
}

install_package_arg_split() {
  # shellcheck disable=SC2068
  install_package $@
}

# ---------------------------------------------------------------------------------------------------------------------
#
# `remove`
# Removes something
#
# ---------------------------------------------------------------------------------------------------------------------

remove_package() {
  if is_arch; then
    sudo pacman -Rsd --cascade "$@"
  fi

  if is_debian; then
    sudo apt autoremove --purge "$@"
  fi

  if is_fedora; then
    sudo dnf remove "$@"
  fi
}

remove_trailing_comma() {
  sed 's/,$//'
}

# ---------------------------------------------------------------------------------------------------------------------
#
# `upgrade`
# Upgrades something
#
# ---------------------------------------------------------------------------------------------------------------------

upgrade_package() {
  if is_arch; then
    sudo pacman -Syu "$@"
  fi

  if is_debian; then
    sudo apt update
    sudo apt autoremove --purge
    sudo apt upgrade "$@"
  fi

  if is_fedora; then
    sudo dnf upgrade "$@"
  fi
}

# ---------------------------------------------------------------------------------------------------------------------
#
# `execute`
# Executes certain command
#
# ---------------------------------------------------------------------------------------------------------------------

execute() {
  if is_de_i3wm; then
    i3-msg split h > /dev/null 2>&1
  fi

  if is_equal "$1" "__execute_async=true"; then
    shift
    exec "$@" &
  elif is_equal "$1" "__execute_async_no_std_out=true"; then
    shift
    exec "$@" > /dev/null 2>&1 &
  elif is_equal "$1" "__execute_no_std_out=true"; then
    shift
    exec "$@" > /dev/null 2>&1
  elif is_equal "$1" "__execute_eval=true"; then
    shift
    eval "$@"
  elif is_equal "$1" "__execute_eval_async=true"; then
    shift
    eval "$@" &
  elif is_equal "$1" "__execute_eval_async_no_std_out=true"; then
    shift
    eval "$@" > /dev/null 2>&1 &
  elif is_equal "$1" "__execute_eval_no_std_out=true"; then
    shift
    eval "$@" > /dev/null 2>&1
  else
    exec "$@"
  fi

  if is_de_i3wm; then
    i3-msg focus right > /dev/null 2>&1
    i3-msg focus left > /dev/null 2>&1
  fi
}

execute_no_std_out() {
  execute "__execute_no_std_out=true" "$@"
}

execute_async() {
  execute "__execute_async=true" "$@"
}

execute_async_no_std_out() {
  execute "__execute_async_no_std_out=true" "$@"
}

execute_eval() {
  execute "__execute_eval=true" "$@"
}

execute_eval_no_std_out() {
  execute "__execute_eval_no_std_out=true" "$@"
}

execute_eval_async() {
  execute "__execute_eval_async=true" "$@"
}

execute_eval_async_no_std_out() {
  execute "__execute_eval_async_no_std_out=true" "$@"
}

# ---------------------------------------------------------------------------------------------------------------------
#
# `clear`
# Clears something
#
# ---------------------------------------------------------------------------------------------------------------------

clear_shell() {
  if is_de_i3wm; then
    i3-msg kill > /dev/null 2>&1
  fi
}

clear_tmp_value() {
  if is_file_exist "$config_tmp_value_filepath"; then
    rm -rf "$config_tmp_value_filepath"
  fi
}

# ---------------------------------------------------------------------------------------------------------------------
#
# `delete`
# Deletes something
#
# ---------------------------------------------------------------------------------------------------------------------

delete_line_from_file_by_keyword() {
  sed -i "/^$1/d" "$2"
}

# ---------------------------------------------------------------------------------------------------------------------
#
# `create`
# Creates something
#
# ---------------------------------------------------------------------------------------------------------------------

create_dir() {
  if ! is_dir_exist "$1"; then
    mkdir "$1"
  fi
}

create_file() {
  if ! is_file_exist "$1"; then
    touch "$1"
  fi
}

# ---------------------------------------------------------------------------------------------------------------------
#
# `write`
# Writes something
#
# ---------------------------------------------------------------------------------------------------------------------

write_to_file() {
  printout "$1" > "$2"
}

# ---------------------------------------------------------------------------------------------------------------------
#
# `read`
# Reads something
#
# ---------------------------------------------------------------------------------------------------------------------

read_file_content() {
  if ! is_file_exist "$1"; then
    printout_exit "${color_red}$1 ${color_reset}file not found!"
  fi

  cat "$1"
}

read_file_content_line() {
  sed -n "${1}p" "$2"
}

read_input() {
  read -r _18_input < /dev/tty
  printout "$_18_input"
}

# ---------------------------------------------------------------------------------------------------------------------
#
# `configure`
# Configures something
#
# ---------------------------------------------------------------------------------------------------------------------

configure_ai_type() {
  printout_no_enter "\
AI type:

1. Google

Choose the AI type number... \
"

  _19_type=$(read_input)

  if is_empty "$_19_type"; then
    printout_exit "AI type can't be empty!"
  fi

  if ! is_equal "$_19_type" "1"; then
    printout_exit "You chose the wrong AI type number!"
  fi

  if is_equal "$_19_type" "1"; then
    ai_type="google"
  fi
}

configure_ai_model() {
  if is_empty "$ai_type"; then
    ai_type=$(read_file_content_line "1" "$config_ai_filepath")
  fi

  if is_ai_google; then
    printout_no_enter "
AI model:

1. Gemini 1.0 Pro
2. Gemini 1.5 Pro
3. Gemini 1.5 Flash

Choose the AI model number... \
"
  else
    printout_exit "You chose the wrong AI type number!"
  fi

  _20_model=$(read_input)

  if is_empty "$_20_model"; then
    printout_exit "AI model can't be empty!"
  fi

  if is_ai_google; then
    if ! is_equal "$_20_model" "1" && ! is_equal "$_20_model" "2" && ! is_equal "$_20_model" "3"; then
      printout_exit "You chose the wrong AI model number!"
    fi

    # shellcheck disable=SC2086
    ai_model=$(eval "echo "\$gemini_model_${_20_model}"")
  fi
}

configure_ai_api_key() {
  if is_empty "$ai_type"; then
    ai_type=$(read_file_content_line "1" "$config_ai_filepath")
  fi

  if is_ai_google; then
    printout_no_enter "
You'll need an API key to use the AI. You can follow this documentation -> https://ai.google.dev/gemini-api/docs/api-key

Enter the API key... \
"
  else
    printout_exit "You chose the wrong AI type number!"
  fi

  _21_api_key=$(read_input)

  if is_ai_google && is_empty "$_21_api_key"; then
    printout_exit "API Key can't be empty!"
  fi

  ai_api_key="$_21_api_key"
}

# ---------------------------------------------------------------------------------------------------------------------
#
# `append`
# Appends something
#
# ---------------------------------------------------------------------------------------------------------------------

append_content_to_file() {
  printout "$(read_file_content "$2")\n$1"
}

# ---------------------------------------------------------------------------------------------------------------------
#
# `open`
# Opens something
#
# ---------------------------------------------------------------------------------------------------------------------

open_terminal_and_execute() {
  check_requirements "xfce4-terminal"

  _22_command=""

  if is_equal "$1" "__o_t_a_e_wait=true"; then
    shift

    _22_command="sh -c '$*; printf \"\n\nPress Enter to exit\n\n\"; read -r _ < /dev/tty'"
  else
    _22_command="sh -c '$*'"
  fi

  xfce4-terminal -e "$_22_command"
}

open_terminal_and_execute_wait() {
  open_terminal_and_execute "__o_t_a_e_wait=true" "$@"
}

# ---------------------------------------------------------------------------------------------------------------------
#
# `change`
# Changes something
#
# ---------------------------------------------------------------------------------------------------------------------

change_file_content_line() {
  sed -i "$1s|.*|$2|" "$3"
}

change_file_content_line_by_keyword() {
  sed -i "s|^$1.*|$2|" "$3"
}

# ---------------------------------------------------------------------------------------------------------------------
#
# `http`
# Provides http handler
#
# ---------------------------------------------------------------------------------------------------------------------

http_request() {
  check_requirements "curl"

  _23_url=""
  _23_content_type="application/json"
  _23_method="POST"
  _23_request_body=""

  while [ $# -gt 0 ]; do
    case "$1" in
      -url)
        _23_url="${1#-url}"

        if [ -z "$_23_url" ]; then
          shift

          _23_url="$1"
        fi
        ;;
      -contentType)
        _23_content_type="${1#-contentType}"

        if [ -z "$_23_content_type" ]; then
          shift

          _23_content_type="$1"
        fi
        ;;
      -method)
        _23_method="${1#-method}"

        if [ -z "$_23_method" ]; then
          shift

          _23_method="$1"
        fi
        ;;
      -requestBody)
        _23_request_body="${1#-requestBody}"

        if [ -z "$_23_request_body" ]; then
          shift

          _23_request_body="$1"
        fi
        ;;
    esac

    shift
  done

  curl "$_23_url" -H "$http_header" -H "Content-Type: $_23_content_type" -X "$_23_method" -d "$_23_request_body"
}

http_request_google_ai() {
  if ! is_ai_google; then
    return 0
  fi

  check_requirements "jq"

  _24_http_response=$(http_request -url "$ai_url/$ai_model:generateContent?key=$ai_api_key" -requestBody "
    {
      \"contents\": [
        $1
      ],
      \"generationConfig\": {
        \"temperature\": 0.9
      }
    }"
  )

  printout_blank_line

  _24_text=$(printf '%s\n' "$_24_http_response" | jq -r '.candidates[0].content.parts[0].text')

  if is_equal "$_24_text" "null"; then
    printout_exit "$_24_http_response"
  fi

  printout "$_24_text"
}

# ---------------------------------------------------------------------------------------------------------------------
#
# `escape`
# Provides escaping handler
#
# ---------------------------------------------------------------------------------------------------------------------

escape_json_string() {
  sed -e 's/\\/\\\\/g' -e 's/"/\\"/g' -e 's/\n/\\n/g' -e 's/\r/\\r/g' -e 's/\t/\\t/g' -e 's/\b/\\b/g' -e 's/\f/\\f/g'
}

# ---------------------------------------------------------------------------------------------------------------------
#
# `markdown`
# Provides markdown handler
#
# ---------------------------------------------------------------------------------------------------------------------

markdown_parse() {
  awk '
    BEGIN {
      bold_start = "\033[1m"
      bold_end = "\033[0m"
      italic_start = "\033[3m"
      italic_end = "\033[0m"
      header_start = "\033[1;37m"
      header_end = "\033[0m"
      strikethrough_start = "\033[9m"
      strikethrough_end = "\033[0m"
      code_start = "\033[0;36m"
      code_end = "\033[0m"
      link_start = "\033[4m"
      link_end = "\033[0m"
      horizontal_rule = "\033[2m────────────────────────────────────────────────────────────\033[0m"
      code_block_start = "\033[0;32m"
      code_block_end = "\033[0m"
    }

    {
      if ($0 ~ /^# /) {
        sub(/^# +/, "")
        print header_start $0 header_end
        next
      }

      if ($0 ~ /^[-*]\{3,}$/) {
        print horizontal_rule
        next
      }

      if (index($0, "```") > 0) {
        if (in_code_block) {
          print code_block_end
          in_code_block = 0
        } else {
          print code_block_start
          in_code_block = 1
        }
        next
      }
      if (in_code_block) {
        print $0
        next
      }

      while (match($0, /\[([^\]]+)\]\([^\)]+\)/)) {
        $0 = substr($0, 1, RSTART-1) link_start substr($0, RSTART+1, RLENGTH-2) link_end substr($0, RSTART+RLENGTH)
      }

      while (match($0, /~~([^~]+)~~/)) {
        $0 = substr($0, 1, RSTART-1) strikethrough_start substr($0, RSTART+2, RLENGTH-4) strikethrough_end substr($0, RSTART+RLENGTH)
      }

      while (match($0, /\*\*([^*]+)\*\*/)) {
        $0 = substr($0, 1, RSTART-1) bold_start substr($0, RSTART+2, RLENGTH-4) bold_end substr($0, RSTART+RLENGTH)
      }

      while (match($0, /\*([^*]+)\*/)) {
        $0 = substr($0, 1, RSTART-1) italic_start substr($0, RSTART+1, RLENGTH-2) italic_end substr($0, RSTART+RLENGTH)
      }

      while (match($0, /`([^`]+)`/)) {
        $0 = substr($0, 1, RSTART-1) code_start substr($0, RSTART+1, RLENGTH-2) code_end substr($0, RSTART+RLENGTH)
      }

      print
    }
    '
}

umar "$@"
