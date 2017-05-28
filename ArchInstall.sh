#!/bin/bash

############################
##   Constantes Colores   ##
############################
amarillo="\033[1;33m"
azul="\033[1;34m"
blanco="\033[1;37m"
gris="\033[0;37m"
rojo="\033[1;31m"
verde="\033[1;32m"

#############################
##   Variables Generales   ##
#############################
LANGUAGE="en"
USER=`whoami`
DEBUG="false"
LOG="/tmp/ArchInstall.log"
EFI="/sys/firmware/efi/efivars"
NUM_DISKS=`fdisk -l | tr -s " " | cut -d " " -f 2 | cut -d ":" -f 1 | grep "/dev/sd" | wc -l` # Cantidad de discos SATA

#############################
##        FUNCIONES        ##
#############################
function conditions() { # Función que comprueba condiciones mínimas para instalar
	echo "Comprobando condiciones"
	if [ -d `ls $EFI` ] && [ $USER == "root" ] && [ $NUM_DISKS -ge 1 ]; then
		echo "Se cumplen las condiciones mínimas" && echo "Comprobación inicial correcta" >> $LOG
	else
		echo "Ha ocurrido un error y no cumples las condiciones mínimas para instalar arch" >> $LOG
		echo "Comprueba los siguientes requisitos para instalar ARCH:"
		echo "-Eres usuario root (Actualmente eres $USER)"
		echo "-"
	fi
	#Es root
	#hay HDD
	#HDD con más de 8GB
	#Enchufado si es portatil
	#Red
}



############################
##       IMPORTADOS       ##
############################
source ./infohelp.sh
source ./start.sh
source ./preconfig.sh
source ./confred.sh
source ./confdisk.sh
source ./preinstall.sh
source ./toinstall.sh
source ./postinstall.sh

#############################
##        EJECUCIÓN        ##
#############################

#LLamada a las funciones, si DEBUG=true se habilita el modo pruebas
if $DEBUG; then
	touch $LOG
	while true; do
		clear
		echo "Selecciona la función/módulo/step a comprobar introduciendo el número de opción"
		echo ""
		echo "1) Ayuda del principio [InfoHelp]"
		echo "2) Inicio, entrada de variables [Start]"
		echo "3) Preconfiguraciones [PreConfig]"
		echo "4) Configuración de red [ConfRed]"
		echo "5) Particionar y Formatear [ConfDisk]"
		echo "6) Detalles antes de instalar [PreInstall]"
		echo "7) Instalando sistema [ToInstall]"
		echo "8) Configuraciones Post-Instalación [PostInstall]"
		echo "0) Salir"
		echo ""

		read input

		case $input in
			0) break;;
			1) InfoHelp;;
			2) Start;;
			3) PreConfig;;
			4) ConfRed;;
			5) ConfDisk;;
			6) PreInstall;;
			7) ToInstall;;
			8) PostInstall;;
			*) echo "Opción inválida, elige una opción de las anteriores";;
		esac
	done
else
	InfoHelp
	Start
	PreConfig
	ConfRed
	ConfDisk
	PreInstall
	ToInstall
	PostInstall
fi

exit 0
