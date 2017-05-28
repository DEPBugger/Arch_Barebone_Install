#!/bin/bash

############################
##       IMPORTADOS       ##
############################
source ./infohelp.sh
source ./preconfig.sh
source ./confred.sh
source ./confdisk.sh

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

#############################
##        FUNCIONES        ##
#############################

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
		echo "2) Preconfiguraciones [PreConfig]"
		echo "3) Configuración de red [ConfRed]"
		echo "4) Particionar y Formatear [ConfDisk]"
		echo "5) Detalles antes de instalar [PreInstall]"
		echo "6) Instalando sistema [ToInstall]"
		echo "7) Configuraciones Post-Instalación [PostInstall]"
		echo "0) Salir"
		echo ""

		read input

		case $input in
			0) break;;
			1) InfoHelp;;
			2) PreConfig;;
			3) ConfRed;;
			4) ConfDisk;;
			5) PreInstall;;
			6) ToInstall;;
			7) PostInstall;;
			*) echo "Opción inválida, elige una opción de las anteriores";;
		esac
	done
else
	InfoHelp
	PreConfig
	ConfRed
	ConfDisk
	PreInstall
	ToInstall
	PostInstall
fi

exit 0
