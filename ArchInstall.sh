#!/bin/bash

#Variables
USER=`whoami`
DEBUG="true"
LOGDIR="/tmp/ArchInstall"


#Comprobar root

function preconfig() {
	touch $LOGDIR #Crea el archivo donde se registrará el LOG
	loadkeys es && echo "Teclado del entorno live configurado a español" >> $LOGDIR #Establece teclado en español
}
