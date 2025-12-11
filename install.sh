#!/usr/bin/env bash

deps="[+] Installing Dependencies."

for ((i=0; i<${#deps}; i++)) do
	echo -ne "\033[32m${deps:$i:1}\033[0m"
	sleep 0.05
done
echo ""

if command -v apt >/dev/null 2>&1;then
	sudo apt update
	sudo apt install -y rofi curl jq xclip
elif command -v pacman >/dev/null 2>&1;then
	sudo pacman -Sy --noconfirm rofi curl jq xclip
else 
	echo -e "\033[31mUnsupported package manager. Install rofi, curl, jq, xclip manually.\033[0m"
fi


#sudo apt install rofi curl jq xclip -y

ins="[+] Installing..."

for ((i=0; i<${#ins}; i++)) do
	echo -ne "\033[32m${ins:$i:1}\033[0m"
	sleep 0.05
done
echo ""
mkdir -p ~/.config/rofi/htb
cp -r hackthebox.sh machines search themes ~/.config/rofi/htb/

pins="[+] Post installation Setup..."

for ((i=0;i<${#pins};i++)) do
	echo -ne "\033[32m${pins:$i:1}\033[0m"
	sleep 0.05
done
echo ""
echo -e "\033[34mhttps://app.hackthebox.com/account-settings\033[0m"
read -p "Enter your token: " token
echo $token > ~/.config/rofi/htb/.token

fins="[+] You need to manually set alias or keymap to this path."

for ((i=0; i<${#fins}; i++)) do
	echo -ne "\033[32m${fins:$i:1}\033[0m"
	sleep 0.05
done
echo ""
echo "~/.config/rofi/htb/hackthebox.sh"
