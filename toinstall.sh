function ToInstall() {
	#Instalar
	pacstrap /mnt base base-devel networkmanager net-tools 2>> $LOG && echo "Instalado base, base-devel, networkmanager, net-tools" >> $LOG
	genfstab -U -p /mnt >> /mnt/etc/fstab 2>> $LOG && echo "Generado fstab" >> $LOG

	#Comprobar que la copia se ha realizado correctamente
	ls /mnt/tmp

    #Nombre del host
    echo "Introduce el nombre del host a instalar:"
    echo ""
    read myhost
    echo $myhost > /etc/hostname && echo "El host ${myhost} ha sido añadido correctamente."

    #Usuario principal

}

