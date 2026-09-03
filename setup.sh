#!/bin/bash

# Farbvariablen und Styling für bessere Ausgabe
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
BOLD='\033[1m'
RESET='\033[0m'

# Nachrichtenfunktion
msg_ok() {
	echo -e "${BOLD}${GREEN}[] $1${RESET}";
}  

setup_dotfiles() {
	echo "Updating CORECRYPT..."
	sudo apt update -y
	sudo apt upgrade -y

	echo "Benötigte Pakete werden installiert..."
	xargs apt install -y < packages.txt

	echo "Erstelle Symlinks..."
	ln -sfn /usr/bin/batcat ~/.local/bin/bat
	ln -sfn ~/dotfiles/bash/.bashrc ~/.bashrc
	ln -sfn ~/dotfiles/feh/.fehbg ~/.fehbg
	ln -sfn ~/dotfiles/lightdm/.dmrc ~/.dmrc
	ln -sfn ~/dotfiles/starship.toml ~/.config/starship.toml
	ln -sfn ~/dotfiles/bash ~/.config/bash
	ln -sfn ~/dotfiles/nvim ~/.config/nvim
	ln -sfn ~/dotfiles/tmux ~/.config/tmux
	ln -sfn ~/dotfiles/dunst ~/.config/dunst
	ln -sfn ~/dotfiles/i3 ~/.config/i3
	ln -sfn ~/dotfiles/i3blocks ~/.config/i3blocks
	ln -sfn ~/dotfiles/kitty ~/.config/kitty
	ln -sfn ~/dotfiles/picom ~/.config/picom
	ln -sfn ~/dotfiles/polybar ~/.config/polybar
	ln -sfn ~/dotfiles/rofi ~/.config/rofi

	msg_ok "Setup erfolgreich abgeschlossen."
}

generate_package_list() {
	echo "Die Liste der aktuell installierten Pakete wird erstellt..."
	dpkg --get-selections | grep -v deinstall | awk '{print $1}' > ~/dotfiles/packages.txt
	msg_ok "Paketliste erstellt: ~/dotfiles/packages.txt"
	msg_ok "Die Liste enthält aktuell $(wc -l < ~/dotfiles/packages.txt) Pakete."
}

system_update(){
	sudo apt update -y
	sudo apt upgrade -y
	msg_ok "Corecrypt wurde erfolgreich aktualisiert."
}
	
# Simples Menü um Funktionen auszuwählen.
echo -e "${BOLD}${BLUE}󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋${RESET}"
echo -e "${BOLD}${BLUE}     CORECRYPT SETUP SYSTEM     ${RESET}"
echo -e "${BOLD}${BLUE}󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋󰯋${RESET}\n"

echo "Was willst du tun?"
select option in "Setup Dotfiles + Pakete" "Paketliste erstellen" "Corecrypt aktualisieren" "Beenden"; do
	case $REPLY in
		1) setup_dotfiles ;;
		2) generate_package_list ;;
		3) system_update ;;
		4) exit ;;
		*) echo "Ungültige Auswahl";;
	esac
done
