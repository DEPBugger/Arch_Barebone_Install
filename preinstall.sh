
function PreInstall() {
	echo '########---Instalando reflector y actualizando la mirrorlist del live---########'
	pacman -Syy reflector --noconfirm
	reflector --latest 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
	#Comprobar que está bien montado
}
