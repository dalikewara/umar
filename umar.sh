#!/bin/sh

version="v3.5.0"
pid=$$
distro=""
de=""
color_green='\033[0;32m'
color_cyan='\033[0;36m'
color_blue='\033[0;34m'
color_red='\033[0;31m'
color_yellow='\033[1;33m'
color_reset='\033[0m'
bold_start='\033[1m'
bold_end='\033[0m'

umar() {
    if is_file_exist "/etc/os-release"; then
        distro=$(awk -F= '/^ID=/ { print $2 }' "/etc/os-release" | tr -d '"')
    fi

    case "$distro" in
        arch*) distro="arch" ;;
        debian*) distro="debian" ;;
        ubuntu*) distro="ubuntu" ;;
        xubuntu*) distro="xubuntu" ;;
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

    if ! is_dir_exist "$HOME"; then
        create_dir "$HOME"
    fi

    create_dir "$HOME/.umar"

    check_requirements "sh"

    if is_no_argument "$@"; then
        printout "
I am Umar (${color_yellow}$version${color_reset}), your Linux assistant. I can help \
you with the common tasks listed below. I will continue to be updated indefinitely, as \
my creator may need to add new features, update my logic, fix issues, or make other changes. \
I can also use AI, but you need to manually set up the configuration first.
"
        printout "\
${color_green}${bold_start}u                         ${bold_end}${color_reset}   :Make me smarter by updating me to the latest version
${color_green}${bold_start}v                         ${bold_end}${color_reset}   :Show my current version
${color_green}${bold_start}r                         ${bold_end}${color_reset}   :Reveal/open my source code
${color_green}${bold_start}p                         ${bold_end}${color_reset}   :Print my source code
${color_green}${bold_start}w                         ${bold_end}${color_reset}   :Open my command window. You may create a keyboard shortcut for this command to open my command window directly
${color_green}${bold_start}run ${bold_end}${color_reset}OPTION | COMMANDS...     :Run custom command(s)
${color_cyan}${bold_start}    -l                    ${bold_end}${color_reset}   :get list custom command(s)
${color_cyan}${bold_start}    -s                    ${bold_end}${color_reset}   :set new custom command
${color_cyan}${bold_start}    -r ${bold_end}${color_reset}COMMANDS...           :remove custom command(s)
${color_cyan}${bold_start}    -cd                   ${bold_end}${color_reset}   :change custom command description
${color_cyan}${bold_start}    -cc                   ${bold_end}${color_reset}   :change custom command
${color_green}${bold_start}ai ${bold_end}${color_reset}[OPTION]                  :Use AI function(s). Supported AI: Google, ChatGPT
${color_cyan}${bold_start}    -p ${bold_end}${color_reset}PROMPT_TEXT           :prompt to AI
${color_cyan}${bold_start}    -c ${bold_end}${color_reset}                      :start AI chat session
${color_cyan}${bold_start}    -i ${bold_end}${color_reset}                      :show AI information
${color_cyan}${bold_start}    -s ${bold_end}${color_reset}                      :set AI config
${color_cyan}${bold_start}    -ct ${bold_end}${color_reset}                     :change AI type
${color_cyan}${bold_start}    -cm ${bold_end}${color_reset}                     :change AI model
${color_cyan}${bold_start}    -ca ${bold_end}${color_reset}                     :change AI api key
${color_green}${bold_start}open ${bold_end}${color_reset}PACKAGES...             :Open package(s)
${color_green}${bold_start}kill ${bold_end}${color_reset}NAMES...                :Kill package(s) process
${color_green}${bold_start}ins ${bold_end}${color_reset}PACKAGES...              :Install package(s)
${color_green}${bold_start}rm ${bold_end}${color_reset}PACKAGES...               :Remove package(s)
${color_green}${bold_start}upg ${bold_end}${color_reset}[PACKAGES...]            :Upgrade package(s)
${color_green}${bold_start}srch ${bold_end}${color_reset}TEXT...                 :Search for the given keyword(s) using a terminal browser
${color_green}${bold_start}au ${bold_end}${color_reset}[OPTION]                  :Use audio function(s)
${color_cyan}${bold_start}    -c ${bold_end}${color_reset}                      :show audio card(s)
${color_cyan}${bold_start}    -p ${bold_end}${color_reset}AUDIO_FILEPATHS...    :play audio(s)
${color_green}${bold_start}img ${bold_end}${color_reset}OPTION                   :Use image function(s)
${color_cyan}${bold_start}    -s ${bold_end}${color_reset}IMAGE_FILEPATHS...    :show image(s)
${color_green}${bold_start}vid ${bold_end}${color_reset}OPTION                   :Use video function(s)
${color_cyan}${bold_start}    -p ${bold_end}${color_reset}VIDEO_FILEPATH        :play video
${color_green}${bold_start}bth ${bold_end}${color_reset}                         :Open bluetooth manager
${color_green}${bold_start}batt ${bold_end}${color_reset}OPTION                  :Use battery function(s)
${color_cyan}${bold_start}    -c ${bold_end}${color_reset}                      :show battery capacity
${color_green}${bold_start}repl ${bold_end}${color_reset}OPTION                  :Use replace function(s)
${color_cyan}${bold_start}    -if ${bold_end}${color_reset}OLD NEW FILEPATHS... :replace in file(s)
${color_cyan}${bold_start}    -id ${bold_end}${color_reset}OLD NEW DIR_PATHS... :replace in directories
${color_green}${bold_start}pdf ${bold_end}${color_reset}OPTION                   :Use PDF function(s)
${color_cyan}${bold_start}    -o ${bold_end}${color_reset}PDF_FILEPATHS...      :open PDF(s)
${color_green}${bold_start}dev ${bold_end}${color_reset}                         :Show available device(s)
${color_green}${bold_start}reso ${bold_end}${color_reset}[DEVICE] [RESOLUTION]   :Set screen resolution
${color_green}${bold_start}bri ${bold_end}${color_reset}[DEVICE] [BRIGHTNESS]    :Set screen brightness
${color_green}${bold_start}tcpd ${bold_end}${color_reset}                        :Configure touchpad device
${color_green}${bold_start}wifi ${bold_end}${color_reset}[SSID]                  :Scan or connect to a Wi-Fi using nmcli
${color_green}${bold_start}thttp ${bold_end}${color_reset}OPTIONS...             :Test and benchmark HTTP URL
${color_cyan}${bold_start}    -c ${bold_end}${color_reset}NUM                   :concurrent
${color_cyan}${bold_start}    -r ${bold_end}${color_reset}NUM                   :retry
${color_cyan}${bold_start}    -t ${bold_end}${color_reset}SECONDS               :time duration
${color_cyan}${bold_start}    -header ${bold_end}${color_reset}TEXT             :header
${color_cyan}${bold_start}    -userAgent ${bold_end}${color_reset}TEXT          :user agent
${color_cyan}${bold_start}    -contentType ${bold_end}${color_reset}TEXT        :content type
${color_cyan}${bold_start}    -u ${bold_end}${color_reset}URL                   :url
${color_green}${bold_start}ss ${bold_end}${color_reset}[OPTION]                  :Take a screenshot
${color_cyan}${bold_start}    -a ${bold_end}${color_reset}                      :area
${color_cyan}${bold_start}    -f ${bold_end}${color_reset}                      :fullscreen
${color_green}${bold_start}d2un ${bold_end}${color_reset}OPTION                  :Use dos2unix function(s)
${color_cyan}${bold_start}    -f ${bold_end}${color_reset}FILEPATHS...          :Convert Windows file(s) to Unix format
${color_cyan}${bold_start}    -d ${bold_end}${color_reset}DIRPATHS...           :Convert all Windows dir(s) contents to Unix format
${color_green}${bold_start}stp ${bold_end}${color_reset}OPTION                   :Use setup function(s)
${color_cyan}${bold_start}    -fa ${bold_end}${color_reset}                     :setup fresh Arch Linux installation
${color_cyan}${bold_start}    -fai3 ${bold_end}${color_reset}                   :setup i3wm on a fresh Arch Linux installation
${color_cyan}${bold_start}    -d ${bold_end}${color_reset}                      :install developer tools: DataGrip, GoLand, PyCharm, IDEA, WebStorm, \
RustRover, Go, NVM, Rust, PyEnv, Postman, Docker, Git, Vim, Meld, Sublime Text
${color_cyan}${bold_start}    -ag ${bold_end}${color_reset}                     :install gaming tools on Arch Linux: Steam, Graphical Drivers
${color_green}${bold_start}intmb ${bold_end}${color_reset}OPTION                 :Use Intel MacBook function(s)
${color_cyan}${bold_start}    -a ${bold_end}${color_reset}                      :configure audio
${color_cyan}${bold_start}    -c ${bold_end}${color_reset}                      :configure camera
${color_cyan}${bold_start}    -b ${bold_end}${color_reset}                      :configure bluetooth
${color_cyan}${bold_start}    -f ${bold_end}${color_reset}[SPEED]               :set fan speed
        " | while IFS=: read -r name description; do
            printout_no_enter "$name"
            printout "$description" | fold -s -w $(($(tput cols) - 30)) | sed '2,$s/^/                              /'
        done

        printout "$(printout "\
All functions have been tested on ${color_yellow}**Arch Linux**${color_reset}. They might work on other distros, \
but I'm not sure. ${color_red}**DON'T EXECUTE ANYTHING IF YOU'RE NOT SURE, IT MAY BREAK YOUR SYSTEM**${color_reset}
" | markdown_parse)\n"

        return 0
    fi

    _command="command_$1"

    shift

    $_command "$@" || printout "Invalid command"
}

# ---------------------------------------------------------------------------------------------------------------------
#
# `command`
# Provides available Umar's command(s)
#
# ---------------------------------------------------------------------------------------------------------------------

command_d2un() {
    if is_equal "$1" "-f"; then
        check_requirements "dos2unix"

        shift

        if is_no_argument "$@"; then
            printout_exit "You didn't provide any file(s) to convert!"
        fi

        dos2unix "$@"
        printout "Ok"
        return 0
    elif is_equal "$1" "-d"; then
        check_requirements "dos2unix"

        shift

        if is_no_argument "$@"; then
            printout_exit "You didn't provide any dir(s) to procees!"
        fi

        for _arg in "$@"; do
            find "$_arg" -type f -exec dos2unix {} \;
        done

        printout "Ok"
        return 0
    fi

    printout_exit "Invalid option!"
}

command_u() {
    check_requirements "curl" "sudo"

    _url="https://raw.githubusercontent.com/dalikewara/umar/master/umar.sh"
    _tmp_filepath="/tmp/umar.sh"
    _installation_filepath="/usr/local/bin/umar"

    curl -L "$_url" -o "$_tmp_filepath"

    sudo mv "$_tmp_filepath" "$_installation_filepath"
    sudo chmod +x "$_installation_filepath"

    if [ -x "$_installation_filepath" ]; then
        printout_exit "Ok"
    fi

    printout_exit "Aborted!"
}

command_v() {
    printout_exit "$version"
}

command_r() {
    check_requirements "vim"

    execute vim -R "/usr/local/bin/umar"
}

command_p() {
    cat "/usr/local/bin/umar"
}

command_w() {
    check_requirements "yad"

    _command=$(yad --entry --sticky --no-buttons --width=400 --title "" --text "DON'T EXECUTE ANYTHING IF YOU'RE NOT SURE, IT MAY BREAK YOUR SYSTEM" --text-align "fill" --undecorated)

    if is_empty "$_command"; then
        return 0
    fi

    if ! is_start_with "$_command" "umar"; then
        _command="umar $_command"
    fi

    if is_start_with "$_command" "umar help"; then
        open_terminal_and_execute_wait "umar"
    elif is_start_with "$_command" "umar img" || is_start_with "$_command" "umar vid"; then
        execute_eval "$_command"
    elif is_start_with "$_command" "umar open" || is_start_with "$_command" "umar ss"; then
        $_command
    elif is_start_with "$_command" "umar srch" || is_start_with "$_command" "umar au" || is_start_with "$_command" "umar bth"; then
        open_terminal_and_execute "$_command"
    else
        open_terminal_and_execute_wait "$_command"
    fi
}

