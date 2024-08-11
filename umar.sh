#!/bin/sh

# config

version="v1.3.1"
pid=$$
search_url="https://www.google.com/search?q="
distro="unknown"
de="unknown"
user_package_dir="/usr/local/bin"
config_dir="$HOME/.umar"
config_run_list_filepath="$config_dir/run-list.cfg"
config_ai_filepath="$config_dir/ai.cfg"
config_tmp_value_filepath="$config_dir/tmp_value.cfg"
config_tmp_error_filepath="$config_dir/tmp_error.cfg"
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
typing_speed=0.005
http_header="X-HELLO:X-WORLD"

# message

message_umar="I am Umar ($version), your Linux assistant. I can help you with the common tasks listed below. \
I will continue to be updated indefinitely, as my creator may need to add new features, update my logic, fix issues, \
or make other changes. I may get smarter every day. I can also use AI, but you need to manually set up the configuration first."
message_package_not_found="package not found!"
message_invalid_command="Sorry, I can't understand your command"
message_kill_confirmation="All processes listed above will be terminated. Are you sure? [N/y]"
message_all_process_terminated="All processes have been terminated!"
message_aborted="Operation aborted!"
message_test_http_no_url="Please provide a URL to test!
Use this option: ${color_cyan}-u ${color_blue}URL${color_reset}"
message_run_list_empty="No custom commands have been set"
message_run_set_name="Enter a name..."
message_run_set_name_contain_colon="The name can't contain a colon!"
message_run_set_name_exist="The name already exists!"
message_run_set_name_empty="The name can't be empty!"
message_run_set_description="Enter a description..."
message_run_set_description_contain_colon="The description can't contain a colon!"
message_run_set_command="Enter the execution command..."
message_run_set_command_empty="The execution command can't be empty!"
message_ok="OK"
message_set_ai_type="AI type:

1. Google

Choose the AI type number..."
message_set_ai_type_empty="AI type can't be empty!"
message_set_ai_type_wrong="You chose the wrong AI type number!"
message_set_ai_model_google="
AI model:

1. Gemini 1.0 Pro
2. Gemini 1.5 Pro
3. Gemini 1.5 Flash

Choose the AI model number..."
message_set_ai_model_empty="AI model can't be empty!"
message_set_ai_model_wrong="You chose the wrong AI model number!"
message_set_ai_api_key_google="
You'll need an API key to use the AI. You can follow this documentation -> https://ai.google.dev/gemini-api/docs/api-key

Enter the API key..."
message_set_ai_api_key_empty="API Key can't be empty!"
message_set_ai_registered="AI configuration registered"
message_kill_empty="You didn't provide any names to kill!"
message_open_empty="You didn't provide any names to open!"
message_install_empty="You didn't provide any names to install!"
message_remove_empty="You didn't provide any names to remove!"
message_show_empty="You didn't provide any names to show!"
message_play_empty="You didn't provide any names to play!"
message_run_empty="You didn't provide any commands to run!"
message_prompt_empty="You didn't provide any prompt text!"
message_change_empty="You didn't provide new content to change!"
message_search_empty="You didn't provide any keywords to search!"
message_ai_empty="You didn't provide any AI type to process!
You can use this command to set up a new one: ${color_cyan}umar set ai${color_reset}"
message_ai_url_empty="You didn't provide any AI URL to process!
You can use this command to set up a new one: ${color_cyan}umar set ai${color_reset}"
message_ai_model_empty="You didn't provide any AI model to process!
You can use this command to set up a new one: ${color_cyan}umar set ai${color_reset}"
message_file_not_found="file not found!"
message_unknown_distro="Unknown distribution!"
message_package_not_installed="The package is not installed. Do you want to install it? [N/y]"
message_package_needed="I need that package(s) to process the command!"
message_package_needed_installed="The required package(s) have been installed. Refresh the current console/terminal session and run the command again"
message_feature_is_not_implemented_yet="This feature is not implemented yet!"
message_press_enter_to_exit="Press Enter to exit"
message_failed="Operation failed!"
message_command_not_found="command not found!"
message_caution_plain="BE CAREFUL ABOUT WHAT YOU TYPE, MAKE SURE THERE IS NOTHING THAT CAN BREAK YOUR SYSTEM"
message_caution="${color_red}**$message_caution_plain**${color_reset}"
message_chat_typing="${color_yellow}>_${color_reset}"

