#!/bin/bash
# Este script es solo una prueba, y aunque no lo fuera lo usas bajo tu propio riesgo. No lo uses en tu ordenador real, pruébalo en una máquina virtual.
# Pensado para computadoras de 64 bits
setfont Lat2-Terminus16
echo ''
echo ''
echo ''
echo ''
echo ''
echo ''
echo '
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
 .`                                 `/    '
read -p 'Press Enter to begin installation process.'
mount -o remount,size=2G /run/archiso/cowspace
echo ''
dhcpcd
ping -c 3 kernel.org
lsblk
# ¿Continuar?
echo ''
read -p 'Ahora deberás editar el particionado de tu disco, pulsa Enter cuando estés list@'
# Añadir espera tras el echo anterior
# Añadir opción para eliminar la tabla de particiones
cfdisk /dev/sda
lsblk
# ¿Es correcto?
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
# ¿Está correcto?
# mount /dev/sda3 /mnt/home
echo ''
echo '########---Instalando reflector y actualizando la mirrorlist del live para usar lor mirrors más rápidos---########'
pacman -Syy reflector --noconfirm
reflector --latest 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel networkmanager net-tools
genfstab -U /mnt >> /mnt/etc/fstab
cat << EOF > /mnt/Test1.bash
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
echo ''
echo 'Zona horaria cambiada a Madrid'
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
echo 'rEFInd instalado y habilitado para el próximo arranque'
# Editar vbox y poner opción de que el usuario escriba su nombre
echo ''
echo 'Creando usuario vbox...'
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
echo ''
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
echo ''
echo '########---Instalando reflector y actualizando la mirrorlist del sistema que se va a instalar para usar lor mirrors más rápidos---########'
pacman -Syy reflector --noconfirm
reflector --latest 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
pacman -Sy --noconfirm --needed yaourt xorg xorg-server xorg-xinit mesa mesa-demos xf86-video-vesa xf86-video-intel firefox terminator geany gparted
echo''
echo 'Sistema gráfico básico instalado'
# Preguntar si está instalando en VirtualBox
pacman -S virtualbox-guest-modules-arch --noconfirm
# Preguntar si desea instalar Xfce4 y lxdm (añadir más DE en el futuro)
# Editar vbox y que use el nombre de usuario creado anteriormente
# Autointroducir la contraseña que se introdujo antes para el usuario (opcional)
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
echo ''
systemctl enable lxdm.service
systemctl enable NetworkManager.service
echo ''
git clone https://github.com/munlik/refind-theme-regular.git
echo ''
echo 'Clonado el repositorio https://github.com/munlik/refind-theme-regular.git'
sudo mv refind-theme-regular /boot/boot/EFI/BOOT
echo ''
echo 'Colocada la carpeta refind-theme-regular en la ESP'
sudo rm -rf /boot/efi/EFI/BOOT/refind-theme-regular/{src,.git}
sudo echo '
include refind-theme-regular/theme.conf' >> /boot/efi/EFI/BOOT/refind.conf
echo 'Cargado refind-theme-regular en refind.conf'
echo ''
echo 'Por favor, introduce por última vez la contraseña del usuario vbox'
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
pkill dhcpcd
echo ''
umount -R /mnt
echo 'A continuación se reiniciará el ordenador, por favor extrae el medio de instalación de Arch Linux (memoria USB, DVD, CD...) en cuanto desaparezcan estas letras.'
read -p 'Pulsa Enter cuando hayas leído y comprendido el mensaje anterior.'
reboot
