#!/bin/bash

#Variables
USER=`whoami`
DEBUG="true"
LOG="/tmp/ArchInstall"

#Function that gives information about the installation process
function InfoHelp() {
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

	while true
		do
			read input

			case $input in
				Y|y) break;;
				N|n) exit 0;;
				*) echo "Invalid answer, please just answer y for yes or n for no [y/n]";;
			esac
		done
}

function PreConfig() {
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

function ConfRed() {
	dhcpcd 2>> $LOG && echo "El comando dhcpcd ha funcionado correctamente" >> $LOG

	# Comprobar que hay conexión
	# ping -c 3 kernel.org
	echo "Hay conexión de red" >> $LOG
}

function ConfDisk() {
	echo "Comprobando tus Discos Duros y Particiones en ellos."
	sleep 1s
	echo "Comprobando tus Discos Duros y Particiones en ellos.."
	sleep 1s
	echo "Comprobando tus Discos Duros y Particiones en ellos..."
	sleep 1s

	lsblk

	#function ToFormat(efi raiz boot home) {
		#Comprobar entradas, descartar vacíos y formatear
		#Los vacíos se descartan

		#tomar variables de entrada
	#}

	function HelpDisk() { #Función para particionmiento guiado
		#Preguntar paso a paso
		clear
		echo "Particionar el disco duro"
		# echo "Crear partición boot [s/n]"
		# echo "Crear partición home [s/n]"

		# echo "Introduce tamaño para EFI (recomendado 100mb)
		# echo "Introduce tamaño para raíz"
		# echo "Introduce tamaño para boot"
		# echo "Introduce tamaño para home"
	}

	function ManualDisk() { #Función para particionamiento manual
		# Tienes X discos duros elige donde instalar (si tiene solo 1 continuar)
		# if [ 1HDD ]; then
		# 	cfdisk /dev/sda
		# else
				#Mostrar discos duros
				# echo "Introduce el disco duro"
				# echo "El disco elegido es: XXXX???"
				# echo "Pulsa una tecla para continuar..."
				# read input
				# cfdisk HDDELEGIDO

				# echo "introduce efi"
				# echo "introduce raíz"
				# echo "introduce boot (dejar vacio si no hay)"
				# echo "introduce home (dejar vacio si no hay)"

				#ToFormat(efi raiz boot home)
		#fi
	}

	while true #Pregunta si asistir en el particionado o entrar en modo manual
		do
			echo "1) Particionamiento Guiado"
			echo "2) Particionamiento manual"

			read input

			case $input in
				1) HelpDisk;;
				2) ManualDisk;;
				*) echo "Opción incorrecta, introduce 1 o 2";;
			esac
		done

	# Añadir opción para editar el /dev/sdXY de los mkfs
	# mkfs.vfat -F32 /dev/sda1
	# mkfs.ext4 -L "Arch Linux" /dev/sda2
	# mkfs.ext4 -L "home" /dev/sda3
	# mkswap /dev/sda4
	# swapon /dev/sda4
	# mkdir /mnt/home
	# mount /dev/sda2 /mnt
	# mkdir -p /mnt/boot/efi
	# mount /dev/sda1 /mnt/boot/efi
	# lsblk
	# ¿Está correcto?
	# mount /dev/sda3 /mnt/home
}

function PreInstall() {
	echo '########---Instalando reflector y actualizando la mirrorlist del live---########'
	pacman -Syy reflector --noconfirm
	reflector --latest 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
	pacstrap /mnt base base-devel networkmanager net-tools
	genfstab -U -p /mnt >> /mnt/etc/fstab


	#arch-chroot /mnt bash Test2.bash
}

function ToInstall() {
	#Comprobar que está bien montado

	#Instalar
	#cp ~/Arch_Barebone_Install/Test2.bash /mnt

	#Comprobar que la copia se ha realizado correctamente
	ls /mnt/tmp
}

function PostInstall() {
	echo "Se ha terminado de instalar, ¿desea apagar el equipo?"
	#Preguntar si o no [s/n]
	#En caso de si apagar:
	#poweroff
}

#LLamada a las funciones
InfoHelp
PreConfig
ConfRed
ConfDisk
PreInstall

exit 0

