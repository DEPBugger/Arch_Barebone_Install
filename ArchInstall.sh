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

#############################
##        FUNCIONES        ##
#############################

############################
##       IMPORTADOS       ##
############################
source ./start.sh
source ./infohelp.sh
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
		echo "1) Inicio, entrada de variables [Start]"
		echo "2) Ayuda del principio [InfoHelp]"
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
			1) Start;;
			2) InfoHelp;;
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
	Start
	InfoHelp
	PreConfig
	ConfRed
	ConfDisk
	PreInstall
	ToInstall
	PostInstall
fi

exit 0
