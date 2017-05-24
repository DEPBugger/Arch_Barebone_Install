#!/bin/bash
echo ArchLinux > /etc/hostname
echo "Introduce la contraseña de la cuenta root, pulsa enter e introdúcela de nuevo"
passwd
ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime
sed -i 's/#es_ES.UTF-8 UTF-8/es_ES.UTF-8 UTF-8/' /etc/locale.gen
echo "LANG=es_ES.UTF-8" > /etc/locale.conf
locale-gen
echo "KEYMAP=es" > /etc/vconsole.conf
mkinitcpio -p linux
# Añadir opción para editar el /dev/sda1 y la /dev/sda y 1 de después
pacman -S --noconfirm --needed zsh refind-efi && refind-install --usedefault /dev/sda1 --alldrivers && efibootmgr -c -d /dev/sda -p 1 -L rEFInd -l /EFI/BOOT/bootx64.efi
# Editar vbox y poner opción de que el usuario escriba su nombre
echo "Creando usuario"
useradd -m -g users -G audio,lp,optical,storage,video,wheel,games,power,scanner -s /bin/bash vbox
# Editar vbox y poner opción de que el usuario escriba su nombre
echo "Introduzca la contraseña para su usuario"
passwd vbox
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
sed -i 's/#Color/Color\nILoveCandy/' /etc/pacman.conf
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
echo "
[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$"arch"" >> /etc/pacman.conf
pacman -Syy --noconfirm --needed yaourt xorg xorg-apps mesa mesa-demos xf86-video-vesa xf86-video-intel xterm firefox terminator geany xf86-video-ati
# Preguntar si está instalando en VirtualBox
# pacman -S virtualbox-guest-modules-arch --noconfirm
# Eliminar el repositorio [archlinuxfr] de pacman.conf
# Preguntar si desea instalar Xfce4 y lxdm (añadir más DE en el futuro)
# Editar vbox y que use el nombre de usuario creado anteriormente
su vbox
yaourt -S --noconfirm --needed xfce4 xfce4-goodies lxdm lxdm-themes
exit
rm $0
exit
