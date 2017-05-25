#!/bin/bash

#Variables
USER=`whoami`
DEBUG="true"
LOG="/tmp/ArchInstall"

#Función con información y ayuda
function InfoHelp() {
	echo "Advertencia e instrucciones a continuación"
	echo "Este instalador realizará:"
	echo "1) ....."
	echo "2) ....."
	echo "3) ....."
	echo "4) ....."
	echo "5) ....."
	echo "6) ....."
	echo ""
	echo "Desea continuar Y/N"

	read input
	while true
		do
			case $input in
				Y|y) break;;
				N|n) exit 0;;
				*) echo "Opción no válida, introduce Y/N";;
			esac
		done
}

function preconfig() {
	touch $LOG #Crea el archivo donde se registrará el LOG

	if [ ! -w $LOG ]; then #Comprobar que es posible escribir en el archivo log
		echo "Error al crear el archivo temporal"
		echo "Saliendo del instalador"
		exit 1
	fi

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
	# Mostrar discos y particiones actuales
	# Planetear si esto es interactivo por ejemplo:
	# Tienes X discos duros elige donde instalar (si tiene solo 1 continuar)
	# Plantear un sistema para elegir cantidad de particiones y si separar /boot /home y /
	echo "Comprobando tus Discos Duros y Particiones en ellos."
	sleep 1s
	echo "Comprobando tus Discos Duros y Particiones en ellos.."
	sleep 1s
	echo "Comprobando tus Discos Duros y Particiones en ellos..."
	sleep 1s
	lsblk

	#Pedir introducir disco o crear bucle con cada uno de ellos para elegirlo

	echo "El disco elegido es: XXXX???"
	echo ""
	echo "Ahora deberás editar el particionado de tu disco"
	echo "Pulsa una tecla para continuar..."
	read input #Se añade esta entrada para hacer pausa y que el usuario vea los discos

	# Añadir opción para eliminar la tabla de particiones
	cfdisk /dev/sda
	lsblk
	# ¿Es correcto?
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
	lsblk
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
preconfig
ConfRed
ConfDisk
PreInstall

exit 0
