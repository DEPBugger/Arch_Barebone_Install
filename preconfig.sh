function PreConfig() {
	clear

	touch $LOG 2>> /dev/null # Creates log file

	if [ ! -w $LOG ]; then #Checks that it is possible to write to the log file
		echo "Error creating temporary file"
		echo "Leaving the installer"
		exit 1
	fi

	mount -o remount,size=2G /run/archiso/cowspace 2>> $LOG && echo "Live system memory (/run/archiso/cowspace) set to 2GB" >> $LOG
	echo "Live system memory (/run/archiso/cowspace) set to 2GB"

	function selectKeyboard() {
		# Establece teclado en el idioma elegido
		loadkeys $LANGUAGE 2>> $LOG && echo "Live environment keyboard layout has been set to $LANGUAGE" >> $LOG
		echo ""
		echo "Keyboard layout actual info:"
		localectl status #Shows keyboard layout actual info
		sleep 3s
		echo ""
	}

	selectKeyboard
}

