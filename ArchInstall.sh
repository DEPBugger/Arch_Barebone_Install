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

}


#LLamada a las funciones
InfoHelp
preconfig
ConfRed

exit 0
