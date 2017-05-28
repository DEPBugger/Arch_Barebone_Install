#!/bin/bash
# Este script es solo una prueba, y aunque no lo fuera lo usas bajo tu propio riesgo. No lo uses en tu ordenador real, pruébalo en una máquina virtual.
# Pensado para computadoras de 64 bits
clear
setfont Lat2-Terminus16
echo '
########     ###    ########  ######## ########   #######  ##    ## ########
##     ##   ## ##   ##     ## ##       ##     ## ##     ## ###   ## ##
##     ##  ##   ##  ##     ## ##       ##     ## ##     ## ####  ## ##
########  ##     ## ########  ######   ########  ##     ## ## ## ## ######
##     ## ######### ##   ##   ##       ##     ## ##     ## ##  #### ##
##     ## ##     ## ##    ##  ##       ##     ## ##     ## ##   ### ##
########  ##     ## ##     ## ######## ########   #######  ##    ## ########
                   -`                     Welcome to an awesome Arch install script
                  .o+`                    This script will install Arch Linux in a
                 `ooo/                    very comfortable way for you.
                `+oooo:
               `+oooooo:                  Please have a seat and enjoy seeing lot of
               -+oooooo+:                 text lines appearing on your screen and
             `/:-:++oooo+:                write your password or say yes or no when required.
            `/++++/+++++++:
           `/++++++++++++++:
          `/+++ooooooooooooo/`
         ./ooosssso++osssssso+`
        .oossssso-````/ossssss+`
       -osssssso.      :ssssssso.
      :osssssss/        osssso+++.
     /ossssssss/        +ssssooo/-
   `/ossssso+/:-        -:/+osssso+-
  `+sso+:-`                 `.-/+oso:
 `++:.                           `-/+/
 .`                                 `/    '
read -p 'Pulsa enter para iniciar la Instalacion'
while true; do
  clear
  echo "Selecciona el idioma de teclado que quieres:"
  echo "es para el teclado Español"
  echo "la para el teclado HispanoAmericano"
  echo "us para el teclado EstadoUnidense"
  echo "uk para el teclado Britanico"
  echo ''
  echo 'col para el teclado Colemak"'
  echo ''
  echo "des para el teclado Dvorak-Español"
  echo "dla para el teclado Dvorak-HispanoAmericano"
  echo "dus para el teclado Dvorak-EstadoUnidense"
  echo "duk para el teclado Dvorak-Britanico"
  echo "dpr para el teclado Programmer Dvorak"

  read LANGUAGE

  case $LANGUAGE in
    es|ES) loadkeys es
    echo 'Teclado seleccionado: Español'
        break;;
    la|LA) loadkeys la-latin1
    echo 'Teclado seleccionado: HispanoAmericano'
        break;;
    us|US) loadkeys us
    echo 'Teclado seleccionado: EstadoUnidense'
        break;;
    uk|UK) loadkeys uk
    echo 'Teclado seleccionado: Britanico'
        break;;


    col|COL) loadkeys colemak
    echo 'Teclado seleccionado: Colemak'
        break;;


    des|DES) loadkeys dvorak-es
    echo 'Teclado seleccionado: Dvorak-Español'
        break;;
    dla|DLA) loadkeys dvorak-la
    echo 'Teclado seleccionado: Dvorak-HispanoAmericano'
        break;;
    des|DES) loadkeys dvorak
    echo 'Teclado seleccionado: Dvorak-EstadoUnidense'
        break;;
    duk|DUK) loadkeys dvorak-uk
    echo 'Teclado seleccionado: Dvorak-Britanico'
        break;;
    dpr|DPR) loadkeys dvorak-programmer
    echo 'Teclado seleccionado: Programmer Dvorak'
        break;;


    *) echo "Respuesta Invalida, porfavor responde bien";;
  esac
done
mount -o remount,size=2G /run/archiso/cowspace
echo '/run/archiso/cowspace ampliada a 2GB'
pacman -Syy --noconfirm git
echo 'git instalado'
git clone https://github.com/DEPBugger/Arch_Barebone_Install.git --branch JackTest
echo 'Repositorio clonado'
cd Arch_Barebone_Install
echo 'Se ha entrado en la carpeta del repo'
echo 'Quieres Continuar? [S/N]'
while true
		do
			read input
			case $input in
				S|s) break;;
				N|n) exit 0;;
				*) echo "Respuesta Invalida, porfavor responde 'S' para si y 'N' para no [S/N]";;
			esac
		done
echo 'Mirando si hay conexion a internet'
dhcpcd
ping -c 3 kernel.org
echo 'Discos Duros y Particiones reconocidas:'
lsblk
echo 'Quieres Continuar? [S/N]'
while true
		do
			read input
			case $input in
				S|s) break;;
				N|n) exit 0;;
				*) echo "Respuesta Invalida, porfavor responde 'S' para si y 'N' para no [S/N]";;
			esac
		done
read -p 'Ahora deberás editar el particionado de tu disco, pulsa Enter cuando estés list@'
# Añadir espera tras el echo anterior
# Añadir opción para eliminar la tabla de particiones
cfdisk /dev/sda
lsblk
echo 'Es Correcto? [S/N]'
while true
		do
			read input
			case $input in
				S|s) break;;
				N|n) exit 0;;
				*) echo "Respuesta Invalida, porfavor responde 'S' para si y 'N' para no [S/N]";;
			esac
		done
