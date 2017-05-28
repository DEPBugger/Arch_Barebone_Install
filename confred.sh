
function ConfRed() {
	clear

	PIN1=""
	PIN2=""
	PIN3=""
	CORRECT_RED="false"

	echo "Activando Cliente DHCP" && echo "Activando Cliente DHCP" >> $LOG

	echo "Para evitar problemas se recomienda el uso de una conexión cableada hacia internet"

	# Función para comprobar la red
	function correctRed() {

		PIN1="ping -c1 www.archlinux.org"
		PIN2=""
		PIN3=""

		if $PING1 || $PING2 || $PING3; then
			CORRECT_RED=true
		fi
	}

	# Función para conectar la red
	function configRed() {
		echo "Intentando configurar la red"
		# Intentar conectar por cable, si falla intentar conectar por wireless
	}

	# Comprobar si la red es correcta o volver a intentar
	if $CORRECT_RED; then
		break;
	else
		correctRed
	fi



	dhcpcd 2>> $LOG && echo "El comando dhcpcd ha funcionado correctamente" >> $LOG

	# Comprobar conexión a internet, mirar que en 1 de 3 ping haya obtenido respuesta de www.kernel.org
	echo "Hay conexión de red" >> $LOG
}
