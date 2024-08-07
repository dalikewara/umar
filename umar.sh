#!/bin/sh

version="v1.1.11"
pid=$$
search_url="https://www.google.com/search?q="
distro="unknown"
de="unknown"
user_package_dir="/usr/local/bin"
config_dir="$HOME/.umar"
config_run_list_filepath="$config_dir/run-list.cfg"
config_ai_filepath="$config_dir/ai.cfg"
color_green='\033[0;32m'
color_cyan='\033[0;36m'
color_blue='\033[0;34m'
color_red='\033[0;31m'
color_yellow='\033[1;33m'
color_reset='\033[0m'
repo_url="https://raw.githubusercontent.com/dalikewara/umar/master"
script_name="umar.sh"
install_dir="/usr/local/bin"
ai="unknown"
generative_ai_url="https://generativelanguage.googleapis.com/v1beta/models"
gemini_api_key=""
gemini_model=""
gemini_model_1="gemini-1.0-pro"
gemini_model_2="gemini-1.5-pro"
gemini_model_3="gemini-1.5-flash"
tmp_ai_type=""
tmp_ai_model=""
tmp_ai_api_key=""
target_name="umar"
browser="w3m"
img_display="feh"
audio_player="mpg123"
video_player="mpv"
editor="vim"
http_test_tool="siege"
json_tool="jq"
shell_tool="sh"
typing_speed=0.005

umar="I am Umar ($version), your little Linux assistant. I can help you with the common tasks listed below. \
I will continue to be updated indefinitely, as my creator may need to add new features, \
update my logic, fix issues, or make other changes. So, I may get smarter every day. I can also use AI, \
but you need to manually set up the configuration first."
invalid_command="Sorry, I can't understand your command"
command_open_name_not_found="is not found!"
command_kill_confirmation="All processes listed above will be terminated. Are you sure? [N/y]"
command_kill_confirmation_y="All processes have been terminated!"
command_kill_confirmation_n="Aborted!"
command_test_http_no_url="Please provide me with a URL to test!
Use this option: ${color_cyan}-u ${color_blue}URL${color_reset}"
command_run_list_empty="No custom command has been set"
command_run_set_name="Enter name..."
command_run_set_name_contain_colon="Name can't contains a colon"
command_run_set_name_exist="Name already exist"
command_run_set_name_empty="Name can't be empty"
command_run_set_description="Enter description..."
command_run_set_description_contain_colon="Description can't contains a colon"
command_run_set_command="Enter execution command..."
command_run_set_command_empty="Execution command can't be empty"
command_run_set_registered="OK"
command_set_ai_type="AI type:

1. Google

Choose AI type number..."
command_set_ai_type_empty="AI type can't be empty"
command_set_ai_type_wrong="You choose wrong AI type number"
command_set_ai_model_google="
AI model:

1. Gemini 1.0 Pro
2. Gemini 1.5 Pro
3. Gemini 1.5 Flash

Choose AI model number..."
command_set_ai_model_empty="AI model can't be empty"
command_set_ai_model_wrong="You choose wrong AI model number"
command_set_ai_api_key_google="
You'll need an API key to use the AI.
You can follow this doc -> https://ai.google.dev/gemini-api/docs/api-key

Enter API key..."
command_set_ai_api_key_empty="API Key can't be empty"
command_set_ai_registered="OK"

kill_empty="You didn't provide any names to kill!"
open_empty="You didn't provide any names to open!"
install_empty="You didn't provide any names to install!"
remove_empty="You didn't provide any names to remove!"
show_empty="You didn't provide any names to show!"
play_empty="You didn't provide any names to play!"
run_empty="You didn't provide any names to run!"
prompt_empty="You didn't provide any prompt!"
change_empty="You didn't provide new content to change!"
ai_empty="You didn't provide any AI type to process!
You can use this command to set up the new one: ${color_cyan}umar set ai${color_reset}"
ai_url_empty="You didn't provide any AI url to process!
You can use this command to set up the new one: ${color_cyan}umar set ai${color_reset}"
ai_api_key_empty="You didn't provide any AI api key to process!
You can use this command to set up the new one: ${color_cyan}umar set ai${color_reset}"
ai_model_empty="You didn't provide any AI model to process!
You can use this command to set up the new one: ${color_cyan}umar set ai${color_reset}"

