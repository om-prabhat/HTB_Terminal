function showRetiredMachines(){
    local retired_options_selected=$1
    case "$retired_options_selected" in
        "Completed")
            retired_options_selected_output_next=notnull
            retired_machines_menu_items=()
            retired_machines_ids=()
            while [[ "$retired_options_selected_output_next" != "null" && -n "$retired_options_selected_output_next" ]]; do
                local url="https://labs.hackthebox.com/api/v4/machine/list/retired/paginated?per_page=100&show_completed=complete"
                retired_options_selected_output=$(curl -sS -X 'GET' $url -H "Authorization: Bearer $token")
                url=$(echo $retired_options_selected_output | jq -r .links.next)
                retired_options_selected_output_next=$url
                retired_options_selected_output_formatted=$(echo $retired_options_selected_output | jq -r '.data[] | [.id, .name, .os, .difficultyText] | @tsv')
                while IFS=$'\t' read -r id name os difficulty; do
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
                    retired_machines_menu_items+=("$name ($difficulty) $os_short")
				    retired_machines_ids+=("$id")
                done <<<"$retired_options_selected_output_formatted"
            done
            selected=$(printf "%s\n" "${retired_machines_menu_items[@]}" | rofi -i -config ~/.config/rofi/htb/themes/rasi/htb_theme.rasi -dmenu -p "Select an option (use ↑ ↓ arrows and Enter)")
            ;;
        "Incomplete")
            retired_options_selected_output_next="https://labs.hackthebox.com/api/v4/machine/list/retired/paginated?per_page=100&show_completed=incomplete"
            retired_machines_menu_items=()
            retired_machines_ids=()
            while [[ "$retired_options_selected_output_next" != "null" && -n "$retired_options_selected_output_next" ]]; do
                retired_options_selected_output=$(curl -sS -X 'GET' $retired_options_selected_output_next -H "Authorization: Bearer $token")
                retired_options_selected_output_next=$(echo $retired_options_selected_output | jq -r .links.next)
                retired_options_selected_output_formatted=$(echo $retired_options_selected_output | jq -r '.data[] | [.id, .name, .os, .difficultyText] | @tsv')
                while IFS=$'\t' read -r id name os difficulty; do
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
                    retired_machines_menu_items+=("$name ($difficulty) $os_short")
				    retired_machines_ids+=("$id")
                done <<<"$retired_options_selected_output_formatted"
            done
            selected=$(printf "%s\n" "${retired_machines_menu_items[@]}" | rofi -i -config ~/.config/rofi/htb/themes/rasi/htb_theme.rasi -dmenu -p "Select an option (use ↑ ↓ arrows and Enter)")
            ;;
        "Both")
            retired_options_selected_output_next="https://labs.hackthebox.com/api/v4/machine/list/retired/paginated?per_page=100"
            retired_machines_menu_items=()
            retired_machines_ids=()
            while [[ "$retired_options_selected_output_next" != "null" && -n "$retired_options_selected_output_next" ]]; do
                retired_options_selected_output=$(curl -sS -X 'GET' $retired_options_selected_output_next -H "Authorization: Bearer $token")
                retired_options_selected_output_next=$(echo $retired_options_selected_output | jq -r .links.next)
                retired_options_selected_output_formatted=$(echo $retired_options_selected_output | jq -r '.data[] | [.id, .name, .os, .difficultyText] | @tsv')
                while IFS=$'\t' read -r id name os difficulty; do
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
                    retired_machines_menu_items+=("$name ($difficulty) $os_short")
				    retired_machines_ids+=("$id")
                done <<<"$retired_options_selected_output_formatted"
            done
            selected=$(printf "%s\n" "${retired_machines_menu_items[@]}" | rofi -i -config ~/.config/rofi/htb/themes/rasi/htb_theme.rasi -dmenu -p "Select an option (use ↑ ↓ arrows and Enter)")
            ;;
        "Exit")
            return
            ;;
    esac
}