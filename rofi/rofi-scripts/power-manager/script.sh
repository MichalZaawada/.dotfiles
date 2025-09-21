#!/usr/bin/env bash

shutdown_menu=$(echo -e "Yes\nNo" | rofi -dmenu -i -selected-row 1 -p "Shutdown:" )

read -r shutdown_menu <<< "${shutdown_menu}"

if [ "$shutdown_menu" = "Yes" ]; then
	systemctl poweroff
else
	exit
fi
