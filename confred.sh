
function ConfRed() {
	clear
	echo "Activando Cliente DHCP" && echo "Activando Cliente DHCP" >> $LOG
	dhcpcd 2>> $LOG && echo "El comando dhcpcd ha funcionado correctamente" >> $LOG

	# Comprobar conexión a internet, mirar que en 1 de 3 ping haya obtenido respuesta de www.kernel.org
	# echo "Hay conexión de red" >> $LOG
}
