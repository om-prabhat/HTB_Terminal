function submitFlag(){
    local flagValue=$1
    local machine_id=$2
    return=$(curl -sS -X 'POST' 'https://labs.hackthebox.com/api/v5/machine/own' -H 'accept: application/json' -H "Authorization: Bearer $token" -H 'content-type: application/json' -d "{\"id\": $machine_id,\"flag\": \"$flagValue\"}")
    return_message=$(echo $return | jq -r .message)
    ret_msg_selected=$(printf '%s\n' "OK" | rofi -config ~/.config/rofi/htb/themes/rasi/dialog.rasi -dmenu -p "$return_message")
}