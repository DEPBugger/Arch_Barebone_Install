
function PostInstall() {
	##### Elegir la distribución de teclado que tendrá el sistema instalado, en concreto cuando hay que editar el archivo /etc/vconsole.conf (simplemente añadir KEYMAP=X, de nuevo la X será el código de teclado a usar, busca `vconsole` en Test2.bash para ver como va), la idea es preguntar si desea meter la misma distribución de teclado en el sistema instalado que la que haya elegido en el live.
	while true; do
		clear
		echo "Se ha terminado de instalar, ¿desea apagar el equipo?"
		echo ""

		read input

		case $input in
			s|S) poweroff; break;;
			n|N) exit 0;;
			*) echo "Opción inválida [s/n]";;
		esac
	done
}
