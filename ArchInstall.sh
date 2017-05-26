#!/bin/bash

#Variables
LANGUAGE="en"
USER=`whoami`
DEBUG="true"
LOG="/tmp/ArchInstall"

#TERMINADO (Solo falta rellenar información en los "echo" con advertencias de que algo puede fallar)
#Function that gives information about the installation process
function InfoHelp() {
	clear
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
			echo "Introduce el idioma de teclado"
			# https://wiki.archlinux.org/index.php/Keyboard_configuration_in_console
			echo "es Para Español"
			echo "uk Para Inglés Inglaterra"
			echo "fr Para Francés"
			echo "de Para Alemán"
			echo "us Para Inglés de USA"

			read LANGUAGE

			case $LANGUAGE in
				es|Es|ES) break;;
				uk|Uk|UK) break;;
				fr|Fr|FR) break;;
				de|De|DE) break;;
				us|Us|US) break;;
				*) echo "Opción no válida, inserta solo una de las opciones anteriores"
					echo "Pulsa intro para continuar"
					read input;;
			esac
		done

		# https://wiki.archlinux.org/index.php/Keyboard_configuration_in_console#Keymap_codes
		##### Filtrar códigos disponibles para loadkeys --> `find /usr/share/kbd/keymaps/ -type f`
		# Establece teclado en el idioma elegido
		loadkeys $LANGUAGE 2>> $LOG && echo "Teclado del entorno live configurado a $LANGUAGE" >> $LOG
		echo ""
		echo "El idioma de teclado actual es el siguiente:"
		localectl status #Muestra distribución actual del teclado
		echo " "
	}

	selectKeyboard

	while true; do
		echo "Es correcta la distribución [y/n]"

		read input

		case $input in
			y|Y) break;;
			n|N) selectKeyboard;;
			*) echo "Opción no válida"
		esac
	done

	mount -o remount,size=2G /run/archiso/cowspace 2>> $LOG && echo "/run/archiso/cowspace ampliada a 2GB" >> $LOG
	echo "/run/archiso/cowspace ampliada a 2GB"
}

function ConfRed() {
	clear
	echo "Activando Cliente DHCP" && echo "Activando Cliente DHCP" >> $LOG
	dhcpcd 2>> $LOG && echo "El comando dhcpcd ha funcionado correctamente" >> $LOG

	# Comprobar conexión a internet, mirar que en 1 de 3 ping haya obtenido respuesta de www.kernel.org
	# echo "Hay conexión de red" >> $LOG
}

function ConfDisk() {
	clear
	echo "Comprobando tus Discos Duros y Particiones en ellos."
	sleep 1s
	clear
	echo "Comprobando tus Discos Duros y Particiones en ellos.."
	sleep 1s
	clear
	echo "Comprobando tus Discos Duros y Particiones en ellos..."
	sleep 1s
	clear

	lsblk

	#function ToFormat(efi raiz boot home) {
		#Comprobar entradas, descartar vacíos y formatear
		#Los vacíos se descartan

		#tomar variables de entrada
	#}

	function HelpDisk() { #Función para particionmiento guiado
		#Preguntar paso a paso
		clear
		echo "Particionar el disco duro de forma Guiada"
		echo ""
		sleep 3s

		while true; do
			echo "¿Quieres instalarlo todo en 1 partición? (UEFI y /)"
			echo "Selecciona [s/n]"
			echo ""

			read input

			case $input in
				s|S) echo "Se ha elegido SI"
						# Comprobar discos duros, si solo hay 1 continuar, si hay más pedir elegir
						# Mostrar que se va a particionar (UEFI 100mb en /dev/sdX1 y root en /dev/sdX2)
						# Confirmar cambios y llamar a la función de arriba, "ToFormat"
						echo "Pulsa INTRO para continuar"
						read input
						;;
				n|N) echo "Se ha elegido NO"
						# echo "Crear partición boot [s/n]"
						# echo "Crear partición home [s/n]"
						# echo "Introduce tamaño para EFI (recomendado 100mb)
						# echo "Introduce tamaño para raíz"
						# echo "Introduce tamaño para boot"
						# echo "Introduce tamaño para home"
						echo "Pulsa INTRO para continuar"
						read input
						;;
				*) echo "Opción incorrecta";;
			esac
		done
	}

	function ManualDisk() { #Función para particionamiento manual
		clear
		echo "Particionar el disco duro de forma manual"
		echo ""

		DISK=`fdisk -l | grep "Disk /dev/sd" | wc -l` #Cantidad de discos en el equipo

		if [ $DISK -eq 1 ]; then
			echo "Solo tienes un disco duro, seleccionando /dev/sda como objetivo"
			DISK="/dev/sda"
			echo "Pulsa INTRO para continuar y entrar a cfdisk"
			read input
			cfdisk /dev/sda
		else
			echo "En tu equipo tienes $DISK discos duros, son los siguientes:"
			echo ""
			fdisk -l | grep "Disk /dev/sd"
			echo ""

			while true; do
				echo "Introduce el disco duro objetivo"
				echo "Por ejemplo: /dev/sda"
				read DISK

				echo "El disco elegido es: $DISK"
				echo "¿Es correcto? Introduce [s/n]"

				read input
					case $input in
						s|S) break;;
						n|N) clear;	echo "Introduce de nuevo el disco";;
						*) echo "Has elegido una opción inválida";;
					esac
			done

			# Abrir el gestor de particiones cfdisk
			cfdisk $DISK

			##### Preparar para llamar a la función que formatea las particiones
			# echo "introduce efi"
			# echo "introduce raíz"
			# echo "introduce boot (dejar vacio si no hay)"
			# echo "introduce home (dejar vacio si no hay)"

			# ToFormat(efi raiz boot home)
		fi
	}

	function AutoFormat() {
		clear
		echo "Comenzando autofomateado"
	}

	while true #Pregunta si asistir en el particionado o entrar en modo manual
		do
			clear
			echo ""
			echo "1) Particionamiento Guiado"
			echo "2) Particionamiento manual"
			echo "3) Particionado y formateado automático usando el primer disco duro completo /dev/sda"

			read input

			case $input in
				1) HelpDisk;;
				2) ManualDisk;;
				3) AutoFormat;;
				*) echo "Opción incorrecta, introduce 1, 2 o 3";;
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
	##### Elegir la distribución de teclado que tendrá el sistema instalado, en concreto cuando hay que editar el archivo /etc/vconsole.conf (simplemente añadir KEYMAP=X, de nuevo la X será el código de teclado a usar, busca `vconsole` en Test2.bash para ver como va), la idea es preguntar si desea meter la misma distribución de teclado en el sistema instalado que la que haya elegido en el live.
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

