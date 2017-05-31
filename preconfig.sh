function PreConfig() {
	clear

	touch $LOG 2>> /dev/null # Creates log file

	mount -o remount,size=2G /run/archiso/cowspace 2>> $LOG && echo "Live system memory (/run/archiso/cowspace) set to 2GB" >> $LOG
	echo "Live system memory (/run/archiso/cowspace) set to 2GB"

	echo "Instalando reflector y actualizando la mirrorlist del live para usar lor mirrors más rápidos"
	pacman -Syy reflector --noconfirm && echo "reflector instalado correctamente" >> $LOG || echo "reflector no instalado" >> $LOG
	reflector --latest 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist && echo "Mirror más rápido elegido" >> $LOG





	if [ ! -w $LOG ]; then #Checks that it is possible to write to the log file
		echo "Error creating temporary file"
		echo "Leaving the installer"
		exit 1
	fi

	function selectKeyboard() {

		# https://wiki.archlinux.org/index.php/Keyboard_configuration_in_console#Keymap_codes
		##### Filtrar códigos disponibles para loadkeys --> `find /usr/share/kbd/keymaps/ -type f`
		# Establece teclado en el idioma elegido
		loadkeys $LANGUAGE 2>> $LOG && echo "Live environment keyboard layout has been set to $LANGUAGE" >> $LOG
		echo ""
		echo "Keyboard layout actual info:"
		localectl status #Shows keyboard layout actual info
		echo ""
	}

	selectKeyboard

	while true; do
		echo "It is right? [y/n]"

		read input

		case $input in
			y|Y) break;;
			n|N) selectKeyboard;;
			*) echo "Invalid answer, please answer just y for yes or n for no [y/n]"
		esac
	done
}

