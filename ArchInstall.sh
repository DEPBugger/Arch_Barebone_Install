#!/bin/bash

#Variables
USER=`whoami`
DEBUG="true"
LOGDIR="/tmp/ArchInstall"

function preconfig() {
	touch $LOGDIR #Crea el archivo donde se registrará el LOG
	if [ ! -w $LOGDIR ]; then #Comprobar que es posible escribir en el archivo log
		echo "Error al crear el archivo temporal"
		echo "Saliendo del instalador"
		exit 1
	fi
	loadkeys es && echo "Teclado del entorno live configurado a español" >> $LOGDIR #Establece teclado en español
}

exit 0