command_run() {
    if is_no_argument "$@"; then
        printout_exit "An option or command(s) is required!"
    fi

    _cfg_dir="$HOME/.umar/run"
    _cfg_filepath="$HOME/.umar/run-list.cfg"

    create_dir "$_cfg_dir"
    create_file "$_cfg_filepath"

    if is_equal "$1" "-l"; then
        _cfg="$(read_file_content "$_cfg_filepath")"

        if is_empty "$_cfg"; then
            printout_exit "No custom commands have been set"
        fi

        printout "$_cfg" | while IFS=: read -r _name _description _command; do
            if is_empty "$_name" && is_empty "$_description" && is_empty "$_command"; then
                continue
            fi

            printf "${color_green}${bold_start}%-20s ${bold_end}${color_reset}%-30s ${color_cyan}%b${color_reset}\n\n" "$_name" "$_description" "$(head -n 5 -v $_command)"
        done

        return 0
    fi

    if is_equal "$1" "-s"; then
        printout_no_enter "Enter a name... "

        _name=$(read_input)

        if is_empty "$_name"; then
            printout_exit "The name can't be empty!"
        fi

        if is_contain "$_name" ":"; then
            printout_exit "The name can't contain a colon!"
        fi

        if is_equal "$_name" "-l"; then
            printout_exit "The name can't be: -l"
        fi

        if is_equal "$_name" "-s"; then
            printout_exit "The name can't be: -s"
        fi

        if is_equal "$_name" "-r"; then
            printout_exit "The name can't be: -r"
        fi

        if is_equal "$_name" "-cd"; then
            printout_exit "The name can't be: -cd"
        fi

        if is_equal "$_name" "-cc"; then
            printout_exit "The name can't be: -cc"
        fi

        _name_exist=$(read_file_content "$_cfg_filepath" | while IFS=: read -r _name_config _ _; do
            if is_equal "$_name" "$_name_config"; then
                printout_exit "exist"
            fi
        done)

        if is_equal "$_name_exist" "exist"; then
            printout_exit "The name already exists!"
        fi

        printout_no_enter "Enter a description... "

        _description=$(read_input)

        if is_contain "$_description" ":"; then
            printout_exit "The description can't contain a colon!"
        fi

        _command="$_cfg_dir/$_name.sh"

        create_file "$_command"

        write_to_file "\
#!/bin/sh

" "$_command"
        
        chmod +x "$_command"
        
        _cfg=$(append_content_to_file "$_name:$_description:$_command" "$_cfg_filepath")

        write_to_file "$_cfg" "$_cfg_filepath"

        vim + "$_command"

        printout "Ok"
        
        return 0
    fi

    if is_equal "$1" "-r"; then
        shift

        if is_no_argument "$@"; then
            printout_exit "You didn't provide any custom command(s) to remove!"
        fi

        for _arg in "$@"; do
            read_file_content "$_cfg_filepath" | while IFS=: read -r _name_config _ _; do
                if is_equal "$_arg" "$_name_config" && ! is_empty "$_name_config"; then
                    delete_line_from_file_by_keyword "$_name_config:" "$_cfg_filepath"
                    rm "$_cfg_dir/$_name_config.sh"

                    break
                fi
            done
        done

        printout "Ok"

        return 0
    fi

    if is_equal "$1" "-cd"; then
        printout_no_enter "Enter a name... "

        _name=$(read_input)

        if is_empty "$_name"; then
            printout_exit "The name can't be empty!"
        fi

        if is_contain "$_name" ":"; then
            printout_exit "The name can't contain a colon!"
        fi

        _name_exist=$(read_file_content "$_cfg_filepath" | while IFS=: read -r _name_config _ _; do
            if is_equal "$_name" "$_name_config" && ! is_empty "$_name_config"; then
                printout_exit "exist"
            fi
        done)

        if ! is_equal "$_name_exist" "exist"; then
            printout_exit "${color_green}$_name${color_reset} command not found!"
        fi

        printout_no_enter "Enter a description... "

        _description=$(read_input)

        if is_contain "$_description" ":"; then
            printout_exit "The description can't contain a colon!"
        fi

        read_file_content "$_cfg_filepath" | while IFS=: read -r _name_config _ _command_config; do
            if is_equal "$_name" "$_name_config" && ! is_empty "$_name_config"; then
                change_file_content_line_by_keyword "$_name_config:" "$_name_config:$_description:$_command_config" "$_cfg_filepath"
                
                break
            fi
        done

        return 0
    fi

    if is_equal "$1" "-cc"; then
        printout_no_enter "Enter a name... "

        _name=$(read_input)

        if is_empty "$_name"; then
            printout_exit "The name can't be empty!"
        fi

        if is_contain "$_name" ":"; then
            printout_exit "The name can't contain a colon!"
        fi

        _name_exist=$(read_file_content "$_cfg_filepath" | while IFS=: read -r _name_config _ _; do
            if is_equal "$_name" "$_name_config" && ! is_empty "$_name_config"; then
                printout_exit "exist"
            fi
        done)

        if ! is_equal "$_name_exist" "exist"; then
            printout_exit "${color_green}$_name${color_reset} command not found!"
        fi

        vim "$_cfg_dir/$_name.sh"

        return 0
    fi

    write_to_tmp_value_file "not exist"

    for _arg in "$@"; do
        read_file_content "$_cfg_filepath" | while IFS=: read -r _name _description _command; do
            if is_empty "$_name" && is_empty "$_description" && is_empty "$_command"; then
                continue
            fi

            if is_equal "$_arg" "$_name"; then
                if is_equal "$_name" "-l"; then
                    printout_exit "The name can't be: -l"
                fi

                if is_equal "$_name" "-s"; then
                    printout_exit "The name can't be: -s"
                fi

                if is_equal "$_name" "-r"; then
                    printout_exit "The name can't be: -r"
                fi

                if is_equal "$_name" "-cd"; then
                    printout_exit "The name can't be: -cd"
                fi

                if is_equal "$_name" "-cc"; then
                    printout_exit "The name can't be: -cc"
                fi

                write_to_tmp_value_file "exist"

                printout "\n${color_green}${bold_start}$_name${bold_end}${color_reset} >_ ${color_cyan}$(head -n 5 -v $_command)${color_reset}\n"

                execute_eval "$_command"

                printout_blank_line

                break
            fi
        done

        if ! is_equal "$(get_tmp_value)" "exist"; then
            printout "${color_green}${bold_start}$_arg${bold_end}${color_reset} command not found!"
        fi
    done
}

