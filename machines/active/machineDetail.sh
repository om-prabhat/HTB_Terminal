function showmachineDetails(){
	local running_machine_name=$1
	running_machine_details=$(curl -sS -X 'GET' "https://labs.hackthebox.com/api/v4/machine/profile/$running_machine_name" -H 'accept: application/json' -H "Authorization: Bearer $token")
	running_machine_details_name=$(echo $running_machine_details | jq .info.name | tr -d '"')
	running_machine_details_os=$(echo $running_machine_details | jq .info.os | tr -d '"')
	running_machine_details_points=$(echo $running_machine_details | jq .info.points)
	running_machine_details_ip=$(echo $running_machine_details | jq .info.ip | tr -d '"')
	running_machine_details_difficultyText=$(echo $running_machine_details | jq .info.difficultyText | tr -d '"')
	running_machine_details_selected=$(printf '%s\n' "Name: $running_machine_details_name" "OS: $running_machine_details_os" "IP: $running_machine_details_ip (Select to copy)" "Difficulty: $running_machine_details_difficultyText" "Points: $running_machine_details_points" "Go Back" | rofi -i -config ~/.config/rofi/htb/themes/rasi/htb_theme.rasi -dmenu -p "Select an option (use ↑ ↓ arrows and Enter)")
	case "$running_machine_details_selected" in
		"IP: $running_machine_details_ip (Select to copy)")
			echo -n $running_machine_details_ip | xclip -sel p -sel c
			return
			;;
		"Go Back")
			return
			;;
	esac
}