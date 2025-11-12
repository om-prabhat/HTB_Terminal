function showActiveMachines(){
	local active_options_selected=$1
	case "$active_options_selected" in 
		"Completed")
			active_options_selected_output=$(curl -sS -X 'GET' "https://labs.hackthebox.com/api/v4/machine/paginated?per_page=20&show_completed=complete" -H 'accept: application/json' -H "Authorization: Bearer $token" | jq -r '.data[] | [.id, .name, .os, .difficultyText, (.active // "false")] | @tsv')
			active_machines_menu_items=()
			active_machines_ids=()
			while IFS=$'\t' read -r id name os difficulty active; do
				case "$os" in 
					"Windows")
						os_short=""
						;;
					"Linux")
						os_short=""
						;;
					*)
						os_short=""
						;;
				esac
				case "$active" in
					"false")
						active="Not Started"
						;;
					"true")
						active="Running"
						;;
				esac
				active_machines_menu_items+=("$name ($difficulty) $os_short $active")
				active_machines_ids+=("$id")
			done <<<"$active_options_selected_output"
			selected=$(printf "%s\n" "${active_machines_menu_items[@]}" | rofi -i -config ~/.config/rofi/htb/themes/rasi/htb_theme.rasi -dmenu -p "Select an option (use ↑ ↓ arrows and Enter)")
			;;
		"Incomplete")
			active_options_selected_output=$(curl -sS -X 'GET' "https://labs.hackthebox.com/api/v4/machine/paginated?per_page=20&show_completed=incomplete" -H 'accept: application/json' -H "Authorization: Bearer $token" | jq -r '.data[] | [.id, .name, .os, .difficultyText, (.active // "false")] | @tsv')
			active_machines_menu_items=()
			active_machines_ids=()
			while IFS=$'\t' read -r id name os difficulty active; do
				case "$os" in 
					"Windows")
						os_short=""
						;;
					"Linux")
						os_short=""
						;;
					*)
						os_short=""
						;;
				esac
				case "$active" in
					"false")
						active="Not Started"
						;;
					"true")
						active="Running"
						;;
				esac
				active_machines_menu_items+=("$name ($difficulty) $os_short $active")
				active_machines_ids+=("$id")
			done <<<"$active_options_selected_output"
			selected=$(printf "%s\n" "${active_machines_menu_items[@]}" | rofi -i -config ~/.config/rofi/htb/themes/rasi/htb_theme.rasi -dmenu -p "Select an option (use ↑ ↓ arrows and Enter)")
			;;
		"Both")
			active_options_selected_output=$(curl -sS -X 'GET' "https://labs.hackthebox.com/api/v4/machine/paginated?per_page=20" -H 'accept: application/json' -H "Authorization: Bearer $token" | jq -r '.data[] | [.id, .name, .os, .difficultyText, (.active // "false")] | @tsv')
			active_machines_menu_items=()
			active_machines_ids=()
			while IFS=$'\t' read -r id name os difficulty active; do
				case "$os" in 
					"Windows")
						os_short=""
						;;
					"Linux")
						os_short=""
						;;
					*)
						os_short=""
						;;
				esac
				case "$active" in
					"false")
						active="Not Started"
						;;
					"true")
						active="Running"
						;;
				esac
				active_machines_menu_items+=("$name ($difficulty) $os_short $active")
				active_machines_ids+=("$id")
			done <<<"$active_options_selected_output"
			selected=$(printf "%s\n" "${active_machines_menu_items[@]}" | rofi -i -config ~/.config/rofi/htb/themes/rasi/htb_theme.rasi -dmenu -p "Select an option (use ↑ ↓ arrows and Enter)")
			;;
		"Exit")
			return
			;;
	esac
}

function resetMachine(){
	local running_machine_id=$1
	local running_machine_name=$2
	running_machine_selected=$(printf '%s\n' "Yes" "No" | rofi -i -config ~/.config/rofi/htb/themes/rasi/confirmation.rasi -dmenu -p "Reset the machine?")
	case "$running_machine_selected" in
		"Yes")
			curl -sS -X 'POST' 'https://labs.hackthebox.com/api/v4/vm/reset' -H 'accept: application/json' -H "Authorization: Bearer $token" -H 'content-type: application/json' -d "{\"machine_id\": $running_machine_id}" > /dev/null
			return
			;;
		"No")
			return
			;;
	esac
}