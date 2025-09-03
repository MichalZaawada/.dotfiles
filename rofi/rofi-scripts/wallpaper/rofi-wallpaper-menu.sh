#!/usr/bin/env bash

wallpaper_list=$(ls ~/.dotfiles/wallpapers/ | sed 's/ //g')

chosen_wallpaper=$(echo -e "$wallpaper_list" | rofi -dmenu -i -selected-row 1 -p "Wallpaper:" )

read -r chosen_wallpaper <<< "${chosen_wallpaper}"

if [ "$chosen_wallpaper" = "" ]; then
	exit
else
	pkill -x swaybg
	swaybg -i ~/.dotfiles/wallpapers/"$chosen_wallpaper" -m fill
fi
