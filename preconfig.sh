#### TERMINADO (Falta comprobar configuración de red)
function PreConfig() {
	clear
	touch $LOG #Creates log file

	if [ ! -w $LOG ]; then #Checks that it is possible to write to the log file
		echo "Error creating temporary file"
		echo "Leaving the installer"
		exit 1
	fi

	#Pedir introducir el idioma de teclado
	function selectKeyboard() {
		while true; do
			clear
			echo "Select your keyboard layout"
			# https://wiki.archlinux.org/index.php/Keyboard_configuration_in_console
			echo "es for spanish keyboard"
			echo "uk for United Kingdom english layout"
			echo "fr for frech layout"
			echo "de for deutsch layout"
			echo "us for United States of America english layout"

			read LANGUAGE

			case $LANGUAGE in
				es|ES) LANGUAGE="es"
						break;;
				uk|UK) LANGUAGE="uk"
						break;;
				fr|FR) LANGUAGE="fr"
						break;;
				de|DE) LANGUAGE="de"
						break;;
				us|US) LANGUAGE="us"
						break;;
				*) echo "Invalid choice, write just es, uk, fr, de or us"
					echo "Press Enter to continue"
					read input;;
			esac
		done

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

	mount -o remount,size=2G /run/archiso/cowspace 2>> $LOG && echo "Live system memory (/run/archiso/cowspace) set to 2GB" >> $LOG
	echo "Live system memory (/run/archiso/cowspace) set to 2GB"
}