ok="OK"

file_not_found="file is not found!"

distro_is_unknown="Unknown distribution"
package_not_installed="is not installed. Do you want to install it? [N/y]"
package_is_needed="I need that package to process the command"
package_needed_installed="The required package(s) have been installed. Refresh the current console/terminal session and run the command again"
feature_is_not_implemented_yet="This feature is not implemented yet"

commands="get smarter:Upgrade me to the latest version
version:Show my current version
reveal:Reveal my source code
--------------:--------------------------
run:Run custom command(s)
list run:List registered custom command(s)
set run:Set new custom command
--------------:--------------------------
prompt:Prompt anything to AI
start chat:Start new chat session with AI
set ai:Set new AI configuration
show ai:Show AI information
change ai type:Change AI type
change ai model:Change AI model
change ai api key:Change AI API key
--------------:--------------------------
open:Open package(s)
kill:Kill package(s) process
search:Search for the given keyword(s) using a terminal browser
install:Install package(s)
remove:Remove package(s)
upgrade:Upgrade package(s)
test http:Test and benchmark http url -> \`${color_cyan}-c ${color_blue}NUM ${color_cyan}-r ${color_blue}NUM ${color_cyan}-t \
${color_blue}SECONDS ${color_cyan}-header ${color_blue}TEXT ${color_cyan}-userAgent ${color_blue}TEXT ${color_cyan}-contentType \
${color_blue}TEXT ${color_cyan}-u ${color_blue}URL${color_reset}\`
show image:Show image(s)
play audio:Play audio(s)
play video:Play video(s)
"

# umar

umar() {
  install_needed $shell_tool

  if is_no_argument "$@"; then
    echo "
$umar
"

    echo "$commands" | while IFS=: read -r _u_name _u_description; do
      printf "${color_green}%-20s ${color_reset}%b\n" "$_u_name" "$_u_description"
    done

    exit 0
  fi

  case "$1 $2 $3 $4" in
    "change ai api key")
      shift
      shift
      shift
      shift
      u_change_ai_api_key
      return 0
      ;;
    esac

  case "$1 $2 $3" in
    "change ai type")
      shift
      shift
      shift
      u_change_ai_type
      return 0
      ;;
    "change ai model")
      shift
      shift
      shift
      u_change_ai_model
      return 0
      ;;
    esac

  case "$1 $2" in
    "get smarter")
      u_get_smarter
      return 0
      ;;
    "list run")
      u_list_run
      return 0
      ;;
    "set run")
      u_set_run
      return 0
      ;;
    "show image")
      shift
      shift
      u_show_image "$@"
      return 0
      ;;
    "play audio")
      shift
      shift
      u_play_audio "$@"
      return 0
      ;;
    "play video")
      shift
      shift
      u_play_video "$@"
      return 0
      ;;
    "test http")
      shift
      shift
      u_test_http "$@"
      return 0
      ;;
    "set ai")
      u_set_ai
      return 0
      ;;
    "start chat")
      u_start_chat
      return 0
      ;;
    "show ai")
      u_show_ai
      return 0
      ;;
  esac

  case "$1" in
    "open")
      shift
      u_open "$@"
      return 0
      ;;
    "kill")
      shift
      u_kill_process "$@"
      return 0
      ;;
    "search")
      shift
      u_search "$@"
      return 0
      ;;
    "install")
      shift
      u_install "$@"
      return 0
      ;;
    "remove")
      shift
      u_remove "$@"
      return 0
      ;;
    "upgrade")
      shift
      u_upgrade "$@"
      return 0
      ;;
    "version")
      echo "$version"
      return 0
      ;;
    "reveal")
      u_reveal
      return 0
      ;;
    "run")
      shift
      u_run "$@"
      return 0
      ;;
    "prompt")
      shift
      u_prompt "$@"
      return 0
      ;;
  esac

  echo_exit "$invalid_command"
}

u_open() {
  determine_de
  check_open_empty "$@"

  _u_o_not_exist=""

  for _u_o_arg in "$@"; do
    if is_package_exist "$_u_o_arg"; then
      exec_combine_async_no_std_out_base "$_u_o_arg"
    else
      if is_user_package_exist "$_u_o_arg"; then
        exec_combine_async_no_std_out_base "$_u_o_arg"
      else
        _u_o_not_exist="yes"

        printf "${color_red}$_u_o_arg ${color_reset}$command_open_name_not_found%b\n"
      fi
    fi
  done

  if ! is_equal "$_u_o_not_exist" "yes"; then
    kill_combine
  fi
}

u_kill_process() {
  check_kill_empty "$@"

  _u_k_p_process_list=""

  for _u_k_p_arg in "$@"; do
    # shellcheck disable=SC2009
    _u_k_p_process_list="$_u_k_p_process_list\n$(ps -ef | grep "$_u_k_p_arg" | grep -v "$pid" | awk '{print $2}')"

    # shellcheck disable=SC2009
    ps aux | grep "$_u_k_p_arg" | grep -v "$pid"
  done

  _u_k_p_process_list=$(printf '..%b..' "$_u_k_p_process_list")

  echo "
$command_kill_confirmation"

  _u_k_p_confirmation=$(read_func)

  if is_equal "$_u_k_p_confirmation" "y"; then
    echo "$_u_k_p_process_list" | while IFS= read -r _u_k_p_line; do
      if ! is_empty "$_u_k_p_line"; then
        sudo kill -9 "$_u_k_p_line" > /dev/null 2>&1
      fi
    done

    echo "$command_kill_confirmation_y"

    exit 0
  fi

  echo "$command_kill_confirmation_n"
}

u_search() {
  determine_distro
  determine_de
  install_needed $browser
  exec_combine_default_base $browser "$search_url$(echo "$*" | sed 's/ /+/g')"
  kill_combine
}

u_install() {
  determine_distro
  check_install_empty "$@"
  install_combine "$@"
}

u_remove() {
  determine_distro
  check_remove_empty "$@"
  remove_combine "$@"
}

u_upgrade() {
  determine_distro
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
  determine_distro
  determine_de
  check_show_empty "$@"
  install_needed $img_display
  exec_combine_async_no_std_out_base $img_display "$@"
}

u_play_audio() {
  determine_distro
  determine_de
  check_play_empty "$@"
  install_needed $audio_player
  exec_combine_default_with_std_out_base $audio_player -v "$@"
}

u_play_video() {
  determine_distro
  determine_de
  check_play_empty "$@"
  install_needed $video_player
  exec_combine_async_no_std_out_base $video_player "$@"
}

u_reveal() {
  determine_distro
  determine_de
  install_needed $editor
  exec_combine_default_base $editor -R "$install_dir/$target_name"
}

u_test_http() {
  determine_distro
  determine_de
  install_needed $http_test_tool

  _u_t_h_concurrent="10"
  _u_t_h_time=""
  _u_t_h_retry=""
  _u_t_h_url=""
  _u_t_h_url_header="X-HELLO:X-WORLD"
  _u_t_h_url_user_agent=""
  _u_t_h_url_content_type=""

  while [ $# -gt 0 ]; do
    case "$1" in
      -c)
        _u_t_h_concurrent="${1#-c}"
        if [ -z "$_u_t_h_concurrent" ]; then
          shift
          _u_t_h_concurrent="$1"
        fi
        ;;
      -t)
        _u_t_h_time="${1#-t}"
        if [ -z "$_u_t_h_time" ]; then
          shift
          _u_t_h_time="$1"
        fi
        ;;
      -r)
        _u_t_h_retry="${1#-r}"
        if [ -z "$_u_t_h_retry" ]; then
          shift
          _u_t_h_retry="$1"
        fi
        ;;
      -u)
        _u_t_h_url="${1#-u}"
        if [ -z "$_u_t_h_url" ]; then
          shift
          _u_t_h_url="$1"
        fi
        ;;
      -userAgent)
        _u_t_h_url_user_agent="${1#-userAgent}"
        if [ -z "$_u_t_h_url_user_agent" ]; then
          shift
          _u_t_h_url_user_agent="$1"
        fi
        ;;
      -header)
        _u_t_h_url_header="${1#-header}"
        if [ -z "$_u_t_h_url_header" ]; then
          shift
          _u_t_h_url_header="$1"
        fi
        ;;
      -contentType)
        _u_t_h_url_content_type="${1#-contentType}"
        if [ -z "$_u_t_h_url_content_type" ]; then
          shift
          _u_t_h_url_content_type="$1"
        fi
        ;;
    esac
    shift
  done

  if is_empty "$_u_t_h_url"; then
    printf_exit "$command_test_http_no_url"
  fi

  echo "url=$_u_t_h_url | concurrent=$_u_t_h_concurrent | time=${_u_t_h_time}S | retry=$_u_t_h_retry | header=$_u_t_h_url_header | userAgent=$_u_t_h_url_user_agent | contentType=$_u_t_h_url_content_type
"

  if ! is_empty "$_u_t_h_time"; then
     exec_combine_default_with_std_out_base $http_test_tool -vbp "-c$_u_t_h_concurrent" "-t${_u_t_h_time}S" --header="$_u_t_h_url_header" --user-agent="$_u_t_h_url_user_agent" --content-type="$_u_t_h_url_content_type" "$_u_t_h_url"
  elif ! is_empty "$_u_t_h_retry"; then
     exec_combine_default_with_std_out_base $http_test_tool -vbp "-c$_u_t_h_concurrent" "-r$_u_t_h_retry" --header="$_u_t_h_url_header" --user-agent="$_u_t_h_url_user_agent" --content-type="$_u_t_h_url_content_type" "$_u_t_h_url"
  else
    exec_combine_default_with_std_out_base $http_test_tool -vbp "-c$_u_t_h_concurrent" "-t10S" --header="$_u_t_h_url_header" --user-agent="$_u_t_h_url_user_agent" --content-type="$_u_t_h_url_content_type" "$_u_t_h_url"
  fi
}

u_run() {
  determine_de
  check_run_empty "$@"

  read_config_run_list | while IFS=: read -r _u_r_name _u_r_description _u_r_command; do
    if is_empty "$_u_r_name" && is_empty "$_u_r_description" && is_empty "$_u_r_command"; then
      continue
    fi

    for _u_r_arg in "$@"; do
        if is_equal "$_u_r_arg" "$_u_r_name"; then
          printf "\n${color_green}$_u_r_name${color_reset} >_ ${color_cyan}$_u_r_command${color_reset}%b\n\n"
          exec_combine_default_f_with_std_out "$_u_r_command"
        fi
    done
  done
}

u_set_run() {
  printf "%b" "$command_run_set_name "

  _u_s_r_name=$(read_func)

  if is_empty "$_u_s_r_name"; then
    echo_exit "$command_run_set_name_empty"
  fi

  if is_contain "$_u_s_r_name" ":"; then
    echo_exit "$command_run_set_name_contain_colon"
  fi

  _u_s_r_name_exist=$(read_config_run_list | while IFS=: read -r _u_s_r_name_config _ _; do
    if is_equal "$_u_s_r_name" "$_u_s_r_name_config"; then
      echo_exit "exist"
    fi
  done)

  if is_equal "$_u_s_r_name_exist" "exist"; then
    echo_exit "$command_run_set_name_exist"
  fi

  printf "%b" "$command_run_set_description "

  _u_s_r_description=$(read_func)

  if is_contain "$_u_s_r_description" ":"; then
    echo_exit "$command_run_set_description_contain_colon"
  fi

  printf "%b" "$command_run_set_command "

  _u_s_r_command=$(read_func)

  if is_empty "$_u_s_r_command"; then
    echo_exit "$command_run_set_command_empty"
  fi

  _u_s_r_cfg=$(append_config_run_list "$_u_s_r_name:$_u_s_r_description:$_u_s_r_command")

  write_config_run_list "$_u_s_r_cfg"

  echo "$command_run_set_registered"
}

u_list_run() {
  _u_l_r_cfg="$(read_config_run_list)"

  if is_empty "$_u_l_r_cfg"; then
    echo_exit "$command_run_list_empty"
  fi

  echo "$_u_l_r_cfg" | while IFS=: read -r _u_l_r_name _u_l_r_description _u_l_r_command; do
    if is_empty "$_u_l_r_name" && is_empty "$_u_l_r_description" && is_empty "$_u_l_r_command"; then
      continue
    fi

    printf "${color_green}%-20s ${color_reset}%-30s ${color_cyan}%b${color_reset}\n" "$_u_l_r_name" "$_u_l_r_description" "$_u_l_r_command"
  done
}

u_prompt() {
  determine_distro
  determine_ai
  install_needed $json_tool
  check_ai
  printf_ai_info

  _u_p_response=$(make_http_request_ai "$@")

  echo_typing "$(echo "$_u_p_response" | markdown_parse)"
}

u_set_ai() {
  set_tmp_ai_type
  set_tmp_ai_model "$tmp_ai_type"
  set_tmp_ai_api_key "$tmp_ai_type"

  write_config_ai "$tmp_ai_type
$tmp_ai_model
$tmp_ai_api_key"

  echo "$command_set_ai_registered"
}

u_start_chat() {
  determine_distro
  determine_ai
  check_ai
  printf_ai_info

  echo_exit "$feature_is_not_implemented_yet"
}

u_show_ai() {
  determine_ai
  check_ai
  printf_ai_info_complete
}

u_change_ai_type() {
  determine_ai
  check_ai
  set_tmp_ai_type

  change_file_content_line "1" "$tmp_ai_type" "$config_ai_filepath"

  echo "$ok"
}

u_change_ai_model() {
  determine_ai
  check_ai

  _u_c_a_m_type=$(sed -n '1p' "$config_ai_filepath")

  set_tmp_ai_model "$_u_c_a_m_type"

  change_file_content_line "2" "$tmp_ai_model" "$config_ai_filepath"

  echo "$ok"
}

u_change_ai_api_key() {
  determine_ai
  check_ai

  _u_c_a_a_k_type=$(sed -n '1p' "$config_ai_filepath")

  set_tmp_ai_api_key "$_u_c_a_a_k_type"

  change_file_content_line "3" "$tmp_ai_api_key" "$config_ai_filepath"

  echo "$ok"
}

# echo

echo_exit() {
  echo "$1"
  exit 0
}

echo_typing() {
  __e_t_text=$(printf "%b" "$1" | sed 's/$/\\n/' | tr -d '\n')
  __e_t_i=0

  while [ $__e_t_i -lt ${#__e_t_text} ]; do
    # shellcheck disable=SC2004
    __e_t_char=$(printf "%s" "$__e_t_text" | cut -c $(($__e_t_i+1)))

    if is_equal "$__e_t_char" "\\"; then
      # shellcheck disable=SC2004
      __e_t_next_char=$(printf "%s" "$__e_t_text" | cut -c $(($__e_t_i+2)))
      if is_equal "$__e_t_next_char" "n"; then
        printf "\n"
        # shellcheck disable=SC2004
        __e_t_i=$(($__e_t_i + 1))
      fi
    else
      printf "%b" "$__e_t_char"
    fi

    sleep "$typing_speed"
    # shellcheck disable=SC2004
    __e_t_i=$(($__e_t_i + 1))
  done

  echo
}

# printf

printf_exit() {
  printf "$1%b\n"
  exit 0
}

printf_ai_info() {
  printf "${color_yellow}$ai ($(get_ai_model))${color_reset} :%b\n\n"
}

printf_ai_info_complete() {
  __p_a_i_c_api_key="* * * * *"

  if is_empty "$(get_ai_api_key)"; then
    __p_a_i_c_api_key=""
  fi

  printf "Type: ${color_yellow}$ai\n${color_reset}Model: ${color_yellow}$(get_ai_model)\n${color_reset}API key: ${color_blue}$__p_a_i_c_api_key${color_reset}%b\n"
}

# check

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

check_play_empty() {
  if is_no_argument "$@"; then
    echo_exit "$play_empty"
  fi
}

check_run_empty() {
  if is_no_argument "$@"; then
    echo_exit "$run_empty"
  fi
}

check_prompt_empty() {
  if is_no_argument "$@"; then
    echo_exit "$prompt_empty"
  fi
}

check_change_empty() {
  if is_no_argument "$@"; then
    echo_exit "$change_empty"
  fi
}

check_ai() {
  check_ai_empty
  check_ai_url_empty
#  check_ai_api_key_empty
  check_ai_model_empty
}

check_ai_empty() {
  if is_ai_google; then
    return 0
  fi

  printf_exit "$ai_empty"
}

check_ai_url_empty() {
  if is_ai_google; then
    if ! is_empty "$generative_ai_url"; then
      return 0
    fi
  fi

  printf_exit "$ai_url_empty"
}

check_ai_api_key_empty() {
  if is_ai_google; then
    if ! is_empty "$gemini_api_key"; then
      return 0
    fi
  fi

  printf_exit "$ai_api_key_empty"
}

check_ai_model_empty() {
  if is_ai_google; then
    if ! is_empty "$gemini_model"; then
      return 0
    fi
  fi

  printf_exit "$ai_model_empty"
}

# is

is_equal() {
  [ "$1" = "$2" ]
}

is_empty() {
  is_equal "$1" ""
}

is_contain() {
  echo "$1" | grep -q "$2"
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
  is_equal "$distro" "unknown"
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
  is_equal "$ai" "google"
}

# get

get_ai_url() {
  if is_ai_google; then
    echo "$generative_ai_url"
  fi
}

get_ai_model() {
  if is_ai_google; then
    echo "$gemini_model"
  fi
}

get_ai_api_key() {
  if is_ai_google; then
    echo "$gemini_api_key"
  fi
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
    return 0
  else
    if is_user_package_exist "$1"; then
      return 0
    else
      printf "${color_red}$1 ${color_reset}$package_not_installed%b\n"

      __i_n_confirmation=$(read_func)

      if is_equal "$__i_n_confirmation" "y"; then
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
  eval "$@" > /dev/null 2>&1 &
}

exec_async_no_std_out_base() {
  exec "$@" > /dev/null 2>&1 &
}

exec_async_f_with_std_out() {
  eval "$@" &
}

exec_async_f_with_std_out_base() {
  exec "$@" &
}

exec_async_no_std_out_i3wm() {
  i3wm_split_lr
  exec_async_no_std_out "$@"
  i3wm_focus_r
  i3wm_focus_l
}
exec_async_no_std_out_i3wm_base() {
  i3wm_split_lr
  exec_async_no_std_out_base "$@"
  i3wm_focus_r
  i3wm_focus_l
}

exec_async_f_with_std_out_i3wm() {
  i3wm_split_lr
  exec_async_f_with_std_out "$@"
  i3wm_focus_r
  i3wm_focus_l
}
exec_async_f_with_std_out_i3wm_base() {
  i3wm_split_lr
  exec_async_f_with_std_out_base "$@"
  i3wm_focus_r
  i3wm_focus_l
}

exec_default() {
  eval "$@" 2> /dev/null
}

exec_default_base() {
  exec "$@" 2> /dev/null
}

exec_default_with_std_out() {
  eval "$@"
}

exec_default_with_std_out_base() {
  exec "$@"
}

exec_default_f_with_std_out() {
  eval "$@"
}

exec_default_f_with_std_out_base() {
  exec "$@"
}

exec_default_i3wm() {
  i3wm_split_lr
  exec_default "$@"
  i3wm_focus_r
  i3wm_focus_l
}

exec_default_i3wm_base() {
  i3wm_split_lr
  exec_default_base "$@"
  i3wm_focus_r
  i3wm_focus_l
}

exec_default_with_std_out_i3wm() {
  i3wm_split_lr
  exec_default_with_std_out "$@"
  i3wm_focus_r
  i3wm_focus_l
}

exec_default_with_std_out_i3wm_base() {
  i3wm_split_lr
  exec_default_with_std_out_base "$@"
  i3wm_focus_r
  i3wm_focus_l
}

exec_default_f_with_std_out_i3wm() {
  i3wm_split_lr
  exec_default_f_with_std_out "$@"
  i3wm_focus_r
  i3wm_focus_l
}

exec_default_f_with_std_out_i3wm_base() {
  i3wm_split_lr
  exec_default_f_with_std_out_base "$@"
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

exec_combine_async_no_std_out_base() {
  if is_de_i3wm; then
    exec_async_no_std_out_i3wm_base "$@"
  else
    exec_async_no_std_out_base "$@"
  fi
}

exec_combine_async_f_with_std_out() {
  if is_de_i3wm; then
    exec_async_f_with_std_out_i3wm "$@"
  else
    exec_async_f_with_std_out "$@"
  fi
}

exec_combine_async_f_with_std_out_base() {
  if is_de_i3wm; then
    exec_async_f_with_std_out_i3wm_base "$@"
  else
    exec_async_f_with_std_out_base "$@"
  fi
}

exec_combine_default() {
  if is_de_i3wm; then
    exec_default_i3wm "$@"
  else
    exec_default "$@"
  fi
}

exec_combine_default_base() {
  if is_de_i3wm; then
    exec_default_i3wm_base "$@"
  else
    exec_default_base "$@"
  fi
}

exec_combine_default_with_std_out() {
  if is_de_i3wm; then
    exec_default_with_std_out_i3wm "$@"
  else
    exec_default_with_std_out "$@"
  fi
}

exec_combine_default_with_std_out_base() {
  if is_de_i3wm; then
    exec_default_with_std_out_i3wm_base "$@"
  else
    exec_default_with_std_out_base "$@"
  fi
}

exec_combine_default_f_with_std_out() {
  if is_de_i3wm; then
    exec_default_f_with_std_out_i3wm "$@"
  else
    exec_default_f_with_std_out "$@"
  fi
}

exec_combine_default_f_with_std_out_base() {
  if is_de_i3wm; then
    exec_default_f_with_std_out_i3wm_base "$@"
  else
    exec_default_f_with_std_out_base "$@"
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

determine_ai() {
  if ! is_file_exist "$config_ai_filepath"; then
    return 0
  fi

  __d_a_type=$(sed -n '1p' "$config_ai_filepath")
  __d_a_model=$(sed -n '2p' "$config_ai_filepath")
  __d_a_api_key=$(sed -n '3p' "$config_ai_filepath")

  if is_equal "$__d_a_type" "1"; then
    ai="google"
  fi

  if is_ai_google; then
    if is_equal "$__d_a_model" "1"; then
      gemini_model="$gemini_model_1"
    elif is_equal "$__d_a_model" "2"; then
      gemini_model="$gemini_model_2"
    elif is_equal "$__d_a_model" "3"; then
      gemini_model="$gemini_model_3"
    fi

    gemini_api_key="$__d_a_api_key"
  fi
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

# create

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

create_config() {
  create_dir "$config_dir"
  create_file "$config_run_list_filepath"
  create_file "$config_ai_filepath"
}

# write

write_to_file() {
  echo "$1" > "$2"
}

write_config_run_list() {
  write_to_file "$1" "$config_run_list_filepath"
}

write_config_ai() {
  write_to_file "$1" "$config_ai_filepath"
}

# read

read_file_content() {
  if ! is_file_exist "$1"; then
    printf_exit "${color_red}$1 ${color_reset}$file_not_found"
  fi

  cat "$1"
}

read_config_run_list() {
  read_file_content "$config_run_list_filepath"
}

read_config_ai() {
  read_file_content "$config_ai_filepath"
}

read_func() {
  read -r _r_f_input < /dev/tty

  echo "$_r_f_input"
}

# set

set_tmp_ai_type() {
  printf "%b" "$command_set_ai_type "

  __s_t_a_t_type=$(read_func)

  if is_empty "$__s_t_a_t_type"; then
    echo_exit "$command_set_ai_type_empty"
  fi

  if ! is_equal "$__s_t_a_t_type" "1"; then
    echo_exit "$command_set_ai_type_wrong"
  fi

  tmp_ai_type="$__s_t_a_t_type"
}

set_tmp_ai_model() {
  if is_equal "$1" "1"; then
    printf "%b" "$command_set_ai_model_google "
  else
    echo_exit "$command_set_ai_type_wrong"
  fi

  _s_t_a_m_model=$(read_func)

  if is_empty "$_s_t_a_m_model"; then
    echo_exit "$command_set_ai_model_empty"
  fi

  if is_equal "$1" "1"; then
    if ! is_equal "$_s_t_a_m_model" "1" && ! is_equal "$_s_t_a_m_model" "2" && ! is_equal "$_s_t_a_m_model" "3"; then
      echo_exit "$command_set_ai_model_wrong"
    fi
  fi

  tmp_ai_model="$_s_t_a_m_model"
}

set_tmp_ai_api_key() {
  if is_equal "$1" "1"; then
    printf "%b" "$command_set_ai_api_key_google "
  else
    echo_exit "$command_set_ai_type_wrong"
  fi

  _s_t_a_a_k_api_key=$(read_func)

  if is_equal "$1" "1"; then
    if is_empty "$_s_t_a_a_k_api_key"; then
      echo_exit "$command_set_ai_api_key_empty"
    fi
  fi

  tmp_ai_api_key="$_s_t_a_a_k_api_key"
}

# append

append_config_run_list() {
  echo "$(read_config_run_list)
$1"
}

# change

change_file_content_line() {
  sed -i "$1s/.*/$2/" "$3"
}

# make http request

make_http_request() {
  __m_h_r_url=""
  __m_h_r_content_type="application/json"
  __m_h_r_method="POST"
  __m_h_r_request_body=""

  while [ $# -gt 0 ]; do
    case "$1" in
      -url)
        __m_h_r_url="${1#-url}"
        if [ -z "$__m_h_r_url" ]; then
          shift
          __m_h_r_url="$1"
        fi
        ;;
      -contentType)
        __m_h_r_content_type="${1#-contentType}"
        if [ -z "$__m_h_r_content_type" ]; then
          shift
          __m_h_r_content_type="$1"
        fi
        ;;
      -method)
        __m_h_r_method="${1#-method}"
        if [ -z "$__m_h_r_method" ]; then
          shift
          __m_h_r_method="$1"
        fi
        ;;
      -requestBody)
        __m_h_r_request_body="${1#-requestBody}"
        if [ -z "$__m_h_r_request_body" ]; then
          shift
          __m_h_r_request_body="$1"
        fi
        ;;
    esac
    shift
  done

  curl "$__m_h_r_url" -H "Content-Type: $__m_h_r_content_type" -X "$__m_h_r_method" -d "$__m_h_r_request_body"
}

make_http_request_ai() {
  make_http_request_google_ai "$@"
}

make_http_request_google_ai() {
  if ! is_ai_google; then
    return 0
  fi

  check_prompt_empty "$@"

  __m_h_r_g_a_prompt=""

  for __m_h_r_g_a_arg in "$@"; do
    if is_empty "$__m_h_r_g_a_prompt"; then
      __m_h_r_g_a_prompt="$__m_h_r_g_a_arg"
    else
      __m_h_r_g_a_prompt="$__m_h_r_g_a_prompt $__m_h_r_g_a_arg"
    fi
  done

  __m_h_r_g_a_http_response=$(make_http_request -url "$(get_ai_url)/$(get_ai_model):generateContent?key=$(get_ai_api_key)" -requestBody "
    {
      \"contents\": [{
        \"parts\":[
          {\"text\": \"$__m_h_r_g_a_prompt\"}
        ]
      }],
      \"generationConfig\": {
        \"temperature\": 0.9
      }
    }"
  )

  echo

  __m_h_r_g_a_text=$(printf '%s\n' "$__m_h_r_g_a_http_response" | jq -r '.candidates[0].content.parts[0].text')

  if is_equal "$__m_h_r_g_a_text" "null"; then
    echo_exit "$__m_h_r_g_a_http_response"
  fi

  echo "$__m_h_r_g_a_text"
}

# markdown

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

create_config
umar "$@"
