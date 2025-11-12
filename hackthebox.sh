#!/usr/bin/env bash
token=$(cat ~/.config/rofi/htb/.token)
source ~/.config/rofi/htb/machines/active/activeMachine.sh
source ~/.config/rofi/htb/machines/active/machineDetail.sh
source ~/.config/rofi/htb/machines/retired/retiredMachine.sh
source ~/.config/rofi/htb/machines/submitFlag.sh
source ~/.config/rofi/htb/search/showSearch.sh

options=( "Submit Flag" "Reset Machine" "Show Active Machines" "Show Running Machine Details" "Show Retired Machines - This can take time" "Search" "Exit")
selected=$(printf '%s\n' "${options[@]}" | rofi -i -config ~/.config/rofi/htb/themes/rasi/htb_theme.rasi -dmenu -p "Select an option (use ↑ ↓ arrows and Enter)")
case "$selected" in 
	"Show Active Machines")
		active_options=("Completed" "Incomplete" "Both" "Exit")
		active_options_selected=$(printf '%s\n' "${active_options[@]}"| rofi -i -config ~/.config/rofi/htb/themes/rasi/htb_theme.rasi -dmenu -p "Select an option (use ↑ ↓ arrows and Enter)")
		showActiveMachines "$active_options_selected"
		;;
	"Show Running Machine Details")
		running_machine=$(curl -sS -X 'GET' 'https://labs.hackthebox.com/api/v4/machine/active' -H 'accept: application/json' -H "Authorization: Bearer $token")
		running_machine_id=$(echo $running_machine| jq .info.id)
		running_machine_name=$(echo $running_machine| jq .info.name|tr -d '"')
		if [[ "$running_machine_id" == "null" && -n "$running_machine_id" ]];then
			echo "OK" | rofi -i -config ~/.config/rofi/htb/themes/rasi/dialog.rasi -dmenu -p "No active Machine!" > /dev/null
			exit 0
		fi
		showmachineDetails "$running_machine_name"
		;;
	"Reset Machine")
		running_machine=$(curl -sS -X 'GET' 'https://labs.hackthebox.com/api/v4/machine/active' -H 'accept: application/json' -H "Authorization: Bearer $token")
		running_machine_id=$(echo $running_machine| jq .info.id)
		running_machine_name=$(echo $running_machine| jq .info.name|tr -d '"')
		if [[ "$running_machine_id" == "null" && -n "$running_machine_id" ]];then
			echo "OK" | rofi -i -config ~/.config/rofi/htb/themes/rasi/dialog.rasi -dmenu -p "No active Machine!" > /dev/null
			exit 0
		fi
		resetMachine "$running_machine_id" "$running_machine_name"
		;;
	"Submit Flag")
		running_machine=$(curl -sS -X 'GET' 'https://labs.hackthebox.com/api/v4/machine/active' -H 'accept: application/json' -H "Authorization: Bearer $token")
		running_machine_id=$(echo $running_machine| jq .info.id)
		if [[ "$running_machine_id" == "null" && -n "$running_machine_id" ]];then
			echo "OK" | rofi -i -config ~/.config/rofi/htb/themes/rasi/dialog.rasi -dmenu -p "No active Machine!" > /dev/null
			exit 0
		fi
		flag=$(rofi -config ~/.config/rofi/htb/themes/rasi/htb_theme.rasi -dmenu -p "Enter Flag: ")
		submitFlag "$flag" "$running_machine_id"
		;;
	"Show Retired Machines - This can take time")
		retired_options=("Completed" "Incomplete" "Both" "Exit")
		retired_options_selected=$(printf '%s\n' "${retired_options[@]}" | rofi -i -config ~/.config/rofi/htb/themes/rasi/htb_theme.rasi -dmenu -p "Select an option (use ↑ ↓ arrows and Enter)")
		showRetiredMachines "$retired_options_selected"
		;;
	"Search")
		search=$(rofi -i -config ~/.config/rofi/htb/themes/rasi/htb_theme.rasi -dmenu -p "Search: ")
		data=$(curl -sS -X 'GET' "https://labs.hackthebox.com/api/v4/search/fetch?query=$search" -H 'accept: application/json' -H "Authorization: Bearer $token")
		showSearch "$data"
		;;
	"Exit")
		exit 0
		;;
esac