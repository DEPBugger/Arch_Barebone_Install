#!/bin/bash

#Variables
USER=`whoami`
DEBUG="true"
LOG="/tmp/ArchInstall"

function help() {
	#Añadir ayuda en esta función
	echo "Advertencia e instrucciones a continuación"
}

function preconfig() {
	touch $LOG #Crea el archivo donde se registrará el LOG

	if [ ! -w $LOG ]; then #Comprobar que es posible escribir en el archivo log
		echo "Error al crear el archivo temporal"
		echo "Saliendo del instalador"
		exit 1
	fi

	loadkeys es 2>> $LOG && echo "Teclado del entorno live configurado a español" >> $LOG #Establece teclado en español

	mount -o remount,size=2G /run/archiso/cowspace 2>>$LOG && echo "/run/archiso/cowspace ampliada a 2GB" >> $LOG

	#Comprobar internet

	#Actualizar pacman y git sin pedir confirmación?=?
	# pacman -Syy --noconfirm git
	# echo "git instalado"
}

#LLamada a las funciones
preconfig

exit 0