# Añadir opción para editar el /dev/sdXY de los mkfs
mkfs.vfat -F32 /dev/sda1
mkfs.ext4 -L 'Arch Linux' /dev/sda2
# mkfs.ext4 -L 'home' /dev/sda3
# mkswap /dev/sda4
# swapon /dev/sda4
# mkdir /mnt/home
mount /dev/sda2 /mnt
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
lsblk
echo 'Es Correcto? [S/N]'
while true
		do
			read input
			case $input in
				S|s) break;;
				N|n) exit 0;;
				*) echo "Respuesta Invalida, porfavor responde 'S' para si y 'N' para no [S/N]";;
			esac
		done
# mount /dev/sda3 /mnt/home
echo '########---Instalando reflector y actualizando la mirrorlist del live para usar lor mirrors más rápidos---########'
pacman -Syy reflector --noconfirm
reflector --latest 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel networkmanager net-tools
genfstab -U /mnt >> /mnt/etc/fstab
cat <<EOF > /mnt/Test1.bash
#!/bin/bash
echo ArchLinux > /etc/hostname
echo ''
echo 'Nombre del host a instalar: ArchLinux'
echo ''
echo 'Introduce la contraseña del usuario root pulsa Enter e introdúcela de nuevo'
passwd
echo ''
echo 'Contraseña del usuario root creada correctamente'
ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime
hwclock --systohc
echo ''
echo 'Zona horaria cambiada a Madrid'
# Añadir la opción de meter otras zonas horarias
sed -i 's/#es_ES.UTF-8 UTF-8/es_ES.UTF-8 UTF-8/' /etc/locale.gen
echo 'LANG=es_ES.UTF-8' > /etc/locale.conf
locale-gen
echo 'KEYMAP=es' > /etc/vconsole.conf
mkinitcpio -p linux
# Añadir opción para editar el /dev/sda1 y la /dev/sda y 1 de después
pacman -S --noconfirm --needed refind-efi && refind-install --usedefault /dev/sda1 --alldrivers && efibootmgr -c -d /dev/sda -p 1 -L rEFInd -l /EFI/BOOT/bootx64.efi
echo ''
echo 'rEFInd instalado y habilitado para el próximo arranque'
# Editar vbox y poner opción de que el usuario escriba su nombre
echo ''
echo 'Creando usuario vbox'
useradd -m -g users -G audio,lp,optical,storage,video,wheel,games,power,scanner -s /bin/bash vbox
echo ''
echo 'Usuario vbox creado'
# Editar vbox y poner opción de que el usuario escriba su nombre
echo ''
echo 'Introduce la contraseña para el usuario vbox pulsa Enter e introdúcela de nuevo'
passwd vbox
echo ''
echo 'Contraseña del usuario vbox creada correctamente'
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
echo ''
echo 'sudo habilitado'
sed -i 's/#Color/Color\nILoveCandy/' /etc/pacman.conf
echo 'Easter egg habilitado'
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
echo ''
echo 'Repositorio [multilib] habilitado'
echo '
[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$'arch'' >> /etc/pacman.conf
echo ''
echo 'Añadido repositorio para instalar yaourt (se eliminará más tarde)'
pacman -Syy --noconfirm --needed yaourt xorg xorg-server xorg-xinit mesa mesa-demos xf86-video-vesa xf86-video-intel firefox terminator geany
echo''
echo 'Sistema gráfico básico instalado'
# Preguntar si está instalando en VirtualBox
pacman -S virtualbox-guest-modules-arch --noconfirm
# Preguntar si desea instalar Xfce4 y lxdm (añadir más DE en el futuro)
# Editar vbox y que use el nombre de usuario creado anteriormente
# Autointroducir la contraseña que se introdujo antes para el usuario (opcional)
echo ''
echo ''
echo ''
echo ''
echo ''
echo ''
echo 'A punto de instalar yaourt, Xfce y lxdm y varios extras'
read -p 'A continuación deberás introducir la contraseña del usuario root en tres ocasiones. Pulsa Enter para continuar'
su vbox -c 'yaourt -S --noconfirm --needed xdg-user-dirs xfce4 xfce4-goodies lxdm lxdm-themes neofetch zsh git wget curl && xdg-user-dirs-update'
echo ''
echo 'yaourt Xfce y lxdm y sus extras instalados'
sed -i '$d' /etc/pacman.conf
sed -i '$d' /etc/pacman.conf
sed -i '$d' /etc/pacman.conf
sed -i '$d' /etc/pacman.conf
echo ''
echo 'Repositorio [archlinuxfr] eliminado'
systemctl enable lxdm.service
systemctl enable NetworkManager.service
echo ''
echo 'A continuación debería aparecer el archivo Test1.bash acompañado de otros ficheros'
ls
rm $0
echo ''
echo 'Ahora deben aparecer solo los otros ficheros, sin el archivo Test1.bash'
ls
EOF
ls /mnt
arch-chroot /mnt bash Test1.bash
############-----Ahora ejecutará el siguiente script-----############
############-----Todo lo que hay a continuación se ejecuta después de que Test1.bash haya finalizado-----############
echo ''
umount -R /mnt
echo 'A continuación se reiniciará el ordenador, por favor extrae el medio de instalación de Arch Linux (memoria USB, DVD, CD...) en cuanto desaparezcan estas letras.'
read -p 'Pulsa Enter cuando hayas leído y comprendido el mensaje anterior.'
reboot
