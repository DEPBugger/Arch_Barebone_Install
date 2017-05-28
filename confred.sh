
function ConfRed() {
	clear

	PIN1=""
	PIN2=""
	PIN3=""
	CORRECT_RED="false"

	echo "Activando Cliente DHCP" && echo "Activando Cliente DHCP" >> $LOG

	echo "Para evitar problemas se recomienda el uso de una conexión cableada hacia internet"

	# Función para configurar la red
	function correctRed() {

	}

	# Comprobar si la red es correcta
	if $CORRECT_RED; then
		break;
	else
		correctRed
	fi



	dhcpcd 2>> $LOG && echo "El comando dhcpcd ha funcionado correctamente" >> $LOG

	# Comprobar conexión a internet, mirar que en 1 de 3 ping haya obtenido respuesta de www.kernel.org
	echo "Hay conexión de red" >> $LOG
}
