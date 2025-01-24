#!/bin/bash

install_config_link() {
    local path="$1"
    local target="$2"
    local name="$3"

    path=$(realpath -m "$path")
    target=$(realpath -m "$target")

    if [ ! -e $target ]; then
    	echo "=> Creating $name config symlink: $path -> $target"
        ln -s "$path" "$target" 
        echo "=> Created $name config"
    else
        echo "=> $name config already exists..."
    fi
}

script_dir=$(dirname "$(realpath "$0")")

install_config_link "$script_dir/nvim" "$HOME/.config/nvim" "NeoVim"
install_config_link "$script_dir/wezterm" "$HOME/.config/wezterm" "WezTerm"