command_ai() {
    check_requirements "jq"

    _cfg_filepath="$HOME/.umar/ai.cfg"
    _apikey_filepath="$HOME/.umar/ai.apikey"
    _type=""
    _model=""
    _apikey=""

    create_file "$_cfg_filepath"

    if ! is_file_exist "$_apikey_filepath"; then
        create_file "$_apikey_filepath"

        write_to_file "$(printout " \n ")" "$_apikey_filepath"
    fi

    if ! is_equal "$1" "-s"; then
        if is_file_exist "$_cfg_filepath"; then
            _type=$(read_file_content_line "1" "$_cfg_filepath")
            _model=$(read_file_content_line "2" "$_cfg_filepath")
        fi

        if is_empty "$_type"; then
            printout_exit "You didn't provide any AI type to process!\nYou can use this command to set up a new one: ${color_cyan}umar ai -s${color_reset}"
        fi

        if is_empty "$_model"; then
            printout_exit "You didn't provide any AI model to process!\nYou can use this command to set up a new one: ${color_cyan}umar ai -s${color_reset}"
        fi

        if is_file_exist "$_apikey_filepath"; then
            if is_equal "$_type" "google"; then
                _apikey=$(read_file_content_line "1" "$_apikey_filepath")
            elif is_equal "$_type" "chatgpt"; then
                _apikey=$(read_file_content_line "2" "$_apikey_filepath")
            fi
        fi
    fi

    if is_equal "$1" "-p" || is_equal "$1" "-c"; then
        if is_equal "$_type" "google" && is_empty "$_apikey"; then
            printout_exit "You need an API key to continue the process!\nYou can use this command to set a new one: ${color_cyan}umar ai -ca${color_reset}"
        elif is_equal "$_type" "chatgpt" && is_empty "$_apikey"; then
            printout_exit "You need an API key to continue the process!\nYou can use this command to set a new one: ${color_cyan}umar ai -ca${color_reset}"
        fi
    fi

    if is_equal "$1" "-p"; then
        shift

        printout "${color_yellow}$_type ($_model)${color_reset}\n"

        _prompt=$(printout "$*" | escape_json_string)
        _response=""

        if is_equal "$_type" "google"; then
            _response=$(http_request_google_ai "$_model" "$_apikey" "$(printout "{\"role\": \"user\", \"parts\":[{\"text\": \"$_prompt\"}]}," | remove_trailing_comma)")
        elif is_equal "$_type" "chatgpt"; then
            _response=$(http_request_chatgpt_ai "$_model" "$_apikey" "$(printout "{\"role\": \"user\", \"content\": \"$_prompt\"}," | remove_trailing_comma)")
        fi

        printout_typing "$(printout "$_response" | markdown_parse)"
        printout_blank_line

        return 0
    fi

    if is_equal "$1" "-c"; then
        printout "${color_yellow}$_type ($_model)${color_reset}\n"

        _prompt=""

        while true; do
            printout_no_enter "${color_yellow}>_${color_reset} "

            _chat_prompt="$(read_input)"

            if is_equal "$_chat_prompt" "exit" || is_equal "$_chat_prompt" "abort"; then
                printout "Aborted!"

                break
            fi

            if is_empty "$_chat_prompt"; then
                continue
            fi

            _chat_prompt=$(printout "$_chat_prompt" | escape_json_string)

            if is_equal "$_type" "google"; then
                _chat_prompt="{\"role\": \"user\", \"parts\":[{\"text\": \"$(printout "$_chat_prompt" | escape_json_string)\"}]},"
            elif is_equal "$_type" "chatgpt"; then
                _chat_prompt="{\"role\": \"user\", \"content\": \"$(printout "$_chat_prompt" | escape_json_string)\"},"
            fi
            
            if is_empty "$_prompt"; then
                _prompt="$_chat_prompt"
            else
                _prompt="$_prompt $_chat_prompt"
            fi

            _response=""

            printout_blank_line

            _prompt=$(printf "%s" "$_prompt" | tr '
' ' ')

            if is_equal "$_type" "google"; then
                _response=$(http_request_google_ai "$_model" "$_apikey" "$(printout "$_prompt" | remove_trailing_comma)")
            elif is_equal "$_type" "chatgpt"; then
                _response=$(http_request_chatgpt_ai "$_model" "$_apikey" "$(printout "$_prompt" | remove_trailing_comma)")
            fi

            if is_equal "$_type" "google"; then
                _prompt="$_prompt {\"role\": \"model\", \"parts\":[{\"text\": \"$(printout "$_response" | escape_json_string)\"}]},"
            elif is_equal "$_type" "chatgpt"; then
                _prompt="$_prompt {\"role\": \"model\", \"content\": \"$(printout "$_response" | escape_json_string)\"},"
            fi

            printout_typing "$(printout "$_response" | markdown_parse)"
            printout_blank_line
        done

        return 0
    fi

    if is_equal "$1" "" || is_equal "$1" "-i"; then
        if ! is_empty "$_apikey"; then
            _apikey="* * * * *"
        fi

        printout "Type: ${color_yellow}$_type\n${color_reset}Model: ${color_yellow}$_model\n${color_reset}API key: ${color_blue}$_apikey${color_reset}"
        
        return 0
    fi

    if is_equal "$1" "-s" || is_equal "$1" "-ct"; then
        printout_no_enter "\
AI type:

1. Google
2. ChatGPT

Choose the AI type number... "
        
        _type=$(read_input)

        if is_empty "$_type"; then
            printout_exit "AI type can't be empty!"
        fi

        if ! is_equal "$_type" "1" && ! is_equal "$_type" "2"; then
            printout_exit "Wrong AI type!"
        fi

        if is_equal "$_type" "1"; then
            _type="google"
        fi

        if is_equal "$_type" "2"; then
            _type="chatgpt"
        fi
    fi

    if is_equal "$1" "-s" || is_equal "$1" "-cm" || is_equal "$1" "-ct"; then
        if is_empty "$_type"; then
            _type=$(read_file_content_line "1" "$_cfg_filepath")
        fi

        if is_equal "$_type" "google"; then
            printout_no_enter "
AI model:

1. gemini-1.0-pro
2. gemini-1.5-pro
3. gemini-1.5-flash

Choose the AI model number... "
        elif is_equal "$_type" "chatgpt"; then
            printout_no_enter "
AI model:

1. gpt-4o-mini
2. gpt-3.5-turbo
3. gpt-3.5-turbo-0125
4. gpt-3.5-turbo-1106
5. gpt-3.5-turbo-16k
6. gpt-3.5-turbo-instruct
7. gpt-3.5-turbo-instruct-0914

Choose the AI model number... "
        else
            printout_exit "Wrong AI type!"
        fi

        _model=$(read_input)

        if is_empty "$_model"; then
            printout_exit "AI model can't be empty!"
        fi

        if is_equal "$_type" "google"; then
            if ! is_equal "$_model" "1" && ! is_equal "$_model" "2" && ! is_equal "$_model" "3"; then
                printout_exit "Wrong AI model!"
            fi

            if is_equal "$_model" "1"; then
                _model="gemini-1.0-pro"
            fi

            if is_equal "$_model" "2"; then
                _model="gemini-1.5-pro"
            fi

            if is_equal "$_model" "3"; then
                _model="gemini-1.5-flash"
            fi
        elif is_equal "$_type" "chatgpt"; then
            if ! is_equal "$_model" "1" && ! is_equal "$_model" "2" && ! is_equal "$_model" "3" && ! is_equal "$_model" "4" && ! is_equal "$_model" "5" && ! is_equal "$_model" "6" && ! is_equal "$_model" "7"; then
                printout_exit "Wrong AI model!"
            fi

            if is_equal "$_model" "1"; then
                _model="gpt-4o-mini"
            fi

            if is_equal "$_model" "2"; then
                _model="gpt-3.5-turbo"
            fi

            if is_equal "$_model" "3"; then
                _model="gpt-3.5-turbo-0125"
            fi

            if is_equal "$_model" "3"; then
                _model="gpt-3.5-turbo-1106"
            fi

            if is_equal "$_model" "3"; then
                _model="gpt-3.5-turbo-16k"
            fi

            if is_equal "$_model" "3"; then
                _model="gpt-3.5-turbo-instruct"
            fi

            if is_equal "$_model" "3"; then
                _model="gpt-3.5-turbo-instruct-0914"
            fi
        fi
    fi

    if is_equal "$1" "-s" || is_equal "$1" "-ca"; then
        if is_empty "$_type"; then
            _type=$(read_file_content_line "1" "$_cfg_filepath")
        fi

        if is_equal "$_type" "google"; then
            printout_no_enter "
You'll need an API key to use the AI. You can follow this documentation -> https://ai.google.dev/gemini-api/docs/api-key

Enter the API key... "
        elif is_equal "$_type" "chatgpt"; then
printout_no_enter "
You'll need an API key to use the AI. Log in/Sign up to your OpenAI account and create a new API key

Enter the API key... "
        else
            printout_exit "Wrong AI type!"
        fi

        _apikey=$(read_input)

        if is_equal "$_type" "google" && is_empty "$_apikey"; then
            printout_exit "API key can't be empty!"
        elif is_equal "$_type" "chatgpt" && is_empty "$_apikey"; then
            printout_exit "API key can't be empty!"
        fi
    fi

    if is_equal "$1" "-s"; then
        write_to_file "$(printout "$_type\n$_model")" "$_cfg_filepath"

        if is_equal "$_type" "google"; then
            change_file_content_line "1" "$_apikey" "$_apikey_filepath"
        elif is_equal "$_type" "chatgpt"; then
            change_file_content_line "2" "$_apikey" "$_apikey_filepath"
        fi

        printout "AI configuration registered"

        return 0
    fi

    if is_equal "$1" "-ct"; then
        change_file_content_line "1" "$_type" "$_cfg_filepath"
        change_file_content_line "2" "$_model" "$_cfg_filepath"

        printout "Ok"

        return 0
    fi

    if is_equal "$1" "-cm"; then
        change_file_content_line "2" "$_model" "$_cfg_filepath"

        printout "Ok"

        return 0
    fi

    if is_equal "$1" "-ca"; then
        if is_equal "$_type" "google"; then
            change_file_content_line "1" "$_apikey" "$_apikey_filepath"
        elif is_equal "$_type" "chatgpt"; then
            change_file_content_line "2" "$_apikey" "$_apikey_filepath"
        fi

        printout "Ok"

        return 0
    fi

    printout "Aborted!"
}

command_open() {
    if is_no_argument "$@"; then
        printout_exit "You didn't provide any package(s) to open!"
    fi

    _not_exist=""

    for _arg in "$@"; do
        if is_package_exist "$_arg" || is_user_package_exist "$_arg"; then
            execute_async_no_std_out "$_arg"

            continue
        fi

        _not_exist="yes"

        printout "${color_red}**$_arg** ${color_reset}package not found!" | markdown_parse
    done

    if ! is_equal "$_not_exist" "yes"; then
        clear_shell
    fi
}

command_kill() {
    if is_no_argument "$@"; then
        printout_exit "You didn't provide any name(s) to kill!"
    fi

    check_requirements "sudo"

    _process_list=""

    printout_blank_line

    for _arg in "$@"; do
        _process_list="$_process_list\n$(ps -ef | grep "$_arg" | grep -v "$pid" | awk '{print $2}')"

        ps aux | grep "$_arg" | grep -v "$pid"
    done

    _process_list=$(printout "${color_yellow}$_process_list${color_reset}")

    printout_no_enter "\nAll processes listed above will be terminated. Are you sure? [N/y] "

    _confirmation=$(read_input)

    if ! is_equal "$_confirmation" "y"; then
        printout "\nAborted!"

        return 0
    fi

    printout "$_process_list" | while IFS= read -r _line; do
        if ! is_empty "$_line"; then
            sudo kill -9 "$_line" > /dev/null 2>&1
        fi
    done

    printout "\nAll processes have been terminated!"
}

command_ins() {
    if is_no_argument "$@"; then
        printout_exit "You didn't provide any packages(s) to install!"
    fi

    install_package "$@"
}

command_rm() {
    if is_no_argument "$@"; then
        printout_exit "You didn't provide any package(s) to remove!"
    fi

    remove_package "$@"
}

command_upg() {
    upgrade_package "$@"
}

command_srch() {
    if is_no_argument "$@"; then
        printout_exit "You didn't provide any text to search!"
    fi

    check_requirements "w3m"

    execute w3m "https://www.google.com/search?q=$(printout "$*" | sed 's/ /+/g')"

    clear_shell
}

command_au() {
    if is_equal "$1" "-c"; then
        check_requirements "pactl"

        pactl list cards

        return 0
    fi

    if is_equal "$1" "-p"; then
        check_requirements "mpg123"

        shift

        if is_no_argument "$@"; then
            printout_exit "You didn't provide any audio(s) to play!"
        fi

        mpg123 -v "$@"

        return 0
    fi

    check_requirements "pulsemixer"

    pulsemixer
}

command_img() {
    if is_no_argument "$@"; then
        printout_exit "An option is required!"
    fi

    check_requirements "feh"

    if is_equal "$1" "-s"; then
        shift

        if is_no_argument "$@"; then
            printout_exit "You didn't provide any image(s) to show!"
        fi

        feh "$@" &

        return 0
    fi

    printout_exit "Aborted!"
}

command_vid() {
    if is_no_argument "$@"; then
        printout_exit "An option is required!"
    fi

    check_requirements "mpv"

    if is_equal "$1" "-p"; then
        shift

        mpv "$@" > /dev/null 2>&1 &

        return 0
    fi

    printout_exit "Aborted!"
}

command_bth() {
    check_requirements "bluetoothctl"

    bluetoothctl
}

command_batt() {
    if is_no_argument "$@"; then
        printout_exit "An option is required!"
    fi

    if is_equal "$1" "-c"; then
        if is_file_exist "/sys/class/power_supply/BAT0/capacity"; then
            cat "/sys/class/power_supply/BAT0/capacity"
        fi

        return 0
    fi

    printout "Aborted!"
}

command_repl() {
    if is_no_argument "$@"; then
        printout_exit "An option is required!"
    fi

    _option="$1"
    _old=""
    _new=""

    if is_equal "$_option" "-if" || is_equal "$_option" "-id"; then
        shift

        if is_empty "$1" || is_empty "$2"; then
            printout_exit "Invalid input!"
        fi

        _old="$1"
        _new="$2"

        shift
        shift

        if is_no_argument "$@"; then
            if is_equal "$_option" "-if"; then
                printout_exit "The targeted filepath is required!"
            fi

            if is_equal "$_option" "-id"; then
                printout_exit "The targeted directory is required!"
            fi
        fi

        _target_paths="$*"

        printout_blank_line
        printout "You're about to"
        printout_blank_line
        printout "\
Replace: ${bold_start}$_old${bold_end}
With: ${bold_start}$_new${bold_end}
Targets: ${bold_start}$_target_paths${bold_end}"

        if is_equal "$_option" "-id"; then
            _target_dirs="$_target_paths"
            _target_paths=$(get_files_from_directories $_target_dirs)

            printout "\
Filepaths: ${bold_start}$_target_paths${bold_end}"
        fi

        printout_no_enter "
${color_red}${bold_start}WARNING!!! MAY BREAK YOUR SYSTEM!!! Don't do this if you're not aware!!!${bold_end}${color_reset}

Are you sure? [N/y] "

        _confirmation=$(read_input)

        if ! is_equal "$_confirmation" "y"; then
            printout_exit "Aborted!"
        fi

        sed -i "s/$_old/$_new/g" $_target_paths

        printout "Ok"

        return
    fi

    printout "Aborted!"
}

command_pdf() {
    if is_no_argument "$@"; then
        printout_exit "An option is required!"
    fi

    check_requirements "deepin-reader"

    if is_equal "$1" "-o"; then
        shift

        if is_no_argument "$@"; then
            printout_exit "You didn't provide any pdf(s) to open!"
        fi

        deepin-reader "$@" > /dev/null 2>&1 &

        return 0
    fi

    printout_exit "Aborted!"
}

command_dev() {
    check_requirements "xrandr"

    xrandr --current
}

command_reso() {
    check_requirements "xrandr"

    if is_no_argument "$@"; then
        printout_exit "Current screen resolution is $(xrandr | grep '\*' | awk '{print $1}')"
    fi

    if is_empty "$1" || is_empty "$2"; then
        printout_exit "Current screen resolution is $(xrandr | grep '\*' | awk '{print $1}')"
    fi

    xrandr --output "$1" --mode "$2"
}

command_bri() {
    check_requirements "xrandr" "bc"

    if is_no_argument "$@"; then
        printout_exit "Current brightness value is $(xrandr --verbose | awk '/Brightness/ { print $2 * 100; exit}')"
    fi

    if is_empty "$1" || is_empty "$2"; then
        printout_exit "Current brightness value is $(xrandr --verbose | awk '/Brightness/ { print $2 * 100; exit}')"
    fi

    _brightness=$(printout "scale=2; ${2} / 100" | bc)

    printout "${_brightness} < 0.10" | bc | grep -q 1

    if is_equal "$?" "0"; then
        printout_exit "Value under minimum!"
    fi

    printout "${_brightness} > 1.00" | bc | grep -q 1

    if is_equal "$?" "0"; then
        printout_exit "Value above maximum!"
    fi

    xrandr --output "$1" --brightness "$_brightness"
}

command_tcpd() {
    check_requirements "xinput"

    printout_markdown "${color_yellow}**Configuring touchpad device**${color_reset}"
    printout_blank_line

    xinput list

    printout_blank_line
    printout_no_enter "Enter your Touchpad Device ID... "

    _device_id=$(read_input)

    if is_empty "$_device_id"; then
        printout_exit "Device ID can't be empty!"
    fi

    printout_no_enter "
You're about to configure this Touchpad Device:

$(xinput list | grep "id=${_device_id}")

Are you sure? [N/y] "

    _confirmation=$(read_input)

    if ! is_equal "$_confirmation" "y"; then
        printout_exit "Aborted!"
    fi

    xinput set-prop $_device_id "libinput Tapping Enabled" 1
    xinput set-prop $_device_id "libinput Natural Scrolling Enabled" 0
}

command_wifi() {
    check_requirements "nmcli"

    if [ "$1" = "" ]; then
        printout "Scanning..."

        nmcli radio wifi on
        nmcli device wifi rescan
        nmcli device wifi list

        return 0
    fi

    printout "Scanning..."

    nmcli radio wifi on
    nmcli device wifi rescan

    printout "Ok"
    printout "Connecting..."

    nmcli device wifi connect --ask "$1"

    printout "Ok"
}

command_thttp() {
    check_requirements "siege"

    _concurrent="10"
    _time=""
    _retry=""
    _url=""
    _url_header="X-TOOL:siege"
    _url_user_agent=""
    _url_content_type=""

    while [ $# -gt 0 ]; do
        case "$1" in
            -c)
                _concurrent="${1#-c}"

                if [ -z "$_concurrent" ]; then
                    shift

                    _concurrent="$1"
                fi
                ;;
            -t)
                _time="${1#-t}"

                if [ -z "$_time" ]; then
                    shift

                    _time="$1"
                fi
                ;;
            -r)
                _retry="${1#-r}"

                if [ -z "$_retry" ]; then
                    shift

                    _retry="$1"
                fi
                ;;
            -u)
                _url="${1#-u}"

                if [ -z "$_url" ]; then
                    shift

                    _url="$1"
                fi
                ;;
            -userAgent)
                _url_user_agent="${1#-userAgent}"

                if [ -z "$_url_user_agent" ]; then
                    shift

                    _url_user_agent="$1"
                fi
                ;;
            -header)
                _url_header="${1#-header}"

                if [ -z "$_url_header" ]; then
                    shift

                    _url_header="$1"
                fi
                ;;
            -contentType)
                _url_content_type="${1#-contentType}"

                if [ -z "$_url_content_type" ]; then
                    shift

                    _url_content_type="$1"
                fi
                ;;
        esac

        shift
    done

    if is_empty "$_url"; then
        printout_exit "Please provide a URL to test!\nUse this option: ${color_cyan}-u ${color_blue}URL${color_reset}"
    fi

    printout "url=$_url | concurrent=$_concurrent | time=${_time}S | retry=$_retry | header=$_url_header | userAgent=$_url_user_agent | contentType=$_url_content_type\n"

    if ! is_empty "$_time"; then
        execute siege -vbp "-c$_concurrent" "-t${_time}S" --header="$_url_header" --user-agent="$_url_user_agent" --content-type="$_url_content_type" "$_url"
    elif ! is_empty "$_retry"; then
        execute siege -vbp "-c$_concurrent" "-r$_retry" --header="$_url_header" --user-agent="$_url_user_agent" --content-type="$_url_content_type" "$_url"
    else
        execute siege -vbp "-c$_concurrent" "-t10S" --header="$_url_header" --user-agent="$_url_user_agent" --content-type="$_url_content_type" "$_url"
    fi
}

command_ss() {
    check_requirements "xfce4-screenshooter"

    if is_equal "$1" "-a"; then
        xfce4-screenshooter -r

        return 0
    elif is_equal "$1" "-f"; then
        xfce4-screenshooter -f

        return 0
    fi

    xfce4-screenshooter
}

