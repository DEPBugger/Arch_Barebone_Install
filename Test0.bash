#!/bin/bash
# Este script es solo una prueba, y aunque no lo fuera lo usas bajo tu propio riesgo. No lo uses en tu ordenador real, pruébalo en una máquina virtual.
# Pensado para computadoras de 64 bits
# setfont Lat2-Terminus16
clear
echo -e '\e[1;36m
                   -`                     Welcome to an awesome Arch install script
                  .o+`                    This script will install Arch Linux in a
                 `ooo/                    very comfortable way for you.      
                `+oooo:                                                             
               `+oooooo:                  Please have a seat and enjoy seeing lot of
               -+oooooo+:                 text lines appearing on your screen and
             `/:-:++oooo+:                write your password or say yes or no when
            `/++++/+++++++:               required.
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
 .`                                 `/\e[0m'
echo ''
read -p $'\033[1;31mPress Enter to begin installation process.\e[0m'
mount -o remount,size=2G /run/archiso/cowspace
echo ''
echo -e '\e[1;32m/run/archiso/cowspace ampliada a 2GB\e[0m'
echo ''
dhcpcd
timedatectl set-ntp true
echo ''
ping -c 3 archlinux.org
echo ''
lsblk
# ¿Continuar?
echo ''
read -p $'\033[1;31mAhora se particionará tu disco (/dev/sda), pulsa Enter cuando estés list@\e[0m'
# Añadir opción para eliminar la tabla de particiones
echo ''
gdisk << EOF
/dev/sda
n
1

512M
EF00
n
2


8300
w
Y
EOF
echo ''
echo -e '\e[1;32mTabla de particiones lista. Ha quedado como se ve a continuación:\e[0m'
lsblk
echo ''
read -p $'\033[1;31mPulsa Enter para continuar\e[0m'
# Añadir opción para editar el /dev/sdXY de los mkfs
echo ''
mkfs.vfat -F32 /dev/sda1
mkfs.ext4 -L 'Arch Linux' /dev/sda2
echo ''
echo -e '\e[1;32mParticiones formateadas, se muestran a continuación:\e[0m'
lsblk -f
# mkfs.ext4 -L 'home' /dev/sda3
# mkswap /dev/sda4
# swapon /dev/sda4
# mkdir /mnt/home
mount /dev/sda2 /mnt
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
echo ''
echo -e '\e[1;32mParticiones montadas, se muestran a continuación:\e[0m'
lsblk -f
# ¿Está correcto?
# mount /dev/sda3 /mnt/home
echo ''
echo -e '\e[1;32m########---Instalando reflector y actualizando la mirrorlist del live para usar lor mirrors más rápidos---########\e[0m'
pacman -Syy reflector --noconfirm
reflector --latest 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel networkmanager net-tools
while [[ -z ${NEW_USER} ]]; do
    echo ''
    read -p $'\033[1;31mIntroduzca el nombre del usuario no root que desee para su futuro sistema:\e[0m' NEW_USER
    if [[ ${NEW_USER} =~ ^[a-z,0-9]*$ ]] && [[ ${#NEW_USER} -lt 32 ]]; then
        echo ''
        echo -e "\e[1;32mEl nombre de usuario no root para la nueva instalación será '${NEW_USER}'.\e[0m"
	else
	    echo ''
        echo $'\033[1;31mHa introducido caracteres inválidos o demasiados, por favor use sólo minúsculas y/o números hasta 32 caracteres\e[0m'
        unset NEW_USER
    fi
done
echo ''
genfstab -U /mnt >> /mnt/etc/fstab
echo ''
cat << EOF > /mnt/Test1.bash
#!/bin/bash
NEW_USER="${NEW_USER}"
echo ''
echo -e '\e[1;32mSe ha entrado en chroot\e[0m'
echo 'ArchLinux' > /etc/hostname
echo ''
echo -e '\e[1;32mNombre del host a instalar: ArchLinux\e[0m'
echo ''
echo -e '\e[1;32mIntroduce la contraseña del usuario root pulsa Enter e introdúcela de nuevo\e[0m'
passwd
echo ''
echo -e '\e[1;32mContraseña del usuario root creada correctamente\e[0m'
ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime
echo ''
echo -e '\e[1;32mZona horaria cambiada a Madrid\e[0m'
hwclock --systohc
# Añadir la opción de meter otras zonas horarias
sed -i 's/#es_ES.UTF-8 UTF-8/es_ES.UTF-8 UTF-8/' /etc/locale.gen
echo 'LANG=es_ES.UTF-8' > /etc/locale.conf
echo ''
locale-gen
echo 'KEYMAP=es' > /etc/vconsole.conf
mkinitcpio -p linux
# Añadir opción para editar el /dev/sda1 y la /dev/sda y 1 de después
pacman -S --noconfirm --needed refind-efi && refind-install --usedefault /dev/sda1 --alldrivers && efibootmgr -c -d /dev/sda -p 1 -L rEFInd -l /EFI/BOOT/bootx64.efi
echo ''
echo -e '\e[1;32mrEFInd instalado y habilitado para el próximo arranque\e[0m'
echo ''
echo -e '\e[1;32mCreando usuario ${NEW_USER}...\e[0m'
useradd -m -g users -G audio,lp,optical,storage,video,wheel,games,power,scanner -s /bin/bash \${NEW_USER}
echo ''
echo -e '\e[1;32mUsuario ${NEW_USER} creado y añadido a grupos varios\e[0m'
echo ''
echo -e '\e[1;32mIntroduce la contraseña para el usuario ${NEW_USER} pulsa Enter e introdúcela de nuevo.\e[0m'
passwd ${NEW_USER}
echo ''
echo -e '\e[1;32mContraseña del usuario ${NEW_USER} creada correctamente\e[0m'
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
echo ''
echo -e '\e[1;32msudo habilitado\e[0m'
sed -i 's/#Color/Color\nILoveCandy/' /etc/pacman.conf
echo ''
echo -e '\e[1;33mEaster egg habilitado\e[0m'
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
echo ''
echo -e '\e[1;32mRepositorio [multilib] habilitado\e[0m'
echo '
[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$'arch'' >> /etc/pacman.conf
echo ''
echo -e '\e[1;32mAñadido repositorio para instalar yaourt (se eliminará más tarde)\e[0m'
echo ''
echo -e '\e[1;32m########---Instalando reflector y actualizando la mirrorlist del futuro sistema---########\e[0m'
echo ''
pacman -Syy reflector --noconfirm
reflector --latest 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
pacman -Sy --noconfirm --needed yaourt xorg xorg-server xorg-xinit mesa mesa-demos xf86-video-vesa xf86-video-intel firefox terminator geany gparted
echo''
echo -e '\e[1;32mSistema gráfico básico instalado\e[0m'
# Preguntar si está instalando en VirtualBox
echo ''
pacman -S virtualbox-guest-modules-arch --noconfirm
# Preguntar si desea instalar Xfce4 y lxdm (añadir más DE en el futuro)
# Autointroducir la contraseña que se introdujo antes para el usuario (opcional)
echo ''
echo -e '\e[1;32mA punto de instalar yaourt, Xfce y lxdm y varios extras\e[0m'
read -p $'\033[1;31mA continuación deberás introducir la contraseña del usuario root en tres ocasiones. Pulsa Enter para continuar\e[0m'
su ${NEW_USER} -c 'yaourt -S --noconfirm --needed xdg-user-dirs xfce4 xfce4-goodies lxdm lxdm-themes neofetch zsh git wget curl && xdg-user-dirs-update'
echo ''
echo -e '\e[1;32myaourt Xfce y lxdm y sus extras instalados\e[0m'
sed -i '$d' /etc/pacman.conf
sed -i '$d' /etc/pacman.conf
sed -i '$d' /etc/pacman.conf
sed -i '$d' /etc/pacman.conf
echo ''
echo -e '\e[1;32mRepositorio [archlinuxfr] eliminado\e[0m'
echo ''
systemctl enable lxdm.service
systemctl enable NetworkManager.service
echo ''
git clone https://github.com/munlik/refind-theme-regular.git
echo ''
echo -e '\e[1;32mClonado el repositorio https://github.com/munlik/refind-theme-regular.git\e[0m'
sudo mv refind-theme-regular /boot/efi/EFI/BOOT
echo ''
echo -e '\e[1;32mColocada la carpeta refind-theme-regular en la ESP\e[0m'
sudo rm -rf /boot/efi/EFI/BOOT/refind-theme-regular/{src,.git}
sudo echo ''
include refind-theme-regular/theme.conf' >> /boot/efi/EFI/BOOT/refind.conf
echo -e '\e[1;32mCargado refind-theme-regular en refind.conf\e[0m'
echo ''
echo -e '\e[1;32mA continuación debería aparecer el archivo Test1.bash acompañado de otros ficheros\e[0m'
ls
rm Test1.bash
echo ''
echo -e '\e[1;32mAhora deben aparecer solo los otros ficheros, sin el archivo Test1.bash\e[0m'
ls
EOF
ls /mnt
arch-chroot /mnt bash Test1.bash
############-----Ahora ejecutará el siguiente script-----############
############-----Todo lo que hay a continuación se ejecuta después de que Test1.bash haya finalizado-----############
pkill dhcpcd
echo ''
umount -R /mnt
echo -e '\e[1;32mA continuación se reiniciará el ordenador, por favor extrae el medio de instalación de Arch Linux (memoria USB, DVD, CD...) en cuanto desaparezcan estas letras.\e[0m'
read -p $'\033[1;31mPulsa Enter cuando hayas leído y comprendido el mensaje anterior.\e[0m'
reboot
