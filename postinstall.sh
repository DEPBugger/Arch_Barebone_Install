
function PostInstall() {
	#Función para instalar escritorios
	function InstallDesktop() {
		case $gui in
			xfce|Xfce|XFCE)
				echo "Instalando XFCE"
				#xfce4 y xfce4-goodies
			;;
			gnome|Gnome|GNOME)
				echo "Instalando GNOME SHELL"
			;;
			plasma|Plasma|PLASMA)
				echo "Instalando PLASMA"
			;;
			cinnamon|Cinnamon|CINNAMON)
				echo "Instalando CINNAMON"
			;;
			mate|Mate|MATE)
				echo "Instalando MATE"
				#mate y mate-extra
			;;
			*)
				echo "No se instalará escritorio ya que no se ha elegido o está mal escrito" && echo "No hay escritorio elegido" >> $LOG
				sleep 3s
				echo "Las opciones posibles son: XFCE, GNOME, PLASMA, CINNAMON, MATE"
				sleep 6s
	}

	#Función para seleccionar mirror
	function MirrorList() {
		echo "Instalando reflector y actualizando la mirrorlist del live para usar lor mirrors más rápidos"
		pacman -Syy reflector --noconfirm && echo "reflector instalado correctamente" >> $LOG || echo "reflector no instalado" >> $LOG
		reflector --latest 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist && echo "Mirror más rápido elegido" >> $LOG
	}

	function CreateFstab() {
		echo "Generando fstab"
		genfstab -U -p /mnt >> /mnt/etc/fstab && echo "fstab generado correctamente" >> $LOG || echo "Error al generar fstab" >> $LOG
	}

	#Llamada a las configuraciones
	InstallDesktop
	MirrorList

	#Añadir hostname
	echo $host > /mnt/etc/hostname && echo "Host añadido a /mnt/etc/hostname" >> $LOG || echo "Error al agregar hostname" >> $LOG

	#Añadir preferencia de localización
	#echo "LANG=es_ES.UTF-8" >> /etc/locale.conf
	#locale-gen

	#Crear usuario, falta hacer que se ejecute dentro de archroot:
	#useradd -m -g $new_user -G audio,lp,optical,storage,video,wheel,games,power,scanner -s /bin/bash $new_user

	#Contraseña de usuario

	#Contraseña de root

	#Al terminar el script preguntar si salir
	while true; do
		clear
		echo "Se ha terminado de instalar, ¿desea apagar el equipo?"
		echo ""

		read input

		case $input in
			y|Y) poweroff; break;;
			n|N) exit 0;;
			*) echo "Opción inválida [y/n]";;
		esac
	done
}
