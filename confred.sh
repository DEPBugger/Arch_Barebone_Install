
function ConfRed() {
	clear

	PING1=""
	PING2=""
	PING3=""
	CORRECT_RED="false"

	echo "Para evitar problemas se recomienda el uso de una conexión cableada hacia internet"

		# Función para conectar la red
	function configRed() {
		echo "Intentando configurar la red"
		echo ""
		echo "Activando Cliente DHCP" && echo "Activando Cliente DHCP" >> $LOG
		dhcpcd 2>> $LOG && echo "El comando dhcpcd ha funcionado correctamente" >> $LOG
	}

	# Función para comprobar la red
	function correctRed() {
		PING1="`ping -c1 www.archlinux.org 2>> /dev/null >> /dev/null && echo true || echo false`"
		PING2="`ping -c1 www.archlinux.org 2>> /dev/null >> /dev/null && echo true || echo false`"
		PING3="`ping -c1 www.archlinux.org 2>> /dev/null >> /dev/null && echo true || echo false`"

		if $PING1 || $PING2 || $PING3; then
			echo "Hay conexión a internet" && echo "Conexión a internet correcta" >> $LOG
			CORRECT_RED=true
		else
			echo "Han fallado 3 pings consecutivos" && echo "Han fallado 3 pings consecutivos" >> $LOG
			configRed
		fi
	}

	# Comprobar si la red es correcta o volver a intentar
	if $CORRECT_RED; then
		break;
	else
		correctRed
	fi

	echo "Se ha terminado de configurar la red"
	sleep 5s
}
