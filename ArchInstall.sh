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
USER=`whoami` #Variable con el usuario actual que ha ejecutado el script
DEBUG=false #Modo debug por módulos, poner a true para depurar
LOG="/tmp/ArchInstall.log" #Lugar y nombre del archivo LOG
DIR_EFI="/sys/firmware/efi/efivars" #Directorio a comprobar para saber si ha iniciado EFI
IS_EFI=false #Será true si ha iniciado con EFI
NUM_DISKS=`fdisk -l | tr -s " " | cut -d " " -f 2 | cut -d ":" -f 1 | grep "/dev/sd" | wc -l` # Cantidad de discos SATA
INTERNET=false #Variable que devuelve si hay internet --> función --> confred()
TMP="" #Variable temporal

#############################
## Variables Configuración ##
#############################
LANGUAGE="en" #Variable con el idioma del sistema
KEYBOARD="us" #Variable con el teclado a usar
new_user="user" #Nombre del nuevo usuario
passroot=""
passuser=""
host="archPC" #Nombre de la máquina en red
dispositivo=""
gpu="" # GPU para instalar Firmware/Drivers/Utilidades (En blanco para no hacer nada)
gui="" # Interfaz gráfica que se instalará (En blanco ninguna)
SOFTWARE="" # Programas a instalar automáticamente

# Punto de montaje para cada partición
efi=""
boot=""
root=""
home=""
swap=""
size_efi=""
size_boot=""
size_root=""
size_home=""
size_swap=""

#############################
##        FUNCIONES        ##
#############################
function isEfi() { #Función que devuelve true si es EFI
	if [ -d $DIR_EFI ]; then
		IS_EFI=true
	else
		IS_EFI=false
	fi
}
isEfi #Ejecuta la función para comprobar si es EFI

function conditions() { #Función que comprueba condiciones mínimas para instalar
	clear
	echo "Comprobando condiciones"
	if [ -d $IS_EFI ] && [ $USER == "root" ] && [ $NUM_DISKS -ge 1 ]; then
		echo "Se cumplen las condiciones mínimas" && echo "Comprobación inicial correcta" >> $LOG
	else
		echo "Ha ocurrido un error y no cumples las condiciones mínimas para instalar arch" && echo "No se cumplen las condiciones mínimas" >> $LOG
		echo "Comprueba los siguientes requisitos para instalar ARCH:"
		echo "-Eres usuario root (Actualmente eres $USER)"
		echo "-Tienes disco duro con más de 8GB (Discos SATA detectados: $NUM_DISKS)"
		echo ""
		echo "Pulsa una tecla para salir del script"
		read input
		exit 1
	fi
	##### Falta por plantear si controlar:
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
	conditions #Comprueba que se cumplen requisitos mínimos
	InfoHelp #Informa de los riesgos que puede conllevar este instalador
	Start #Inicio, comprueba si existe archivo de configuración, en caso contrario pide introducir datos
	PreConfig #Preconfiguraciones antes de empezar particionado e instalación
	ConfRed #Configura la red y comprueba que hay conexión
	ConfDisk #Configura, particiona y formatea el/los discos duros
	PreInstall #Prepara configuraciones para instalar
	ToInstall #Instala el sistema
	PostInstall #Configuraciones después de instalar el sistema
fi

exit 0
