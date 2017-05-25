#!/bin/bash

#Variables
USER=`whoami`
DEBUG="true"
LOG="/tmp/ArchInstall"

#Function that gives information about the installation process
function InfoHelp() {
	echo "Advertencia e instrucciones a continuación"
	echo "This installer script will takes the following steps, please write them down so that you can easily follow the installation process"
	echo "1) ....."
	echo "2) ....."
	echo "3) ....."
	echo "4) ....."
	echo "5) ....."
	echo "6) ....."
	echo ""
	echo "From now on keep in mind that when you see [y/n] you must answer y (affirmative answer) or n (negative answer)"
	echo "Continue? [y/n]"

	read input
	while true
		do
			case $input in
				Y|y) break;;
				N|n) exit 0;;
				*) echo "Invalid answer, please just answer y for yes or n for no [y/n]";;
			esac
		done
}

function preconfig() {
	touch $LOG #Creates log file

	if [ ! -w $LOG ]; then #Checks that it is possible to write to the log file
		echo "Error creating temporary file"
		echo "Leaving the installer"
		exit 1
	fi
	
##### Añadir opción de poner el teclado en varios idiomas https://wiki.archlinux.org/index.php/Keyboard_configuration_in_console
##### Comando `locacectl status` para ver la distribución actual del teclado, la salida te la dejo en imgur por si quieres mostrar una parte de la salida y preguntar si es correcto tras elegir la distribución de teclado: http://i.imgur.com/JKrqIu7.png
##### Comando para cargar la distribuciones del teclado `loadkeys X` donde X es el código de la distribución, aquí tienes la información necesaria: https://wiki.archlinux.org/index.php/Keyboard_configuration_in_console#Keymap_codes
##### Para ver una lista de todos los códigos disponibles ejecutar `find /usr/share/kbd/keymaps/ -type f`, su salida (el código que debes poner donde la X es el nombre del archivo sin la extension .map.gz, por ejemplo para ponerlo en español es `loadkeys es` porque el nombre del archivo es es.map.gz): https://bpaste.net/show/c9e19c8e273d
##### Con añadir las opciones de teclado para alemán, francés, inglés de USA y de UK y de España va sobrado creo yo.
##### Más tarde hay que elegir la distribución de teclado que tendrá el sistema instalado, en concreto cuando hay que editar el archivo /etc/vconsole.conf (simplemente añadir KEYMAP=X, de nuevo la X será el código de teclado a usar, busca `vconsole` en Test2.bash para ver como va), la idea es preguntar si desea meter la misma distribución de teclado en el sistema instalado que la que haya elegido en el live. 
##### En la línea que hay justo aquí debajo deberías añadir un link o variable o como sea para que cuando por ejemlo ponga el teclado en inglés de UK que lo ponga en el echo.

	loadkeys es 2>> $LOG && echo "Teclado del entorno live configurado a español" >> $LOG #Establece teclado en español

	mount -o remount,size=2G /run/archiso/cowspace 2>> $LOG && echo "/run/archiso/cowspace ampliada a 2GB" >> $LOG

	#Comprobar internet

	#Actualizar pacman y git sin pedir confirmación?=?
	# pacman -Syy --noconfirm git
	# echo "git instalado"
}

#LLamada a las funciones
InfoHelp
preconfig

exit 0
