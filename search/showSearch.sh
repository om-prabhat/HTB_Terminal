function showTeams(){
    local data_teams=$1
    data_teams_menu_items=()
    if [[ "$data_teams" != "null" && -n "$data_teams" ]];then
        while IFS=$'\t' read -r id name; do
            data_teams_menu_items+=("$id $name")
        done <<<"$data_teams"
        selected=$(printf '%s\n' "${data_teams_menu_items[@]}" | rofi -i -config ~/.config/rofi/htb/themes/rasi/htb_theme.rasi -dmenu -p "Teams")
    fi
    exit 0
}

function showUsers(){
    local data_users=$1
    data_users_menu_items=()
    if [[ "$data_users" != "null" && -n "$data_users" ]];then
        while IFS=$'\t' read -r id name; do
            data_users_menu_items+=("$id $name")
        done <<<"$data_users"
        selected=$(printf '%s\n' "${data_users_menu_items[@]}" | rofi -i -config ~/.config/rofi/htb/themes/rasi/htb_theme.rasi -dmenu -p "Users")
    fi
    exit 0
}

function showChallenges(){
    local data_challenges=$1
    data_challenges_menu_items=()
    if [[ "$data_challenges" != "null" && -n "$data_challenges" ]];then
        while IFS=$'\t' read -r id category name; do
            data_challenges_menu_items+=("$id $category $name")
        done <<<"$data_challenges"
        selected=$(printf '%s\n' "${data_challenges_menu_items[@]}" | rofi -i -config ~/.config/rofi/htb/themes/rasi/htb_theme.rasi -dmenu -p "Challenges")
    fi
    exit 0
}

function showSherlocks(){
    local data_sherlocks=$1
    data_sherlocks_menu_items=()
    if [[ "$data_sherlocks" != "null" && -n "$data_sherlocks" ]];then
        while IFS=$'\t' read -r id category name; do
            data_sherlocks_menu_items+=("$id $category $name")
        done <<<"$data_sherlocks"
        selected=$(printf '%s\n' "${data_sherlocks_menu_items[@]}" | rofi -i -config ~/.config/rofi/htb/themes/rasi/htb_theme.rasi -dmenu -p "Sherlocks")
    fi
    exit 0
}

function showMachines(){
    local data_machines=$1
    data_machines_menu_items=()
    if [[ "$data_machines" != "null" && -n "$data_machines" ]];then
        while IFS=$'\t' read -r id name; do
            data_machines_menu_items+=("$id $name")
        done <<<"$data_machines"
        selected=$(printf '%s\n' "${data_machines_menu_items[@]}" | rofi -i -config ~/.config/rofi/htb/themes/rasi/htb_theme.rasi -dmenu -p "Machines")
    fi
    exit 0
}

function showSearch(){
    local data=$1
    options=("Teams" "Users" "Challenges" "Sherlocks" "Machines" "Exit")
    selected=$(printf '%s\n' "${options[@]}" | rofi -i -config ~/.config/rofi/htb/themes/rasi/htb_theme.rasi -dmenu -p "Choose to explore")
    case "$selected" in
        "Teams")
            if [[ $(echo $data | jq -r '.teams') != "null"  ]];then
                data_teams=$(echo $data | jq -r '.teams[] | [.id, .value] | @tsv')
                showTeams "$data_teams"
            fi
            printf '%s\n' "OK" | rofi -i -config ~/.config/rofi/htb/themes/rasi/dialog.rasi -dmenu -p "No Team found with this name."
            exit 0
            ;;
        "Users")
            if [[ $(echo $data | jq -r '.users') != "null"  ]];then
                data_users=$(echo $data | jq -r '.users[] | [.id, .value] | @tsv')
                showUsers "$data_users"
            fi
            printf '%s\n' "OK" | rofi -i -config ~/.config/rofi/htb/themes/rasi/dialog.rasi -dmenu -p "No User found with this name."
            exit 0
            ;;
        "Challenges")
            if [[ $(echo $data | jq -r '.challenges') != "null"  ]];then
                data_challenges=$(echo $data | jq -r '.challenges[] | [.id, .category_name, .value] | @tsv')
                showChallenges "$data_challenges"
            fi
            printf '%s\n' "OK" | rofi -i -config ~/.config/rofi/htb/themes/rasi/dialog.rasi -dmenu -p "No Challenge found with this name."
            exit 0
            ;;
        "Sherlocks")
            if [[ $(echo $data | jq -r '.sherlocks') != "null"  ]];then
                data_sherlocks=$(echo $data | jq -r '.sherlocks[] | [.id, .category_name, .value] | @tsv')
                showSherlocks "$data_sherlocks"
            fi
            printf '%s\n' "OK" | rofi -i -config ~/.config/rofi/htb/themes/rasi/dialog.rasi -dmenu -p "No Sherlocks found with this name."
            exit 0
            ;;
        "Machines")
            if [[ $(echo $data | jq -r '.machines') != "null"  ]];then
                data_machines=$(echo $data | jq -r '.machines[] | [.id, .value] | @tsv')
                showMachines "$data_machines"
            fi
            printf '%s\n' "OK" | rofi -i -config ~/.config/rofi/htb/themes/rasi/dialog.rasi -dmenu -p "No Machines found with this name."
            exit 0
            ;;
        "Exit")
            exit 0
            ;;
    esac
}