command_stp() {
    if is_no_argument "$@"; then
        printout_exit "An option is required!"
    fi

    _ssh_name="ed25519"
    _ssh_dir="$HOME/.ssh/id_ed25519"
    _ssh_filepath="$HOME/.ssh/id_ed25519.pub"
    _grub_filepath="/etc/default/grub"
    _grub_boot_filepath="/boot/grub/grub.cfg"
    _systemd_boot_filepath="/boot/loader/loader.conf"
    _net_rule_filepath="/etc/udev/rules.d/80-net-setup-link.rules"
    _xinitrc_filepath="$HOME/.xinitrc"
    _xinitrc_sys_filepath="/etc/X11/xinit/xinitrc"
    _bashrc_filepath="$HOME/.bashrc"
    _bash_profile_filepath="$HOME/.bash_profile"
    _profile_filepath="$HOME/.profile"
    _zprofile_filepath="$HOME/.zprofile"
    _zshrc_filepath="$HOME/.zshrc"
    _config_dir="$HOME/.config"
    _config_i3_dir="$HOME/.config/i3"
    _config_i3_filepath="$HOME/.config/i3/config"
    _config_i3_sys_filepath="/etc/i3/config"
    _config_i3status_dir="$HOME/.config/i3status"
    _config_i3status_filepath="$HOME/.config/i3status/config"
    _config_i3status_sys_filepath="/etc/i3status.conf"
    _config_polybar_dir="$HOME/.config/polybar"
    _config_polybar_filepath="$HOME/.config/polybar/config.ini"
    _config_polybar_sys_filepath="/etc/polybar/config.ini"
    _config_polybar_launch_filepath="$HOME/.config/polybar/launch.sh"
    _config_polybar_launch_bluetooth_filepath="$HOME/.config/polybar/launch-bluetooth.sh"
    _config_polybar_launch_bluetooth_toggle_filepath="$HOME/.config/polybar/launch-bluetooth-toggle.sh"
    _config_xfce4_dir="$HOME/.config/xfce4"
    _config_xfce4_xfconf_dir="$HOME/.config/xfce4/xfconf"
    _config_xfce4_xfconf_xfce_perchannel_xml_dir="$HOME/.config/xfce4/xfconf/xfce-perchannel-xml"
    _config_xfce4_xfconf_xfce_perchannel_xml_xfce4_terminal_filepath="$HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-terminal.xml"
    _config_xfce4_xfconf_xfce_perchannel_xml_xfce4_terminal_launch_filepath="$HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-terminal-launch.sh"
    _config_gtk3_dir="$HOME/.config/gtk-3.0"
    _config_gtk3_filepath="$HOME/.config/gtk-3.0/settings.ini"
    _config_udiskie_dir="$HOME/.config/udiskie"
    _config_udiskie_filepath="$HOME/.config/udiskie/config.yml"
    _config_vim_filepath="$HOME/.vimrc"
    _datagrip_dir="$HOME/.umar/datagrip"
    _datagrip_version_dir="$HOME/.umar/datagrip/DataGrip-2024.3.2"
    _datagrip_filepath="$HOME/.umar/datagrip/DataGrip-2024.3.2/bin/datagrip"
    _datagrip_chrome_sandbox_filepath="$HOME/.umar/datagrip/DataGrip-2024.3.2/jbr/lib/chrome-sandbox"
    _datagrip_downloaded_filepath="$HOME/.umar/datagrip/datagrip-2024.3.2.tar.gz"
    _datagrip_sys_filepath="/usr/local/bin/datagrip"
    _datagrip_download_url="https://download-cdn.jetbrains.com/datagrip/datagrip-2024.3.2.tar.gz"
    _goland_dir="$HOME/.umar/goland"
    _goland_version_dir="$HOME/.umar/goland/GoLand-2024.3"
    _goland_filepath="$HOME/.umar/goland/GoLand-2024.3/bin/goland"
    _goland_chrome_sandbox_filepath="$HOME/.umar/goland/GoLand-2024.3/jbr/lib/chrome-sandbox"
    _goland_downloaded_filepath="$HOME/.umar/goland/goland-2024.3.tar.gz"
    _goland_sys_filepath="/usr/local/bin/goland"
    _goland_download_url="https://download-cdn.jetbrains.com/go/goland-2024.3.tar.gz"
    _pycharm_dir="$HOME/.umar/pycharm"
    _pycharm_version_dir="$HOME/.umar/pycharm/pycharm-2024.3"
    _pycharm_filepath="$HOME/.umar/pycharm/pycharm-2024.3/bin/pycharm"
    _pycharm_chrome_sandbox_filepath="$HOME/.umar/pycharm/pycharm-2024.3/jbr/lib/chrome-sandbox"
    _pycharm_downloaded_filepath="$HOME/.umar/pycharm/pycharm-professional-2024.3.tar.gz"
    _pycharm_sys_filepath="/usr/local/bin/pycharm"
    _pycharm_download_url="https://download-cdn.jetbrains.com/python/pycharm-professional-2024.3.tar.gz"
    _idea_dir="$HOME/.umar/idea"
    _idea_version_dir="$HOME/.umar/idea/idea-IU-243.22562.145"
    _idea_filepath="$HOME/.umar/idea/idea-IU-243.22562.145/bin/idea"
    _idea_chrome_sandbox_filepath="$HOME/.umar/idea/idea-IU-243.22562.145/jbr/lib/chrome-sandbox"
    _idea_downloaded_filepath="$HOME/.umar/idea/ideaIU-2024.3.1.tar.gz"
    _idea_sys_filepath="/usr/local/bin/idea"
    _idea_download_url="https://download-cdn.jetbrains.com/idea/ideaIU-2024.3.1.tar.gz"
    _webstorm_dir="$HOME/.umar/webstorm"
    _webstorm_version_dir="$HOME/.umar/webstorm/WebStorm-243.22562.112"
    _webstorm_filepath="$HOME/.umar/webstorm/WebStorm-243.22562.112/bin/webstorm"
    _webstorm_chrome_sandbox_filepath="$HOME/.umar/webstorm/WebStorm-243.22562.112/jbr/lib/chrome-sandbox"
    _webstorm_downloaded_filepath="$HOME/.umar/webstorm/WebStorm-2024.3.1.tar.gz"
    _webstorm_sys_filepath="/usr/local/bin/webstorm"
    _webstorm_download_url="https://download-cdn.jetbrains.com/webstorm/WebStorm-2024.3.1.tar.gz"
    _rustrover_dir="$HOME/.umar/rustrover"
    _rustrover_version_dir="$HOME/.umar/rustrover/RustRover-2024.3"
    _rustrover_filepath="$HOME/.umar/rustrover/RustRover-2024.3/bin/rustrover"
    _rustrover_chrome_sandbox_filepath="$HOME/.umar/rustrover/RustRover-2024.3/jbr/lib/chrome-sandbox"
    _rustrover_downloaded_filepath="$HOME/.umar/rustrover/RustRover-2024.3.tar.gz"
    _rustrover_sys_filepath="/usr/local/bin/rustrover"
    _rustrover_download_url="https://download-cdn.jetbrains.com/rustrover/RustRover-2024.3.tar.gz"
    _go_dir="$HOME/.umar/go"
    _go_home_dir="$HOME/go"
    _go_home_bin_dir="$HOME/go/bin"
    _go_home_pkg_dir="$HOME/go/pkg"
    _go_home_src_dir="$HOME/go/src"
    _go_version_dir="$HOME/.umar/go/go1.23.2"
    _go_extracted_dir="$HOME/.umar/go/go"
    _go_downloaded_filepath="$HOME/.umar/go/go1.23.2.linux-amd64.tar.gz"
    _go_sys_dir="/usr/local/go"
    _go_bin_sys_dir="/usr/local/go/bin"
    _go_download_url="https://go.dev/dl/go1.23.2.linux-amd64.tar.gz"
    _nvm_download_url="https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh"
    _nodejs_version="22"
    _rust_download_url="https://sh.rustup.rs"
    _pyenv_home_dir="$HOME/.pyenv"
    _pyenv_download_url="https://pyenv.run"
    _postman_dir="$HOME/.umar/postman"
    _postman_filepath="$HOME/.umar/postman/Postman/app/Postman"
    _postman_downloaded_filepath="$HOME/.umar/postman/postman.tar.gz"
    _postman_sys_filepath="/usr/local/bin/postman"
    _postman_download_url="https://dl.pstmn.io/download/latest/linux_64"
    _sublimetext_dir="$HOME/.umar/sublimetext"
    _sublimetext_filepath="$HOME/.umar/sublimetext/sublime_text/sublime_text"
    _sublimetext_downloaded_filepath="$HOME/.umar/sublimetext/sublime_text_build_4180_x64.tar.xz"
    _sublimetext_sys_filepath="/usr/local/bin/sublimetext"
    _sublimetext_download_url="https://download.sublimetext.com/sublime_text_build_4180_x64.tar.xz"

    if is_equal "$1" "-fa"; then
        if ! is_arch; then
            printout_exit "You're not using Arch Linux!"
        fi

        printout_markdown "${color_yellow}**This will set up a fresh Arch Linux installation. **${color_red}**WARNING!!! This will replace your existing configuration and MAY BREAK YOUR SYSTEM!!! Don't do this if you're not aware!!!**${color_reset}"
        printout_blank_line
        printout_no_enter "Are you sure to continue this process [N/y] "

        _confirmation=$(read_input)

        if ! is_equal "$_confirmation" "y"; then
            printout_exit "Aborted!"
        fi

        sudo echo "Configuring..."

        if is_file_exist "$_bashrc_filepath"; then
            if ! grep -qF "[[ \$- != *i* ]] && return" "$_bashrc_filepath"; then
                echo "[[ \$- != *i* ]] && return" >> "$_bashrc_filepath"
            fi
        fi

        install_package "git" "vim" "curl" "htop" "neofetch" "bash" "zsh" "chromium" "make" "xorg-xrandr" "libinput" "xf86-input-libinput" \
            "xorg-server" "xorg-xinput" "polkit" "pulsemixer" "xfce4-terminal" "networkmanager" "amd-ucode" "intel-ucode" "lm_sensors" "bc" "base-devel" \
            "linux-lts" "pipewire" "pipewire-audio" "pipewire-pulse" "wget" "xsensors" "unzip" "sof-firmware" "alsa-firmware" "pipewire-alsa" \
            "pipewire-jack" "wireplumber" "pavucontrol" "alsa-card-profiles" "openssh" "sudo" "xorg" "xorg-xinit" "intel-media-driver" "mesa" \
            "xf86-video-amdgpu" "libva-intel-driver" "vulkan-intel" "xf86-video-ati" "libva-mesa-driver" "vulkan-radeon" \
            "xf86-video-nouveau" "freetype2" "libglvnd" "deepin-reader" "cpio" "imagemagick" "bluez" "bluez-utils" "linux-firmware-qlogic" \
            "linux-firmware-bnx2x" "linux-firmware-liquidio" "linux-firmware-mellanox" "linux-firmware-nfp" "gcc" "linux-lts-headers" "dkms" \
            "vulkan-tools" "vulkan-icd-loader" "nvidia-utils" "vulkan-nouveau" "amdvlk" "vulkan-swrast" "yad" "linux" "linux-headers" \
            "xfce4-screenshooter" "gtk3" "udisks2" "udiskie" "gvfs" "ntfs-3g" "dunst" "arandr" "autorandr"

        check_requirements "git" "ssh"

        printout "Configuring ssh..."

        if ! is_file_exist "$_ssh_filepath"; then
            ssh-keygen -t $_ssh_name

            eval "$(ssh-agent -s)"

            ssh-add "$_ssh_dir"
        fi

        printout "Configuring git..."

        if is_empty "$(git config user.name)"; then
            printout_no_enter "Enter your git user.name...  "

            _git_name=$(read_input)

            git config --global user.name "$_git_name"
        fi

        if is_empty "$(git config user.email)"; then
            printout_no_enter "Enter your git user.email...  "

            _git_email=$(read_input)

            git config --global user.email "$_git_email"
        fi

        printout "Configuring host..."

        sudo ln -sf /dev/null "$_net_rule_filepath"

        printout "Configuring bluetooth..."

        sudo modprobe btusb
        sudo usermod -G lp -a "$(whoami)" || true
        sudo usermod -G bluetooth -a "$(whoami)" || true
        sudo usermod -G lp -a root || true
        sudo usermod -G bluetooth -a root || true
        sudo systemctl start bluetooth.service || true
        sudo systemctl enable bluetooth.service || true

        printout "Configuring sensors..."

        sudo sensors-detect
        sudo sensors
        sudo pwmconfig

        printout "Configuring systemd-oomd..."

        sudo systemctl start systemd-oomd.service || true
        sudo systemctl enable systemd-oomd.service || true

        printout "Configuring input..."

        sudo systemctl status systemd-udevd || true
        sudo modprobe usbhid || true

        if is_file_exist "$_grub_filepath"; then
            printout "Configuring grub..."

            sudo sed -i -E 's/GRUB_TIMEOUT=([0-9]+)/GRUB_TIMEOUT=0/g' "$_grub_filepath"
            sudo grub-mkconfig -o "$_grub_boot_filepath"
        elif is_file_exist "$_systemd_boot_filepath"; then
            printout "Configuring systemd-boot..."

            sudo sed -i -E 's/timeout ([0-9]+)/timeout 1/g' "$_systemd_boot_filepath"
            sudo sed -i -E 's/\#console\-mode keep/console\-mode keep/g' "$_systemd_boot_filepath"
        fi

        printout "Configuring dark theme..."

        create_dir "$_config_dir"
        create_dir "$_config_gtk3_dir"
        create_file "$_config_gtk3_filepath"

        if ! grep -qF "[Settings]" "$_config_gtk3_filepath"; then
            echo "\
[Settings]
gtk-icon-theme-name = Adwaita
gtk-theme-name = Adwaita
gtk-font-name = DejaVu Sans 11
gtk-application-prefer-dark-theme = 1
" >> "$_config_gtk3_filepath"
        fi

        printout "Configuring udiskie..."

        create_dir "$_config_dir"
        create_dir "$_config_udiskie_dir"
        create_file "$_config_udiskie_filepath"

        if ! grep -qF "program_options:" "$_config_udiskie_filepath"; then
            echo "\
program_options:
  tray: true
  automount: true
  notify: true
  smart-tray: true
" >> "$_config_udiskie_filepath"
        fi

        if ! grep -qF "filter_options:" "$_config_udiskie_filepath"; then
            echo "\
filter_options:
  ignore_internal: true
  ignore_fs: false
" >> "$_config_udiskie_filepath"
        fi

        printout "Configuring vim..."

         create_file "$_config_vim_filepath"

        if ! grep -qF "set tabstop=4" "$_config_vim_filepath"; then
            echo "set tabstop=4" >> "$_config_vim_filepath"
        fi

        if ! grep -qF "set shiftwidth=4" "$_config_vim_filepath"; then
            echo "set shiftwidth=4" >> "$_config_vim_filepath"
        fi

        if ! grep -qF "set expandtab" "$_config_vim_filepath"; then
            echo "set expandtab" >> "$_config_vim_filepath"
        fi

        if ! grep -qF "set number" "$_config_vim_filepath"; then
            echo "set number" >> "$_config_vim_filepath"
        fi

        if ! grep -qF "syntax on" "$_config_vim_filepath"; then
            echo "syntax on" >> "$_config_vim_filepath"
        fi
        
        printout "Ok"

        return 0
    fi

    if is_equal "$1" "-fai3"; then
        if ! is_arch; then
            printout_exit "You're not using Arch Linux!"
        fi

        printout_markdown "${color_yellow}**This will install & set up i3wm on a fresh Arch Linux installation. **${color_red}**WARNING!!! This will replace your existing window manager or desktop environment and MAY BREAK YOUR SYSTEM!!! Don't do this if you're not aware!!!**${color_reset}"
        printout_blank_line
        printout_no_enter "Are you sure to continue this process [N/y] "

        _confirmation=$(read_input)

        if ! is_equal "$_confirmation" "y"; then
            printout_exit "Aborted!"
        fi

        sudo echo "Configuring..."

        install_package "i3" "xorg" "xorg-xinit" "xfce4-terminal" "polybar" "pavucontrol" "xorg-server" "xorg-xrandr" "xorg-xinput" "bluez-utils" "yad" \
            "libinput" "xf86-input-libinput" "amd-ucode" "intel-ucode" "intel-media-driver" "mesa" "xf86-video-amdgpu" "libva-intel-driver" \
            "vulkan-intel" "xf86-video-ati" "libva-mesa-driver" "vulkan-radeon" "xf86-video-nouveau" "vulkan-tools" "vulkan-icd-loader" "nvidia-utils" \
            "vulkan-nouveau" "amdvlk" "vulkan-swrast" "gtk3"
        
        printout "Copying .xinitrc..."

        if ! is_file_exist "$_xinitrc_filepath"; then
            cp "$_xinitrc_sys_filepath" "$_xinitrc_filepath"
        fi

        printout "Configuring profiles..."

        if is_file_exist "$_bash_profile_filepath"; then
            if ! grep -qF "if [ -z \"\$DISPLAY\" ] && [ \"\$XDG_VTNR\" = 1 ]; then" "$_bash_profile_filepath"; then
                echo "
if [ -z \"\$DISPLAY\" ] && [ \"\$XDG_VTNR\" = 1 ]; then
    exec startx
fi
" >> "$_bash_profile_filepath"
            fi
        fi

        if is_file_exist "$_profile_filepath"; then
            if ! grep -qF "if [ -z \"\$DISPLAY\" ] && [ \"\$XDG_VTNR\" = 1 ]; then" "$_profile_filepath"; then
                echo "
if [ -z \"\$DISPLAY\" ] && [ \"\$XDG_VTNR\" = 1 ]; then
    exec startx
fi
" >> "$_profile_filepath"
            fi
        fi

        if is_file_exist "$_zprofile_filepath"; then
            if ! grep -qF "if [ -z \"\$DISPLAY\" ] && [ \"\$XDG_VTNR\" = 1 ]; then" "$_zprofile_filepath"; then
                echo "
if [ -z \"\$DISPLAY\" ] && [ \"\$XDG_VTNR\" = 1 ]; then
    exec startx
fi
" >> "$_zprofile_filepath"
            fi
        fi

        if is_file_exist "$_bashrc_filepath"; then
            if ! grep -qF "[[ \$- != *i* ]] && return" "$_bashrc_filepath"; then
                echo "[[ \$- != *i* ]] && return" >> "$_bashrc_filepath"
            fi
        fi

        printout "Configuring dark theme..."

        create_dir "$_config_dir"
        create_dir "$_config_gtk3_dir"
        create_file "$_config_gtk3_filepath"

        if ! grep -qF "[Settings]" "$_config_gtk3_filepath"; then
            echo "\
[Settings]
gtk-icon-theme-name = Adwaita
gtk-theme-name = Adwaita
gtk-font-name = DejaVu Sans 11
gtk-application-prefer-dark-theme = 1
" >> "$_config_gtk3_filepath"
        fi

        printout "Configuring udiskie..."

        create_dir "$_config_dir"
        create_dir "$_config_udiskie_dir"
        create_file "$_config_udiskie_filepath"

        if ! grep -qF "program_options:" "$_config_udiskie_filepath"; then
            echo "\
program_options:
  tray: true
  automount: true
  notify: true
  smart-tray: true
" >> "$_config_udiskie_filepath"
        fi

        if ! grep -qF "filter_options:" "$_config_udiskie_filepath"; then
            echo "\
filter_options:
  ignore_internal: true
  ignore_fs: false
" >> "$_config_udiskie_filepath"
        fi

        printout "Configuring i3wm..."

        create_dir "$_config_i3_dir"
        create_dir "$_config_i3status_dir"
        create_dir "$_config_polybar_dir"

        if ! is_file_exist "$_config_i3_filepath"; then
            cp "$_config_i3_sys_filepath" "$_config_i3_filepath"
        fi

        if ! is_file_exist "$_config_i3status_filepath"; then
            cp "$_config_i3status_sys_filepath" "$_config_i3status_filepath"
        fi

        if ! is_file_exist "$_config_polybar_filepath"; then
            cp "$_config_polybar_sys_filepath" "$_config_polybar_filepath"
        fi

        if ! is_file_exist "$_config_polybar_launch_filepath"; then
            create_file "$_config_polybar_launch_filepath"

            echo "\
#!/usr/bin/env bash

killall -q polybar || true
echo \"---\" | tee -a /tmp/polybar1.log || true
polybar bar 2>&1 | tee -a /tmp/polybar1.log & disown || true
" > "$_config_polybar_launch_filepath"

            chmod +x "$_config_polybar_launch_filepath"
        fi

        if ! is_file_exist "$_config_polybar_launch_bluetooth_filepath"; then
            create_file "$_config_polybar_launch_bluetooth_filepath"

            echo "\
#!/bin/sh

if [ \$(bluetoothctl show | grep \"Powered: yes\" | wc -c) -eq 0 ]; then
    echo \"BTOFF\"
elif [ \$(echo info | bluetoothctl | grep 'Device' | wc -c) -eq 0 ]; then
    echo \"BTCON\"
else
    echo \"BTON\"
fi
" > "$_config_polybar_launch_bluetooth_filepath"

            chmod +x "$_config_polybar_launch_bluetooth_filepath"
        fi

        if ! is_file_exist "$_config_polybar_launch_bluetooth_toggle_filepath"; then
            create_file "$_config_polybar_launch_bluetooth_toggle_filepath"

            echo "\
#!/bin/sh

if [ \$(bluetoothctl show | grep \"Powered: yes\" | wc -c) -eq 0 ]; then
    bluetoothctl power on > /dev/null 2>&1 || true
    bluetoothctl scan on > /dev/null 2>&1 || true
else
    bluetoothctl scan off > /dev/null 2>&1 || true
    bluetoothctl power off > /dev/null 2>&1 || true
fi
" > "$_config_polybar_launch_bluetooth_toggle_filepath"

            chmod +x "$_config_polybar_launch_bluetooth_toggle_filepath"
        fi

        if ! grep -qF "set \$mod Mod" "$_config_i3_filepath"; then
            # shellcheck disable=SC2016
            sed -i '1s/^/set \$mod Mod4\n/' "$_config_i3_filepath"
        fi

        # shellcheck disable=SC2016
        sed -i 's/set \$mod Mod1/set \$mod Mod4/g' "$_config_i3_filepath"
        # shellcheck disable=SC2016
        sed -i 's/Mod1/\$mod/g' "$_config_i3_filepath"
        sed -i '/^bar {$/,/^}/s/^/#/g' "$_config_i3_filepath"
        # shellcheck disable=SC2016
        sed -i 's/bindsym \$mod+Return exec i3\-sensible\-terminal/\#bindsym \$mod+Return exec i3\-sensible\-terminal/g' "$_config_i3_filepath"
        # shellcheck disable=SC2016
        sed -i 's/bindsym \$mod+space focus mode\_toggle/\#bindsym \$mod+space focus mode\_toggle/g' "$_config_i3_filepath"
        # shellcheck disable=SC2016
        sed -i 's/bindsym \$mod+Shift+space floating toggle/\#bindsym \$mod+Shift+space floating toggle/g' "$_config_i3_filepath"

        if ! grep -qF "bindsym \$mod+Return exec --no-startup-id xfce4-terminal" "$_config_i3_filepath"; then
            echo "bindsym \$mod+Return exec --no-startup-id xfce4-terminal" >> "$_config_i3_filepath"
        fi

        if ! grep -qF "bindsym \$mod+space exec umar w" "$_config_i3_filepath"; then
            echo "bindsym \$mod+space exec umar w" >> "$_config_i3_filepath"
        fi

        if ! grep -qF "default_border pixel 0px" "$_config_i3_filepath"; then
            echo "default_border pixel 0px" >> "$_config_i3_filepath"
        fi

        if ! grep -qF "gaps inner 0px" "$_config_i3_filepath"; then
            echo "gaps inner 0px" >> "$_config_i3_filepath"
        fi

        if ! grep -qF "gaps outer 0px" "$_config_i3_filepath"; then
            echo "gaps outer 0px" >> "$_config_i3_filepath"
        fi

        if ! grep -qF "exec_always --no-startup-id $_config_polybar_launch_filepath" "$_config_i3_filepath"; then
            echo "exec_always --no-startup-id $_config_polybar_launch_filepath" >> "$_config_i3_filepath"
        fi

        if ! grep -qF "exec_always --no-startup-id udiskie --tray" "$_config_i3_filepath"; then
            echo "exec_always --no-startup-id udiskie --tray" >> "$_config_i3_filepath"
        fi

        if ! grep -qF "exec_always --no-startup-id dunst" "$_config_i3_filepath"; then
            echo "exec_always --no-startup-id dunst" >> "$_config_i3_filepath"
        fi

        if ! grep -qF "exec_always --no-startup-id autorandr --change" "$_config_i3_filepath"; then
            echo "exec_always --no-startup-id autorandr --change" >> "$_config_i3_filepath"
        fi

        sed -i 's/background \= \#282A2E/background \= \#000000/g' "$_config_polybar_filepath"
        sed -i 's/background\-alt \= \#373B41/background\-alt \= \#000000/g' "$_config_polybar_filepath"
        sed -i 's/\[bar\/example\]/\[bar\/bar\]/g' "$_config_polybar_filepath"
        sed -i 's/height \= 24pt/height \= 18pt/g' "$_config_polybar_filepath"
        sed -i 's/radius \= 6/radius \= 0/g' "$_config_polybar_filepath"
        sed -i 's/line\-size \= 3pt/line\-size \= 1pt/g' "$_config_polybar_filepath"
        sed -i 's/modules\-right \= filesystem pulseaudio xkeyboard memory cpu wlan eth date/modules\-right \= systray filesystem pulseaudio xkeyboard memory cpu battery wlan eth bluetooth date/g' "$_config_polybar_filepath"
        sed -i 's/label \= \%title\:0\:60\:\.\.\.\%/label \= \%title\:0\:40\:\.\.\.\%\nlabel\-maxlen \= 40/g' "$_config_polybar_filepath"
        sed -i 's/format\-volume\-prefix \= \"VOL \"/format\-volume\-prefix \= \"AV\"/g' "$_config_polybar_filepath"
        sed -i 's/format\-prefix \= \"RAM \"/format\-prefix \= \"R\"/g' "$_config_polybar_filepath"
        sed -i 's/format\-prefix \= \"CPU \"/format\-prefix \= \"C\"/g' "$_config_polybar_filepath"
        sed -i 's/label\-connected \= \%{F\#F0C674}\%ifname\%\%{F\-} \%essid\% \%local_ip\%/label\-connected \= \%{F\#F0C674}\%ifname\%\%{F\-} \%essid\:0\:10\:\.\.\.\% \%local_ip\%\nlabel\-maxlen \= 40/g' "$_config_polybar_filepath"
        sed -i '/label\-connected \= \%{F\#F0C674}\%ifname\%\%{F\-} \%local_ip\%/ {
N
s/label\-connected \= \%{F\#F0C674}\%ifname\%\%{F\-} \%local_ip\%\nlabel\-maxlen \= 40/label\-connected \= \%{F\#F0C674}\%ifname\%\%{F\-} \%local_ip\%/
}' "$_config_polybar_filepath"

        sed -i 's/label\-connected \= \%{F\#F0C674}\%ifname\%\%{F\-} \%local_ip\%/label\-connected \= \%{F\#F0C674}\%ifname\%\%{F\-} \%local_ip\%\nlabel\-maxlen \= 40/g' "$_config_polybar_filepath"
        sed -i 's/date \= \%H\:\%M/date \= \%Y\-\%m\-\%d \%H\:\%M\:\%S/g' "$_config_polybar_filepath"

        if ! grep -qF "[module/battery]" "$_config_polybar_filepath"; then
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
format-full = \"BF\"
format-full-foreground = \${colors.primary}
format-low-prefix = \"BL\"
format-low-prefix-foreground = \${colors.primary}
label-charging = %percentage%%
label-discharging = %percentage%%
label-full = %percentage%%
label-low = %percentage%%
" >> "$_config_polybar_filepath"
        fi

        if ! grep -qF "[module/bluetooth]" "$_config_polybar_filepath"; then
            echo "
[module/bluetooth]
type = custom/script
exec = $_config_polybar_launch_bluetooth_filepath
interval = 2
click-left = exec $_config_polybar_launch_bluetooth_toggle_filepath
click-right = exec $_config_polybar_launch_bluetooth_toggle_filepath
format-foreground = \${colors.primary}
" >> "$_config_polybar_filepath"
        fi

        printout "Configuring xfce4-terminal..."

        create_dir "$_config_xfce4_dir"
        create_dir "$_config_xfce4_xfconf_dir"
        create_dir "$_config_xfce4_xfconf_xfce_perchannel_xml_dir"
        create_file "$_config_xfce4_xfconf_xfce_perchannel_xml_xfce4_terminal_filepath"

        if ! is_file_exist "$_config_xfce4_xfconf_xfce_perchannel_xml_xfce4_terminal_launch_filepath"; then
            create_file "$_config_xfce4_xfconf_xfce_perchannel_xml_xfce4_terminal_launch_filepath"

            chmod +x "$_config_xfce4_xfconf_xfce_perchannel_xml_xfce4_terminal_launch_filepath"
        fi

        echo "\
<?xml version=\"1.0\" encoding=\"UTF-8\"?>

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
    <property name=\"misc-show-unsafe-paste-dialog\" type=\"bool\" value=\"false\"/>
    <property name=\"misc-confirm-close\" type=\"bool\" value=\"false\"/>
</channel>
" > "$_config_xfce4_xfconf_xfce_perchannel_xml_xfce4_terminal_filepath"
        
        echo "\
#!/bin/sh

killall xfconfd || true
" > "$_config_xfce4_xfconf_xfce_perchannel_xml_xfce4_terminal_launch_filepath"

        printout "Configuring .xinitrc..."

        sed -i 's/\"\$twm \&/\#\"\$twm \&/g' "$_xinitrc_filepath"
        sed -i 's/\$twm \&/\#\$twm \&/g' "$_xinitrc_filepath"
        sed -i 's/twm \&/\#twm \&/g' "$_xinitrc_filepath"
        sed -i 's/\"\$twm/\#\"\$twm/g' "$_xinitrc_filepath"
        sed -i 's/\"\$xclock/\#\"\$xclock/g' "$_xinitrc_filepath"
        sed -i 's/\$xclock/\#\$xclock/g' "$_xinitrc_filepath"
        sed -i 's/xclock/\#xclock/g' "$_xinitrc_filepath"
        sed -i 's/\"\$exec xterm/\#\"\$exec xterm/g' "$_xinitrc_filepath"
        sed -i 's/\$exec xterm/\#\$exec xterm/g' "$_xinitrc_filepath"
        sed -i 's/exec \"\$xterm/\#exec \"\$xterm/g' "$_xinitrc_filepath"
        sed -i 's/exec \"xterm/\#exec \"xterm/g' "$_xinitrc_filepath"
        sed -i 's/exec xterm/\#exec xterm/g' "$_xinitrc_filepath"
        sed -i 's/\"\$xterm/\#\"\$xterm/g' "$_xinitrc_filepath"
        sed -i 's/\$xterm/\#\$xterm/g' "$_xinitrc_filepath"
        sed -i 's/xterm/\#xterm/g' "$_xinitrc_filepath"

        if ! grep -qF "$_config_xfce4_xfconf_xfce_perchannel_xml_xfce4_terminal_launch_filepath &" "$_xinitrc_filepath"; then
            echo "$_config_xfce4_xfconf_xfce_perchannel_xml_xfce4_terminal_launch_filepath &" >> "$_xinitrc_filepath"
        fi

        if ! grep -qF "exec i3" "$_xinitrc_filepath"; then
            echo "exec i3" >> "$_xinitrc_filepath"
        fi

        printout "Ok"

        return 0
    fi

    if is_equal "$1" "-d"; then
        printout_markdown "${color_yellow}**This will install developer tools. **${color_red}**WARNING!!! This will replace your existing packages!!! Don't do this if you're not aware!!!**${color_reset}"
        printout_blank_line
        printout_no_enter "Are you sure to continue this process [N/y] "

        _confirmation=$(read_input)

        if ! is_equal "$_confirmation" "y"; then
            printout_exit "Aborted!"
        fi

        sudo echo "Configuring..."

        check_requirements "tar" "wget" "gzip"

        if is_arch; then
            install_package "git" "vim" "curl" "meld" "htop" "neofetch" "bash" "zsh" "make" "openssh" "docker" "docker-compose" || printout_exit "Aborted!"
        elif is_debian; then
            install_package "ca-certificates" "curl"

            sudo install -m 0755 -d /etc/apt/keyrings
            sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
            sudo chmod a+r /etc/apt/keyrings/docker.asc

            echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
                $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
            
            install_package "git" "vim" "curl" "meld" "htop" "neofetch" "bash" "zsh" "make" "openssh" \
                "docker-ce" "docker-ce-cli" "containerd.io" "docker-buildx-plugin" "docker-compose-plugin" || printout_exit "Aborted!"
        else
            install_package "git" "vim" "curl" "meld" "htop" "neofetch" "bash" "zsh" "make" "openssh" || printout_exit "Aborted!"
        fi

        printout "Configuring ssh..."

        if ! is_file_exist "$_ssh_filepath"; then
            ssh-keygen -t $_ssh_name

            eval "$(ssh-agent -s)"

            ssh-add "$_ssh_dir"
        fi

        printout "Configuring vim..."

        create_file "$_config_vim_filepath"

        if ! grep -qF "set tabstop=4" "$_config_vim_filepath"; then
            echo "set tabstop=4" >> "$_config_vim_filepath"
        fi

        if ! grep -qF "set shiftwidth=4" "$_config_vim_filepath"; then
            echo "set shiftwidth=4" >> "$_config_vim_filepath"
        fi

        if ! grep -qF "set expandtab" "$_config_vim_filepath"; then
            echo "set expandtab" >> "$_config_vim_filepath"
        fi

        if ! grep -qF "set number" "$_config_vim_filepath"; then
            echo "set number" >> "$_config_vim_filepath"
        fi

        if ! grep -qF "syntax on" "$_config_vim_filepath"; then
            echo "syntax on" >> "$_config_vim_filepath"
        fi

        printout "Downloading tools..."

        if ! is_dir_exist "$_datagrip_version_dir"; then
            create_dir "$_datagrip_dir"

            wget -c --timeout=10 --tries=1 -O "$_datagrip_downloaded_filepath" "$_datagrip_download_url" &
        fi

        if ! is_dir_exist "$_goland_version_dir"; then
            create_dir "$_goland_dir"

            wget -c --timeout=10 --tries=1 -O "$_goland_downloaded_filepath" "$_goland_download_url" &
        fi

        if ! is_dir_exist "$_pycharm_version_dir"; then
            create_dir "$_pycharm_dir"

            wget -c --timeout=10 --tries=1 -O "$_pycharm_downloaded_filepath" "$_pycharm_download_url" &
        fi

        if ! is_dir_exist "$_idea_version_dir"; then
            create_dir "$_idea_dir"

            wget -c --timeout=10 --tries=1 -O "$_idea_downloaded_filepath" "$_idea_download_url" &
        fi

        if ! is_dir_exist "$_webstorm_version_dir"; then
            create_dir "$_webstorm_dir"

            wget -c --timeout=10 --tries=1 -O "$_webstorm_downloaded_filepath" "$_webstorm_download_url" &
        fi

        if ! is_dir_exist "$_rustrover_version_dir"; then
            create_dir "$_rustrover_dir"

            wget -c --timeout=10 --tries=1 -O "$_rustrover_downloaded_filepath" "$_rustrover_download_url" &
        fi

        if ! is_dir_exist "$_go_version_dir"; then
            create_dir "$_go_dir"

            wget -c --timeout=10 --tries=1 -O "$_go_downloaded_filepath" "$_go_download_url" &
        fi

        create_dir "$_postman_dir"

        wget -c --timeout=10 --tries=1 -O "$_postman_downloaded_filepath" "$_postman_download_url" &

        create_dir "$_sublimetext_dir"

        wget -c --timeout=10 --tries=1 -O "$_sublimetext_downloaded_filepath" "$_sublimetext_download_url" &

        wait

        curl --proto '=https' --tlsv1.2 -sSf "$_rust_download_url" | sh || true
        curl "$_pyenv_download_url" | bash || true
        curl -o- "$_nvm_download_url" | bash || true

        export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

        nvm install "$_nodejs_version"
        nvm use "$_nodejs_version"

        printout "Extracting tools..."

        if is_file_exist "$_datagrip_downloaded_filepath"; then
            tar -v -C "$_datagrip_dir" -xzf "$_datagrip_downloaded_filepath" &
        fi

        if is_file_exist "$_goland_downloaded_filepath"; then
            tar -v -C "$_goland_dir" -xzf "$_goland_downloaded_filepath" &
        fi

        if is_file_exist "$_pycharm_downloaded_filepath"; then
            tar -v -C "$_pycharm_dir" -xzf "$_pycharm_downloaded_filepath" &
        fi

        if is_file_exist "$_idea_downloaded_filepath"; then
            tar -v -C "$_idea_dir" -xzf "$_idea_downloaded_filepath" &
        fi

        if is_file_exist "$_webstorm_downloaded_filepath"; then
            tar -v -C "$_webstorm_dir" -xzf "$_webstorm_downloaded_filepath" &
        fi

        if is_file_exist "$_rustrover_downloaded_filepath"; then
            tar -v -C "$_rustrover_dir" -xzf "$_rustrover_downloaded_filepath" &
        fi

        if is_file_exist "$_go_downloaded_filepath"; then
            tar -v -C "$_go_dir" -xzf "$_go_downloaded_filepath" &
        fi

        if is_file_exist "$_postman_downloaded_filepath"; then
            tar -v -C "$_postman_dir" -xzf "$_postman_downloaded_filepath" &
        fi

        if is_file_exist "$_sublimetext_downloaded_filepath"; then
            tar -v -C "$_sublimetext_dir" -xvf "$_sublimetext_downloaded_filepath" &
        fi

        wait

        printout "Configuring tools..."

        sudo chmod 4755 "$_datagrip_chrome_sandbox_filepath"
        sudo chmod 4755 "$_datagrip_version_dir"
        sudo ln -sf "$_datagrip_filepath" "$_datagrip_sys_filepath" || sudo ln -sf "$_datagrip_filepath.sh" "$_datagrip_sys_filepath" || true

        rm -rf "$_datagrip_downloaded_filepath"

        sudo chmod 4755 "$_goland_chrome_sandbox_filepath"
        sudo chmod 4755 "$_goland_version_dir"
        sudo ln -sf "$_goland_filepath" "$_goland_sys_filepath" || sudo ln -sf "$_goland_filepath.sh" "$_goland_sys_filepath" || true

        rm -rf "$_goland_downloaded_filepath"

        sudo chmod 4755 "$_pycharm_chrome_sandbox_filepath"
        sudo chmod 4755 "$_pycharm_version_dir"
        sudo ln -sf "$_pycharm_filepath" "$_pycharm_sys_filepath" || sudo ln -sf "$_pycharm_filepath.sh" "$_pycharm_sys_filepath" || true

        rm -rf "$_pycharm_downloaded_filepath"

        sudo chmod 4755 "$_idea_chrome_sandbox_filepath"
        sudo chmod 4755 "$_idea_version_dir"
        sudo ln -sf "$_idea_filepath" "$_idea_sys_filepath" || sudo ln -sf "$_idea_filepath.sh" "$_idea_sys_filepath" || true

        rm -rf "$_idea_downloaded_filepath"

        sudo chmod 4755 "$_webstorm_chrome_sandbox_filepath"
        sudo chmod 4755 "$_webstorm_version_dir"
        sudo ln -sf "$_webstorm_filepath" "$_webstorm_sys_filepath" || sudo ln -sf "$_webstorm_filepath.sh" "$_webstorm_sys_filepath" || true

        rm -rf "$_webstorm_downloaded_filepath"

        sudo chmod 4755 "$_rustrover_chrome_sandbox_filepath"
        sudo chmod 4755 "$_rustrover_version_dir"
        sudo ln -sf "$_rustrover_filepath" "$_rustrover_sys_filepath" || sudo ln -sf "$_rustrover_filepath.sh" "$_rustrover_sys_filepath" || true

        rm -rf "$_rustrover_downloaded_filepath"

        if is_file_exist "$_go_downloaded_filepath"; then
            mv "$_go_extracted_dir" "$_go_version_dir"
        fi

        mkdir "$_go_home_dir" > /dev/null 2>&1 || true
        mkdir "$_go_home_bin_dir" > /dev/null 2>&1 || true
        mkdir "$_go_home_pkg_dir" > /dev/null 2>&1 || true
        mkdir "$_go_home_src_dir" > /dev/null 2>&1 || true

        sudo rm -rf "$_go_sys_dir"
        sudo cp -rf "$_go_version_dir" "$_go_sys_dir"

        rm -rf "$_go_downloaded_filepath"

        sudo ln -sf "$_postman_filepath" "$_postman_sys_filepath" || true

        rm -rf "$_postman_downloaded_filepath"

        sudo ln -sf "$_sublimetext_filepath" "$_sublimetext_sys_filepath" || true

        rm -rf "$_sublimetext_downloaded_filepath"

        sudo gpasswd -a $USER docker || true
        sudo systemctl start docker.socket || true
        sudo systemctl enable docker.socket || true

        printout "Configuring profiles..."

        if is_file_exist "$_bash_profile_filepath"; then
            if ! grep -qF "export PATH=\$PATH:$_go_bin_sys_dir" "$_bash_profile_filepath"; then
                echo "export PATH=\$PATH:$_go_bin_sys_dir" >> "$_bash_profile_filepath"
            fi

            if ! grep -qF "export GOPATH=$_go_home_dir" "$_bash_profile_filepath"; then
                echo "export GOPATH=$_go_home_dir" >> "$_bash_profile_filepath"
            fi

            if ! grep -qF "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" "$_bash_profile_filepath"; then
                echo "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" >> "$_bash_profile_filepath"
            fi

            if ! grep -qF "export PYENV_ROOT=$_pyenv_home_dir" "$_bash_profile_filepath"; then
                echo "export PYENV_ROOT=$_pyenv_home_dir" >> "$_bash_profile_filepath"
            fi

            if ! grep -qF "[[ -d \$PYENV_ROOT/bin ]] && export PATH=\$PYENV_ROOT/bin:\$PATH" "$_bash_profile_filepath"; then
                echo "[[ -d \$PYENV_ROOT/bin ]] && export PATH=\$PYENV_ROOT/bin:\$PATH" >> "$_bash_profile_filepath"
            fi
        fi

        if is_file_exist "$_bashrc_filepath"; then
            if ! grep -qF "[[ \$- != *i* ]] && return" "$_bashrc_filepath"; then
                echo "[[ \$- != *i* ]] && return" >> "$_bashrc_filepath"
            fi

            if ! grep -qF "export PATH=\$PATH:$_go_bin_sys_dir" "$_bashrc_filepath"; then
                echo "export PATH=\$PATH:$_go_bin_sys_dir" >> "$_bashrc_filepath"
            fi

            if ! grep -qF "export GOPATH=$_go_home_dir" "$_bashrc_filepath"; then
                echo "export GOPATH=$_go_home_dir" >> "$_bashrc_filepath"
            fi

            if ! grep -qF "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" "$_bashrc_filepath"; then
                echo "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" >> "$_bashrc_filepath"
            fi

            if ! grep -qF "export PYENV_ROOT=$_pyenv_home_dir" "$_bashrc_filepath"; then
                echo "export PYENV_ROOT=$_pyenv_home_dir" >> "$_bashrc_filepath"
            fi

            if ! grep -qF "[[ -d \$PYENV_ROOT/bin ]] && export PATH=\$PYENV_ROOT/bin:\$PATH" "$_bashrc_filepath"; then
                echo "[[ -d \$PYENV_ROOT/bin ]] && export PATH=\$PYENV_ROOT/bin:\$PATH" >> "$_bashrc_filepath"
            fi

            if ! grep -qF "command -v pyenv >/dev/null || export PATH=\$PYENV_ROOT/bin:\$PATH" "$_bashrc_filepath"; then
                echo "command -v pyenv >/dev/null || export PATH=\$PYENV_ROOT/bin:\$PATH" >> "$_bashrc_filepath"
            fi
        fi

        if is_file_exist "$_profile_filepath"; then
            if ! grep -qF "export PATH=\$PATH:$_go_bin_sys_dir" "$_profile_filepath"; then
                echo "export PATH=\$PATH:$_go_bin_sys_dir" >> "$_profile_filepath"
            fi

            if ! grep -qF "export GOPATH=$_go_home_dir" "$_profile_filepath"; then
                echo "export GOPATH=$_go_home_dir" >> "$_profile_filepath"
            fi

            if ! grep -qF "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" "$_profile_filepath"; then
                echo "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" >> "$_profile_filepath"
            fi

            if ! grep -qF "export PYENV_ROOT=$_pyenv_home_dir" "$_profile_filepath"; then
                echo "export PYENV_ROOT=$_pyenv_home_dir" >> "$_profile_filepath"
            fi

            if ! grep -qF "command -v pyenv >/dev/null || export PATH=\$PYENV_ROOT/bin:\$PATH" "$_profile_filepath"; then
                echo "command -v pyenv >/dev/null || export PATH=\$PYENV_ROOT/bin:\$PATH" >> "$_profile_filepath"
            fi
        fi

        if is_file_exist "$_zshrc_filepath"; then
            if ! grep -qF "export PATH=\$PATH:$_go_bin_sys_dir" "$_zshrc_filepath"; then
                echo "export PATH=\$PATH:$_go_bin_sys_dir" >> "$_zshrc_filepath"
            fi

            if ! grep -qF "export GOPATH=$_go_home_dir" "$_zshrc_filepath"; then
                echo "export GOPATH=$_go_home_dir" >> "$_zshrc_filepath"
            fi

            if ! grep -qF "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" "$_zshrc_filepath"; then
                echo "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" >> "$_zshrc_filepath"
            fi

            if ! grep -qF "export PYENV_ROOT=$_pyenv_home_dir" "$_zshrc_filepath"; then
                echo "export PYENV_ROOT=$_pyenv_home_dir" >> "$_zshrc_filepath"
            fi

            if ! grep -qF "[[ -d \$PYENV_ROOT/bin ]] && export PATH=\$PYENV_ROOT/bin:\$PATH" "$_zshrc_filepath"; then
                echo "[[ -d \$PYENV_ROOT/bin ]] && export PATH=\$PYENV_ROOT/bin:\$PATH" >> "$_zshrc_filepath"
            fi
        fi

        if is_file_exist "$_zprofile_filepath"; then
            if ! grep -qF "export PATH=\$PATH:$_go_bin_sys_dir" "$_zprofile_filepath"; then
                echo "export PATH=\$PATH:$_go_bin_sys_dir" >> "$_zprofile_filepath"
            fi

            if ! grep -qF "export GOPATH=$_go_home_dir" "$_zprofile_filepath"; then
                echo "export GOPATH=$_go_home_dir" >> "$_zprofile_filepath"
            fi

            if ! grep -qF "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" "$_zprofile_filepath"; then
                echo "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" >> "$_zprofile_filepath"
            fi

            if ! grep -qF "export PYENV_ROOT=$_pyenv_home_dir" "$_zprofile_filepath"; then
                echo "export PYENV_ROOT=$_pyenv_home_dir" >> "$_zprofile_filepath"
            fi

            if ! grep -qF "[[ -d \$PYENV_ROOT/bin ]] && export PATH=\$PYENV_ROOT/bin:\$PATH" "$_zprofile_filepath"; then
                echo "[[ -d \$PYENV_ROOT/bin ]] && export PATH=\$PYENV_ROOT/bin:\$PATH" >> "$_zprofile_filepath"
            fi
        fi

        printout "Ok"

        return 0
    fi

    if is_equal "$1" "-ag"; then
        if ! is_arch; then
            printout_exit "You're not using Arch Linux!"
        fi

        printout_markdown "${color_yellow}**This will set up gaming tools on Arch Linux. **${color_reset}"
        printout_blank_line
        printout_no_enter "Are you sure to continue this process [N/y] "

        _confirmation=$(read_input)

        if ! is_equal "$_confirmation" "y"; then
            printout_exit "Aborted!"
        fi

        sudo echo "Configuring..."

        printout "Configuring pacman multilib..."

        sudo sed -i 's/\#\[multilib\]/\[multilib\]\nInclude \= \/etc\/pacman\.d\/mirrorlist/g' "/etc/pacman.conf"

        upgrade_package ""

        install_package "xdg-desktop-portal" "lib32-systemd" "xf86-video-vesa" "lib32-mesa" "lib32-vulkan-radeon" "lib32-amdvlk" \
            "lib32-vulkan-intel" "lib32-nvidia-utils" "ttf-liberation" "steam" "nvidia-utils" "vulkan-nouveau" "lib32-vulkan-nouveau" \
            "vulkan-radeon" "amdvlk" "vulkan-swrast" "lib32-vulkan-swrast" "vulkan-tools" "vulkan-icd-loader" "lib32-vulkan-icd-loader" || printout_exit "Aborted!"

        printout "Ok"

        return 0
    fi

    printout "Aborted!"
}

command_intmb() {
    if is_no_argument "$@"; then
        printout_exit "An option is required!"
    fi

    _config_audio_driver1_dir="$HOME/.umar/macbook/audio"
    _config_audio_driver1_script_name="install.cirrus.driver.sh"
    _config_audio_driver1_url="https://github.com/davidjo/snd_hda_macbookpro.git"
    _config_camera_driver1_dir="$HOME/.umar/macbook/camera1"
    _config_camera_driver2_dir="$HOME/.umar/macbook/camera2"
    _config_camera_driver1_url="https://github.com/patjak/facetimehd-firmware.git"
    _config_camera_driver2_url="https://github.com/patjak/facetimehd.git"
    _config_bluetooth_driver1_dir="$HOME/.umar/macbook/bluetooth"
    _config_bluetooth_driver1_script_name="install.bluetooth.sh"
    _config_bluetooth_driver1_url="https://github.com/leifliddy/macbook12-bluetooth-driver.git"
    _fan_speed_min_filepath="/sys/devices/platform/applesmc.768/fan1_min"
    _fan_speed_max_filepath="/sys/devices/platform/applesmc.768/fan1_max"
    _fan_speed_output_filepath="/sys/devices/platform/applesmc.768/fan1_output"
    _fan_speed_manual_filepath="/sys/devices/platform/applesmc.768/fan1_manual"

    if is_equal "$1" "-a"; then
        printout_markdown "${color_yellow}**This will configure Intel Macbook Audio. **${color_red}**If you're not using Intel Macbook device, DON'T execute this command (MAY BREAK YOUR SYSTEM)**${color_reset}"
        printout_blank_line
        printout_no_enter "Are you sure to continue this process [N/y] "

        _confirmation=$(read_input)

        if ! is_equal "$_confirmation" "y"; then
            printout_exit "Aborted!"
        fi

        check_requirements "git" "sudo"

        if ! is_dir_exist "$_config_audio_driver1_dir"; then
            git clone "$_config_audio_driver1_url" "$_config_audio_driver1_dir"
        fi

        cd "$_config_audio_driver1_dir" || printout_exit "Audio driver1 not found!"

        sudo "./$_config_audio_driver1_script_name"

        printout_blank_line
        printout_markdown "${color_yellow}**Audio successfully configured. You may need to reboot your system or restart your audio service(s)**${color_reset}"
        printout "Ok"

        return 0
    fi

    if is_equal "$1" "-c"; then
        printout_markdown "${color_yellow}**This will configure Intel Macbook Camera. **${color_red}**If you're not using Intel Macbook device, DON'T execute this command (MAY BREAK YOUR SYSTEM)**${color_reset}"
        printout_blank_line
        printout_no_enter "Are you sure to continue this process [N/y] "

        _confirmation=$(read_input)

        if ! is_equal "$_confirmation" "y"; then
            printout_exit "Aborted!"
        fi

        check_requirements "git" "sudo" "make"

        if ! is_dir_exist "$_config_camera_driver1_dir"; then
            git clone "$_config_camera_driver1_url" "$_config_camera_driver1_dir"
        fi

        if ! is_dir_exist "$_config_camera_driver2_dir"; then
            git clone "$_config_camera_driver2_url" "$_config_camera_driver2_dir"
        fi

        cd "$_config_camera_driver1_dir" || printout_exit "Camera driver1 not found!"
        
        make clean
        make

        sudo make install
        
        cd "$_config_camera_driver2_dir" || printout_exit "Camera driver2 not found!"
        
        make clean
        make

        sudo make install
        sudo depmod
        sudo modprobe -r bdc_pci
        sudo modprobe facetimehd

        printout_blank_line
        printout_markdown "${color_yellow}**Camera successfully configured. If it not working, try to reboot your system**${color_reset}"
        printout "Ok"

        return 0
    fi

    if is_equal "$1" "-b"; then
        printout_markdown "${color_yellow}**This will configure Intel Macbook Bluetooth. **${color_red}**If you're not using Intel Macbook device, DON'T execute this command (MAY BREAK YOUR SYSTEM)**${color_reset}"
        printout_blank_line
        printout_no_enter "Are you sure to continue this process [N/y] "

        _confirmation=$(read_input)

        if ! is_equal "$_confirmation" "y"; then
            printout_exit "Aborted!"
        fi

        check_requirements "git" "sudo"

        if ! is_dir_exist "$_config_bluetooth_driver1_dir"; then
            git clone "$_config_bluetooth_driver1_url" "$_config_bluetooth_driver1_dir"
        fi

        cd "$_config_bluetooth_driver1_dir" || printout_exit "Bluetooth driver1 not found!"

        sudo "./$_config_bluetooth_driver1_script_name"

        printout_blank_line
        printout_markdown "${color_yellow}**Bluetooth successfully configured. You may need to reboot your system or restart your bluetooth service(s)**${color_reset}"
        printout "Ok"

        return 0
    fi

    if is_equal "$1" "-f"; then
        shift

        if is_no_argument "$@"; then
            printout "Current Macbook fan speed is $(read_file_content "$_fan_speed_output_filepath")"

            return 0
        fi

        printout_markdown "${color_yellow}**This will configure Macbook Fan Speed. **${color_red}**If you're not using Macbook device, DON'T execute this command (MAY BREAK YOUR SYSTEM)**${color_reset}"
        printout_blank_line
        printout_no_enter "Are you sure to continue this process [N/y] "

        _confirmation=$(read_input)

        if ! is_equal "$_confirmation" "y"; then
            printout_exit "Aborted!"
        fi

        _min_speed=$(read_file_content "$_fan_speed_min_filepath")

        if [ "$1" -lt "$_min_speed" ]; then
            printout_exit "Value under minimum!"
        fi

        _max_speed=$(read_file_content "$_fan_speed_max_filepath")

        if [ "$1" -gt "$_max_speed" ]; then
            printout_exit "Value above maximum!"
        fi

        su -c "echo 1 > $_fan_speed_manual_filepath && echo $1 > $_fan_speed_output_filepath"

        printout "$(read_file_content "$_fan_speed_output_filepath")"
        printout "Ok"

        return 0
    fi

    printout "Aborted!"
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
    __text=$(printout_no_enter "$1" | sed 's/$/\\n/' | tr -d '\n')
    __i=0

    while [ $__i -lt ${#__text} ]; do
        # shellcheck disable=SC2004
        __char=$(printout_as_is "$__text" | cut -c $(($__i+1)))

        if is_equal "$__char" "\\"; then
            # shellcheck disable=SC2004
            __next_char=$(printout_as_is "$__text" | cut -c $(($__i+2)))

            if is_equal "$__next_char" "n"; then
                printout_blank_line

                # shellcheck disable=SC2004
                __i=$(($__i + 1))
            fi
        else
            printout_no_enter "$__char"
        fi

        sleep "0.005"

        # shellcheck disable=SC2004
        __i=$(($__i + 1))
    done

    printout_blank_line
}

# ---------------------------------------------------------------------------------------------------------------------
#
# `check`
# Checks certain conditions
#
# ---------------------------------------------------------------------------------------------------------------------

check_requirements() {
    __not_exist=""
    __iwd=""
    __networkmanager=""

    for __arg in "$@"; do
        if is_package_exist "$__arg" || is_user_package_exist "$__arg"; then
            continue
        fi

        if is_equal "$__arg" "iwctl"; then
            __arg="iwd"
            __iwd="yes"
        fi

        if is_equal "$__arg" "nmcli"; then
            __arg="networkmanager"
            __networkmanager="yes"
        fi

        if is_equal "$__arg" "pactl"; then
            __arg="pulseaudio-utils"
        fi

        if is_equal "$__arg" "ssh"; then
            __arg="openssh"
        fi

        if is_equal "$__arg" "xinput"; then
            __arg="xorg-xinput"
        fi

        if is_equal "$__arg" "xrandr"; then
            __arg="xorg-xrandr"
        fi

        if is_equal "$__arg" "bluetoothctl"; then
            __arg="bluez"

            if is_arch; then
                __arg="bluez-utils"
            fi
        fi

        if is_empty "$__not_exist"; then
            __not_exist="$__arg"
        else
            __not_exist="$__not_exist $__arg"
        fi
    done

    if is_empty "$__not_exist"; then
        return 0
    fi

    if is_equal "$__iwd" "yes"; then
        printout_markdown "${color_yellow}**It seems you want to install **${color_red}**iwd**${color_yellow}**. If you have any other network or wireless daemon installed, **${color_red}**it might cause a conflict between them (MAY BREAK YOUR SYSTEM)**${color_reset}"
    fi

    if is_equal "$__networkmanager" "yes"; then
        printout_markdown "${color_yellow}**It seems you want to install **${color_red}**networkmanager**${color_yellow}**. If you have any other network or wireless daemon installed, **${color_red}**it might cause a conflict between them (MAY BREAK YOUR SYSTEM)**${color_reset}"
    fi

    printout_markdown_no_enter "${color_red}**$__not_exist** ${color_reset}package(s) are not installed. Do you want to install them? [N/y] "

    __confirmation=$(read_input)

    if ! is_equal "$__confirmation" "y"; then
        printout_exit "Aborted!"
    fi

    if is_unknown; then
        printout "Unknown distribution!"
        printout_exit "Aborted!"
    fi

    install_package_arg_split "$__not_exist"

    if is_equal "$__iwd" "yes"; then
        sudo systemctl stop iwd.service > /dev/null 2>&1
        sudo systemctl start iwd.service > /dev/null 2>&1

        sleep 2
    fi

    if is_equal "$__networkmanager" "yes"; then
        sudo systemctl stop NetworkManager > /dev/null 2>&1
        sudo systemctl start NetworkManager > /dev/null 2>&1
        sudo systemctl enable --now NetworkManager > /dev/null 2>&1

        sleep 2
    fi

    printout "The required package(s) have been installed, you may need to refresh the current console/terminal session"
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
    is_equal "$1" "" || is_equal "$1" " "
}

is_contain() {
    printout "$1" | grep -qF "$2"
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
    is_equal "$distro" "debian" || is_equal "$distro" "ubuntu" || is_equal "$distro" "xubuntu"
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
    test -f "/usr/local/bin/$1"
}

is_file_exist() {
    [ -f "$1" ]
}

is_dir_exist() {
    [ -d "$1" ]
}

# ---------------------------------------------------------------------------------------------------------------------
#
# `get`
# Gets value from certain source
#
# ---------------------------------------------------------------------------------------------------------------------

get_tmp_value() {
    __tmp_filepath="$HOME/.umar/tmp_value.cfg"

    if ! is_file_exist "$__tmp_filepath"; then
        return 0
    fi

    read_file_content "$__tmp_filepath"

    clear_tmp_value
}

get_files_from_directory() {
    find "$1" -print0 | while IFS= read -r -d $'' __filepath; do
        if is_file_exist "$__filepath"; then
            __tmp_filepath_content="$(get_tmp_value)"

            if is_empty "$__tmp_filepath_content"; then
                write_to_tmp_value_file "$__filepath"
            else
                write_to_tmp_value_file "$__tmp_filepath_content $__filepath"
            fi
        fi
    done

    get_tmp_value
}

get_files_from_directories() {
    __dir_filepaths=""

    while [ $# -gt 0 ]; do
        __found_filepath=$(get_files_from_directory "$1")

        if ! is_empty "$__found_filepath"; then
            __dir_filepaths="$__dir_filepaths $__found_filepath"
        fi

        shift
    done

    echo "$__dir_filepaths"
}

# ---------------------------------------------------------------------------------------------------------------------
#
# `install`
# Installs something
#
# ---------------------------------------------------------------------------------------------------------------------

install_package() {
    if is_arch; then
        sudo pacman -S "$@" || printout_exit "Aborted!"
    fi

    if is_debian; then
        sudo apt update
        sudo apt install "$@" || printout_exit "Aborted!"
    fi

    if is_fedora; then
        sudo dnf install "$@" || printout_exit "Aborted!"
    fi
}

install_package_arg_split() {
    # shellcheck disable=SC2068
    install_package $@ || printout_exit "Aborted!"
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
# `clean`
# Cleans something
#
# ---------------------------------------------------------------------------------------------------------------------

clean_fancy_quotes() {
    echo "$1" | tr '‘’“”' "\'\'\"\""
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
    __tmp_filepath="$HOME/.umar/tmp_value.cfg"

    if is_file_exist "$__tmp_filepath"; then
        rm -rf "$__tmp_filepath"
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
    __dir_to_be_created="$(clean_fancy_quotes "$1")"

    if ! is_dir_exist "$__dir_to_be_created"; then
        mkdir "$__dir_to_be_created"
    fi
}

create_file() {
    __file_to_be_created="$(clean_fancy_quotes "$1")"

    if ! is_file_exist "$__file_to_be_created"; then
        touch "$__file_to_be_created" || echo "" > "$__file_to_be_created"
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

write_to_tmp_value_file() {
    write_to_file "$1" "$HOME/.umar/tmp_value.cfg"
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
    read -r __input < /dev/tty
    printout "$__input"
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

    __command=""

    if is_equal "$1" "__o_t_a_e_wait=true"; then
        shift

        __command="sh -c '$*; printf \"\n\nPress Enter to exit\n\n\"; read -r _ < /dev/tty'"
    else
        __command="sh -c '$*'"
    fi

    xfce4-terminal -e "$__command"
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

    __url=""
    __content_type="Content-Type: application/json"
    __method="POST"
    __request_body=""
    __authentication=""

    while [ $# -gt 0 ]; do
        case "$1" in
            -url)
                __url="${1#-url}"

                if [ -z "$__url" ]; then
                    shift

                    __url="$1"
                fi
                ;;
            -authentication)
                __authentication="${1#-authentication}"

                if [ -z "$__authentication" ]; then
                    shift

                    __authentication="Authorization: $1"
                fi
                ;;
            -contentType)
                __content_type="${1#-contentType}"

                if [ -z "$__content_type" ]; then
                    shift

                    __content_type="Content-Type: $1"
                fi
                ;;
            -method)
                __method="${1#-method}"

                if [ -z "$__method" ]; then
                    shift

                    __method="$1"
                fi
                ;;
            -requestBody)
                __request_body="${1#-requestBody}"

                if [ -z "$__request_body" ]; then
                    shift

                    __request_body="$1"
                fi
                ;;
        esac

        shift
    done

    curl "$__url" -H "$__authentication" -H "X-TOOL:curl" -H "$__content_type" -X "$__method" -d "$__request_body"
}

http_request_google_ai() {
    check_requirements "jq"

    __http_response=$(http_request -url "https://generativelanguage.googleapis.com/v1beta/models/$1:generateContent?key=$2" -requestBody "\
{
    \"contents\": [
        $3
    ],
    \"generationConfig\": {
        \"temperature\": 0.9
    }
}"
    )

    printout_blank_line

    __text=$(printf '%s\n' "$__http_response" | jq -r '.candidates[0].content.parts[0].text')

    if ! is_equal "$__text" "null"; then
        printout_exit "$__text"
    fi

    __text=$(printf '%s\n' "$__http_response" | jq -r '.error.message')

    if ! is_equal "$__text" "null"; then
        printout_exit "$__text"
    fi

    printout "$__http_response"
}

http_request_chatgpt_ai() {
    check_requirements "jq"

    __http_response=$(http_request -url "https://api.openai.com/v1/chat/completions" -authentication "Bearer $2" -requestBody "\
{
    \"model\": \"$1\",
    \"messages\": [
        $3
    ]
}"
    )

    printout_blank_line

    __text=$(printf '%s\n' "$__http_response" | jq -r '.choices[0].message.content')

    if ! is_equal "$__text" "null"; then
        printout_exit "$__text"
    fi

    __text=$(printf '%s\n' "$__http_response" | jq -r '.error.message')

    if ! is_equal "$__text" "null"; then
        printout_exit "$__text"
    fi

    printout "$__http_response"
}

# ---------------------------------------------------------------------------------------------------------------------
#
# `escape`
# Provides escaping handler
#
# ---------------------------------------------------------------------------------------------------------------------

escape_json_string() {
    sed -e 's/\\/\\\\/g' -e 's/"/\\"/g' -e 's/\n/\\n/g' -e 's/\r/\\r/g' -e 's/\t/\\t/g' -e 's/\f/\\f/g'
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
    italic_start = "\033[3m\033[1m"
    italic_end = "\033[0m\033[0m"
    header_start = "\033[1;37m\033[1m"
    header_end = "\033[0m\033[0m"
    strikethrough_start = "\033[9m\033[1m"
    strikethrough_end = "\033[0m\033[0m"
    code_start = "\033[0;36m\033[1m"
    code_end = "\033[0m\033[0m"
    link_start = "\033[4m\033[1m"
    link_end = "\033[0m\033[0m"
    horizontal_rule = "\033[2m────────────────────────────────────────────────────────────\033[0m"
    code_block_start = "\033[0;32m\033[1m"
    code_block_end = "\033[0m\033[0m"
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
