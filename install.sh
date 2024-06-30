#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

# git pull origin main;

function ask() {
    # http://djm.me/ask, dwmkerr/dotfiles
    local prompt default REPLY

    while true; do

        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi

        # Ask the question (not using "read -p" as it uses stderr not stdout)
        printf "$1 [$prompt] "

        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read REPLY </dev/tty

        # Default?
        if [ -z "$REPLY" ]; then
            REPLY=$default
        fi

        # Check if the reply is valid
        case "$REPLY" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}

function install_tmux() {
    sudo apt-get install -y tmux
}

function install_tpm() {
    # Setup the tmux plugin manager if it is not already installed.
    rm -rf ~/.tmux/plugins/tpm  || true
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    # Install tmux plugins.
    # ~/.tmux/plugins/tpm/scripts/install_plugins.sh
}

function sync_dotfiles() {
    rsync --exclude ".git/" --exclude "bootstrap.sh" --exclude "README.md" -avh --no-perms . ~;
    source ~/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    sync_dotfiles;
    install_tmux;
else
    if ask "This may overwrite existing files in your home directory. Are you sure?" Y; then
        sync_dotfiles;
    fi;

    if ask "Install/Update tmux?" Y; then
        install_tmux;
    fi;
fi;

unset ask;
unset sync_dotfiles;
unset install_tmux;
unset install_tpm;