# command

commands="get smarter:Upgrade me to the latest version
version:Show my current version
reveal:Reveal my source code
window:Open my command window. ${color_yellow}**You may create a keyboard shortcut for this command to open my command window directly**${color_reset}
--------------:--------------------------
run:Run custom command(s)
list run:List registered custom command(s)
set run:Set new custom command
--------------:--------------------------
prompt:Prompt anything to AI
start chat:Start a new chat session with AI
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
test http:Test and benchmark HTTP URL -> \`${color_cyan}-c ${color_blue}NUM ${color_cyan}-r ${color_blue}NUM ${color_cyan}-t \
${color_blue}SECONDS ${color_cyan}-header ${color_blue}TEXT ${color_cyan}-userAgent ${color_blue}TEXT ${color_cyan}-contentType \
${color_blue}TEXT ${color_cyan}-u ${color_blue}URL${color_reset}\`
show image:Show image(s)
play audio:Play audio(s)
play video:Play video(s)
"

# umar

umar() {
  determine_distro
  determine_de
  determine_ai
  create_config
  check_requirements "sh"

  if is_no_argument "$@"; then
    printf_func "\n$message_umar\n"

    echo "$commands" | while IFS=: read -r _u_name _u_description; do
      printf "${color_green}%-20s ${color_reset}%b\n" "$_u_name" "$(echo "$_u_description" | markdown_parse)"
    done

    printf_func "$(echo "$message_caution" | markdown_parse)\n"

    return 0
  fi

  case "$1 $2 $3 $4" in
    "change ai api key")
      check_ai
      set_ai_api_key

      change_file_content_line "3" "$tmp_ai_api_key" "$config_ai_filepath"
      echo "$message_ok"

      return 0
      ;;
  esac

  case "$1 $2 $3" in
    "change ai type")
      check_ai
      set_ai_type

      change_file_content_line "1" "$tmp_ai_type" "$config_ai_filepath"
      echo "$message_ok"

      return 0
      ;;

    "change ai model")
      check_ai
      set_ai_model

      change_file_content_line "2" "$tmp_ai_model" "$config_ai_filepath"
      echo "$message_ok"

      return 0
      ;;
  esac

  case "$1 $2" in
    "get smarter")
      check_requirements "curl" "sudo"

      curl -L "$repo_url/$script_name" -o "/tmp/$script_name"
      sudo mv "/tmp/$script_name" "$install_dir/$target_name"
      sudo chmod +x "$install_dir/$target_name"

      if [ -x "$install_dir/$target_name" ]; then
        echo_exit "$message_ok"
      else
        echo_exit "$message_failed"
      fi

      return 0
      ;;

    "list run")
      _u_cfg="$(read_config_run_list)"

      if is_empty "$_u_cfg"; then
        echo_exit "$message_run_list_empty"
      fi

      echo "$_u_cfg" | while IFS=: read -r _u_name _u_description _u_command; do
        if is_empty "$_u_name" && is_empty "$_u_description" && is_empty "$_u_command"; then
          continue
        fi

        printf "${color_green}%-20s ${color_reset}%-30s ${color_cyan}%b${color_reset}\n" "$_u_name" "$_u_description" "$_u_command"
      done

      return 0
      ;;

    "set run")
      printf_func_no_enter "$message_run_set_name "

      _u_name=$(read_func)

      if is_empty "$_u_name"; then
        echo_exit "$message_run_set_name_empty"
      fi

      if is_contain "$_u_name" ":"; then
        echo_exit "$message_run_set_name_contain_colon"
      fi

      _u_name_exist=$(read_config_run_list | while IFS=: read -r _u_name_config _ _; do
        if is_equal "$_u_name" "$_u_name_config"; then
          echo_exit "exist"
        fi
      done)

      if is_equal "$_u_name_exist" "exist"; then
        echo_exit "$message_run_set_name_exist"
      fi

      printf_func_no_enter "$message_run_set_description "

      _u_description=$(read_func)

      if is_contain "$_u_description" ":"; then
        echo_exit "$message_run_set_description_contain_colon"
      fi

      printf_func_no_enter "$message_run_set_command "

      _u_command=$(read_func)

      if is_empty "$_u_command"; then
        echo_exit "$message_run_set_command_empty"
      fi

      _u_cfg=$(append_config_run_list "$_u_name:$_u_description:$_u_command")

      write_config_run_list "$_u_cfg"

      echo "$message_ok"

      return 0
      ;;

    "show image")
      shift
      shift

      check_show_empty "$@"
      check_requirements "feh"
      feh "$@" &

      return 0
      ;;

    "play audio")
      shift
      shift

      check_play_empty "$@"
      check_requirements "mpg123"
      mpg123 -v "$@"

      return 0
      ;;

    "play video")
      shift
      shift

      check_play_empty "$@"
      check_requirements "mpv"
      mpv "$@" > /dev/null 2>&1 &

      return 0
      ;;

    "test http")
      shift
      shift

      check_requirements "siege"

      _u_concurrent="10"
      _u_time=""
      _u_retry=""
      _u_url=""
      _u_url_header="$http_header"
      _u_url_user_agent=""
      _u_url_content_type=""

      while [ $# -gt 0 ]; do
        case "$1" in
          -c)
            _u_concurrent="${1#-c}"
            if [ -z "$_u_concurrent" ]; then
              shift
              _u_concurrent="$1"
            fi
            ;;
          -t)
            _u_time="${1#-t}"
            if [ -z "$_u_time" ]; then
              shift
              _u_time="$1"
            fi
            ;;
          -r)
            _u_retry="${1#-r}"
            if [ -z "$_u_retry" ]; then
              shift
              _u_retry="$1"
            fi
            ;;
          -u)
            _u_url="${1#-u}"
            if [ -z "$_u_url" ]; then
              shift
              _u_url="$1"
            fi
            ;;
          -userAgent)
            _u_url_user_agent="${1#-userAgent}"
            if [ -z "$_u_url_user_agent" ]; then
              shift
              _u_url_user_agent="$1"
            fi
            ;;
          -header)
            _u_url_header="${1#-header}"
            if [ -z "$_u_url_header" ]; then
              shift
              _u_url_header="$1"
            fi
            ;;
          -contentType)
            _u_url_content_type="${1#-contentType}"
            if [ -z "$_u_url_content_type" ]; then
              shift
              _u_url_content_type="$1"
            fi
            ;;
        esac
        shift
      done

      if is_empty "$_u_url"; then
        printf_exit "$message_test_http_no_url"
      fi

      printf_func "url=$_u_url | concurrent=$_u_concurrent | time=${_u_time}S | retry=$_u_retry | header=$_u_url_header | userAgent=$_u_url_user_agent | contentType=$_u_url_content_type\n"

      if ! is_empty "$_u_time"; then
         exec_func siege -vbp "-c$_u_concurrent" "-t${_u_time}S" --header="$_u_url_header" --user-agent="$_u_url_user_agent" --content-type="$_u_url_content_type" "$_u_url"
      elif ! is_empty "$_u_retry"; then
         exec_func siege -vbp "-c$_u_concurrent" "-r$_u_retry" --header="$_u_url_header" --user-agent="$_u_url_user_agent" --content-type="$_u_url_content_type" "$_u_url"
      else
        exec_func siege -vbp "-c$_u_concurrent" "-t10S" --header="$_u_url_header" --user-agent="$_u_url_user_agent" --content-type="$_u_url_content_type" "$_u_url"
      fi

      return 0
      ;;

    "set ai")
      set_ai_type
      set_ai_model
      set_ai_api_key

      write_config_ai "$(printf_func "$tmp_ai_type\n$tmp_ai_model\n$tmp_ai_api_key")"
      echo "$message_set_ai_registered"

      return 0
      ;;

    "start chat")
      check_ai
      printf_ai_info

      _u_prompt=""

      while true; do
        printf_func_no_enter "$message_chat_typing "

        _u_chat_prompt="$(read_func)"
        _u_chat_prompt=$(generate_google_ai_prompt "user" "$_u_chat_prompt")

        if is_empty "$_u_prompt"; then
          _u_prompt="$_u_chat_prompt"
        else
          _u_prompt="$_u_prompt $_u_chat_prompt"
        fi

        _u_response=""

        echo

        if is_ai_google; then
          _u_response=$(make_http_request_google_ai "$(echo "$_u_prompt" | remove_trailing_comma)")
        fi

        _u_prompt="$_u_prompt $(generate_google_ai_prompt "model" "$_u_response")"

        echo_typing "$(echo "$_u_response" | markdown_parse)"

        echo
      done

      return 0
      ;;

    "show ai")
      check_ai

      _u_api_key="* * * * *"

      if is_empty "$(get_ai_api_key)"; then
        _u_api_key=""
      fi

      printf_func "Type: ${color_yellow}$ai\n${color_reset}Model: ${color_yellow}$(get_ai_model)\n${color_reset}API key: ${color_blue}$_u_api_key${color_reset}"

      return 0
      ;;
  esac

  case "$1" in
    "open")
      shift

      check_open_empty "$@"

      _u_not_exist=""

      for _u_arg in "$@"; do
        if is_package_exist "$_u_arg" || is_user_package_exist "$_u_arg"; then
          exec_func_async_no_std_out "$_u_arg"

          continue
        fi

        _u_not_exist="yes"

        printf_func "${color_red}$_u_arg ${color_reset}$message_package_not_found"
      done

      if ! is_equal "$_u_not_exist" "yes"; then
        clear_shell
      fi

      return 0
      ;;

    "kill")
      shift

      check_kill_empty "$@"
      check_requirements "sudo"

      _u_process_list=""

      echo

      for _u_arg in "$@"; do
        # shellcheck disable=SC2009
        _u_process_list="$_u_process_list\n$(ps -ef | grep "$_u_arg" | grep -v "$pid" | awk '{print $2}')"

        # shellcheck disable=SC2009
        ps aux | grep "$_u_arg" | grep -v "$pid"
      done

      _u_process_list=$(printf_func "$_u_process_list")

      printf_func_no_enter "\n$message_kill_confirmation "

      _u_confirmation=$(read_func)

      if ! is_equal "$_u_confirmation" "y"; then
        printf_func "\n$message_aborted"

        return 0
      fi

      echo "$_u_process_list" | while IFS= read -r _u_line; do
        if ! is_empty "$_u_line"; then
          sudo kill -9 "$_u_line" > /dev/null 2>&1
        fi
      done

      printf_func "\n$message_all_process_terminated"

      return 0
      ;;

    "search")
      shift

      check_search_empty "$@"
      check_requirements "w3m"
      exec_func w3m "$search_url$(echo "$*" | sed 's/ /+/g')"

      clear_shell

      return 0
      ;;

    "install")
      shift

      check_install_empty "$@"
      install_func "$@"

      return 0
      ;;

    "remove")
      shift

      check_remove_empty "$@"
      remove_func "$@"

      return 0
      ;;

    "upgrade")
      shift

      upgrade_func "$@"

      return 0
      ;;

    "version")
      echo "$version"

      return 0
      ;;

    "reveal")
      check_requirements "vim"
      exec_func vim -R "$install_dir/$target_name"

      return 0
      ;;

    "run")
      shift

      check_run_empty "$@"
      set_tmp_value "not exist"

      for _u_arg in "$@"; do
        read_config_run_list | while IFS=: read -r _u_name _u_description _u_command; do
          if is_empty "$_u_name" && is_empty "$_u_description" && is_empty "$_u_command"; then
            continue
          fi

          if is_equal "$_u_arg" "$_u_name"; then
            set_tmp_value "exist"
            printf_func "\n${color_green}$_u_name${color_reset} >_ ${color_cyan}$_u_command${color_reset}\n"
            eval_func "$_u_command"

            echo
            break
          fi
        done

        if ! is_equal "$(get_tmp_value)" "exist"; then
          printf_func "${color_green}$_u_arg${color_reset} $message_command_not_found"
        fi
      done

      return 0
      ;;

    "prompt")
      shift
      check_prompt_empty "$@"

      check_ai
      printf_ai_info

      _u_response=""

      if is_ai_google; then
        _u_response=$(make_http_request_google_ai "$(generate_google_ai_prompt "user" "$@" | remove_trailing_comma)")
      fi

      echo_typing "$(echo "$_u_response" | markdown_parse)"

      return 0
      ;;

    "window")
      _u_command=$(open_and_read_float_window)

      if is_empty "$_u_command"; then
        return 0
      fi

      if ! is_start_with "$_u_command" "umar"; then
        _u_command="umar $_u_command"
      fi

      if is_start_with "$_u_command" "umar help"; then
        open_terminal_and_exec_wait "umar"
      elif is_start_with "$_u_command" "umar show image" || is_start_with "$_u_command" "umar play video"; then
        eval_func "$_u_command"
      elif is_start_with "$_u_command" "umar open"; then
        $_u_command
      elif is_start_with "$_u_command" "umar search" || is_start_with "$_u_command" "umar play audio"; then
        open_terminal_and_exec "$_u_command"
      else
        open_terminal_and_exec_wait "$_u_command"
      fi

      return 0
      ;;
  esac

  echo "$message_invalid_command"
}

# echo

echo_exit() {
  echo "$1"
  set_tmp_error "$1"

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

printf_func() {
  printf "$1%b\n"
}

printf_func_no_enter() {
  printf "$1%b"
}

printf_exit() {
  printf_func "$1"
  set_tmp_error "$1"

  exit 0
}

printf_ai_info() {
  printf_func "${color_yellow}$ai ($(get_ai_model))${color_reset}\n"
}

# check

check_kill_empty() {
  if is_no_argument "$@"; then
    echo_exit "$message_kill_empty"
  fi
}

check_open_empty() {
  if is_no_argument "$@"; then
    echo_exit "$message_open_empty"
  fi
}

check_install_empty() {
  if is_no_argument "$@"; then
    echo_exit "$message_install_empty"
  fi
}

check_remove_empty() {
  if is_no_argument "$@"; then
    echo_exit "$message_remove_empty"
  fi
}

check_show_empty() {
  if is_no_argument "$@"; then
    echo_exit "$message_show_empty"
  fi
}

check_play_empty() {
  if is_no_argument "$@"; then
    echo_exit "$message_play_empty"
  fi
}

check_run_empty() {
  if is_no_argument "$@"; then
    echo_exit "$message_run_empty"
  fi
}

check_prompt_empty() {
  if is_no_argument "$@"; then
    echo_exit "$message_prompt_empty"
  fi
}

check_change_empty() {
  if is_no_argument "$@"; then
    echo_exit "$message_change_empty"
  fi
}

check_search_empty() {
  if is_no_argument "$@"; then
    echo_exit "$message_search_empty"
  fi
}

check_ai() {
  if ! is_ai_google; then
    printf_exit "$message_ai_empty"
  fi

  if is_ai_google && is_empty "$generative_ai_url"; then
    printf_exit "$message_ai_url_empty"
  fi

  if is_ai_google && is_empty "$gemini_model"; then
    printf_exit "$message_ai_model_empty"
  fi
}

check_requirements() {
  __i_n_not_exist=""

  for __i_n_arg in "$@"; do
    if is_package_exist "$__i_n_arg" || is_user_package_exist "$__i_n_arg"; then
        continue
    fi

    if is_empty "$__i_n_not_exist"; then
      __i_n_not_exist="$__i_n_arg"
    else
      __i_n_not_exist="$__i_n_not_exist $__i_n_arg"
    fi
  done

  if is_empty "$__i_n_not_exist"; then
    return 0
  fi

  printf_func_no_enter "${color_red}$__i_n_not_exist ${color_reset}$message_package_not_installed "

  __i_n_confirmation=$(read_func)

  if ! is_equal "$__i_n_confirmation" "y"; then
    printf_exit "\n$message_package_needed"
  fi

  if is_unknown; then
    printf_func "\n$message_unknown_distro"
    printf_exit "$message_package_needed"
  fi

  install_func_arg_split "$__i_n_not_exist"

  echo "$message_package_needed_installed"
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

get_tmp_value() {
  if ! is_file_exist "$config_tmp_value_filepath"; then
    return 0
  fi

  read_file_content "$config_tmp_value_filepath"

  clear_tmp_value
}

get_tmp_error() {
  if ! is_file_exist "$config_tmp_error_filepath"; then
    return 0
  fi

  read_file_content "$config_tmp_error_filepath"

  clear_tmp_error
}

# install

install_func() {
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

install_func_arg_split() {
  # shellcheck disable=SC2068
  install_func $@
}

# remove

remove_func() {
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

# upgrade

upgrade_func() {
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

# exec

exec_func() {
  if is_de_i3wm; then
    i3-msg split h > /dev/null 2>&1
  fi

  if is_equal "$1" "__exec_func_async=true"; then
    shift
    exec "$@" &
  elif is_equal "$1" "__exec_func_async_no_std_out=true"; then
    shift
    exec "$@" > /dev/null 2>&1 &
  elif is_equal "$1" "__exec_func_no_std_out=true"; then
    shift
    exec "$@" > /dev/null 2>&1
  elif is_equal "$1" "__eval_func=true"; then
    shift
    eval "$@"
  elif is_equal "$1" "__eval_func_async=true"; then
    shift
    eval "$@" &
  elif is_equal "$1" "__eval_func_async_no_std_out=true"; then
    shift
    eval "$@" > /dev/null 2>&1 &
  elif is_equal "$1" "__eval_func_no_std_out=true"; then
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

exec_func_no_std_out() {
  exec_func "__exec_func_no_std_out=true" "$@"
}

exec_func_async() {
  exec_func "__exec_func_async=true" "$@"
}

exec_func_async_no_std_out() {
  exec_func "__exec_func_async_no_std_out=true" "$@"
}

# eval

eval_func() {
  exec_func "__eval_func=true" "$@"
}

eval_func_no_std_out() {
  exec_func "__eval_func_no_std_out=true" "$@"
}

eval_func_async() {
  exec_func "__eval_func_async=true" "$@"
}

eval_func_async_no_std_out() {
  exec_func "__eval_func_async_no_std_out=true" "$@"
}

# clear

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

clear_tmp_error() {
  if is_file_exist "$config_tmp_error_filepath"; then
    rm -rf "$config_tmp_error_filepath"
  fi
}

# determine

determine_distro() {
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
}

determine_de() {
  if [ -n "$XDG_CURRENT_DESKTOP" ]; then
    de="$XDG_CURRENT_DESKTOP"

    return 0
  fi

  if is_file_exist "/etc/X11/xinit/xinitrc.d/50-gnome-session.sh"; then
    de="gnome"

    return 0
  elif is_file_exist "/etc/X11/xinit/xinitrc.d/50-kde.sh"; then
    de="kde"

    return 0
  elif is_file_exist "/etc/X11/xinit/xinitrc.d/50-xfce.sh"; then
    de="xfce"

    return 0
  elif is_file_exist "/etc/X11/xinit/xinitrc.d/50-lxde.sh"; then
    de="lxde"

    return 0
  elif is_file_exist "/etc/X11/xinit/xinitrc.d/50-i3.sh"; then
    de="i3wm"

    return 0
  fi

  if is_file_exist "/usr/share/xsessions/gnome.desktop"; then
    de="gnome"

    return 0
  elif is_file_exist "/usr/share/xsessions/kde.plasma.desktop"; then
    de="kdeplasma"

    return 0
  elif is_file_exist "/usr/share/xsessions/xfce.desktop"; then
    de="xfce"

    return 0
  elif is_file_exist "/usr/share/xsessions/lxde.desktop"; then
    de="lxde"

    return 0
  elif is_file_exist "/usr/share/xsessions/i3.desktop"; then
    de="i3wm"

    return 0
  fi
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
    printf_exit "${color_red}$1 ${color_reset}$message_file_not_found"
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
  read -r __r_f_input < /dev/tty

  echo "$__r_f_input"
}

# set

set_ai_type() {
  printf_func_no_enter "$message_set_ai_type "

  __s_a_t_type=$(read_func)

  if is_empty "$__s_a_t_type"; then
    echo_exit "$message_set_ai_type_empty"
  fi

  if ! is_equal "$__s_a_t_type" "1"; then
    echo_exit "$message_set_ai_type_wrong"
  fi

  tmp_ai_type="$__s_a_t_type"
}

set_ai_model() {
  __s_a_m_type="$tmp_ai_type"

  if is_empty "$__s_a_m_type"; then
    __s_a_m_type=$(sed -n '1p' "$config_ai_filepath")
  fi

  if is_equal "$__s_a_m_type" "1"; then
    printf_func_no_enter "$message_set_ai_model_google "
  else
    echo_exit "$message_set_ai_type_wrong"
  fi

  __s_a_m_model=$(read_func)

  if is_empty "$__s_a_m_model"; then
    echo_exit "$message_set_ai_model_empty"
  fi

  if is_equal "$__s_a_m_type" "1"; then
    if ! is_equal "$__s_a_m_model" "1" && ! is_equal "$__s_a_m_model" "2" && ! is_equal "$__s_a_m_model" "3"; then
      echo_exit "$message_set_ai_model_wrong"
    fi
  fi

  tmp_ai_model="$__s_a_m_model"
}

set_ai_api_key() {
  __s_a_a_k_type="$tmp_ai_type"

  if is_empty "$__s_a_a_k_type"; then
    __s_a_a_k_type=$(sed -n '1p' "$config_ai_filepath")
  fi

  if is_equal "$__s_a_a_k_type" "1"; then
    printf_func_no_enter "$message_set_ai_api_key_google "
  else
    echo_exit "$message_set_ai_type_wrong"
  fi

  __s_a_a_k_api_key=$(read_func)

  if is_equal "$__s_a_a_k_type" "1" && is_empty "$__s_a_a_k_api_key"; then
    echo_exit "$message_set_ai_api_key_empty"
  fi

  tmp_ai_api_key="$__s_a_a_k_api_key"
}

set_tmp_value() {
  write_to_file "$1" "$config_tmp_value_filepath"
}

set_tmp_error() {
  write_to_file "$1" "$config_tmp_error_filepath"
}

# append

append_config_run_list() {
  printf_func "$(read_config_run_list)\n$1"
}

# open

open_and_read_float_window() {
  check_requirements "yad"

  yad --entry --sticky --no-buttons --width=400 --title "" --text "$message_caution_plain" --text-align "fill" --undecorated
}

open_and_print_text_float_window() {
  check_requirements "yad"

  yad --sticky --no-buttons --width=400 --title "" --text "$1" --text-align "fill" --undecorated
}

open_terminal_and_exec() {
  check_requirements "xfce4-terminal"

  _e_t_command=""

  if is_equal "$1" "__o_t_a_e_wait=true"; then
    shift

    _e_t_command="sh -c '$*; printf \"\n\n$message_press_enter_to_exit\n\n\"; read -r _ < /dev/tty'"
  else
    _e_t_command="sh -c '$*'"
  fi

  xfce4-terminal -e "$_e_t_command"
}

open_terminal_and_exec_wait() {
  open_terminal_and_exec "__o_t_a_e_wait=true" "$@"
}

# change

change_file_content_line() {
  sed -i "$1s/.*/$2/" "$3"
}

# make http request

make_http_request() {
  check_requirements "curl"

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

  curl "$__m_h_r_url" -H "$http_header" -H "Content-Type: $__m_h_r_content_type" -X "$__m_h_r_method" -d "$__m_h_r_request_body"
}

make_http_request_google_ai() {
  if ! is_ai_google; then
    return 0
  fi

  check_requirements "jq"

  __m_h_r_g_a_http_response=$(make_http_request -url "$(get_ai_url)/$(get_ai_model):generateContent?key=$(get_ai_api_key)" -requestBody "
    {
      \"contents\": [
        $1
      ],
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

# generate

generate_google_ai_prompt() {
  __g_g_a_p_role="user"

  if is_equal "$1" "model"; then
    __g_g_a_p_role="model"
  fi

  shift

  __g_g_a_p_prompt=""

  for __g_g_a_p_arg in "$@"; do
    if is_empty "$__g_g_a_p_prompt"; then
      __g_g_a_p_prompt="$__g_g_a_p_arg"
    else
      __g_g_a_p_prompt="$__g_g_a_p_prompt $__g_g_a_p_arg"
    fi
  done

  echo "{\"role\": \"$__g_g_a_p_role\", \"parts\":[{\"text\": \"$(echo "$__g_g_a_p_prompt" | escape_json_string)\"}]},"
}

# escape

escape_json_string() {
  sed -e 's/\\/\\\\/g' -e 's/"/\\"/g' -e 's/\n/\\n/g' -e 's/\r/\\r/g' -e 's/\t/\\t/g' -e 's/\b/\\b/g' -e 's/\f/\\f/g'
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

umar "$@"
