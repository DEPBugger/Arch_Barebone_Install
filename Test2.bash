#!/bin/bash
echo ArchLinux > /etc/hostname
echo "Nombre del host a instalar: ArchLinux"
echo "Introduce la contraseña de la cuenta root, pulsa enter e introdúcela de nuevo"
passwd
echo "Contraseña actualizada correctamente"
ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime
echo "Zona horaria cambiada a Madrid"
# Añadir la opción de meter otras zonas horarias
sed -i 's/#es_ES.UTF-8 UTF-8/es_ES.UTF-8 UTF-8/' /etc/locale.gen
echo "LANG=es_ES.UTF-8" > /etc/locale.conf
locale-gen
echo "KEYMAP=es" > /etc/vconsole.conf
mkinitcpio -p linux
# Añadir opción para editar el /dev/sda1 y la /dev/sda y 1 de después
pacman -S --noconfirm --needed refind-efi && refind-install --usedefault /dev/sda1 --alldrivers && efibootmgr -c -d /dev/sda -p 1 -L rEFInd -l /EFI/BOOT/bootx64.efi
echo "rEFInd instalado y habilitado para el próximo arranque"
# Editar vbox y poner opción de que el usuario escriba su nombre
echo "Creando usuario"
useradd -m -g users -G audio,lp,optical,storage,video,wheel,games,power,scanner -s /bin/bash vbox
echo "Usuario vbox creado"
# Editar vbox y poner opción de que el usuario escriba su nombre
echo "Introduzca la contraseña para su usuario"
passwd vbox
echo "Contraseña actualizada correctamente"
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
echo "sudo habilitado"
sed -i 's/#Color/Color\nILoveCandy/' /etc/pacman.conf
echo "Easter egg habilitado"
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
echo "Repositorio [multilib] habilitado"
echo "
[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$"arch"" >> /etc/pacman.conf
echo "Añadido repositorio para instalar yaourt (se eliminará más tarde)"
pacman -Syy --noconfirm --needed yaourt xorg xorg-server xorg-xinit mesa mesa-demos xf86-video-vesa xf86-video-intel firefox terminator geany
echo "Sistema gráfico básico instalado"
# Preguntar si está instalando en VirtualBox
pacman -S virtualbox-guest-modules-arch --noconfirm
# Eliminar el repositorio [archlinuxfr] de pacman.conf
# Preguntar si desea instalar Xfce4 y lxdm (añadir más DE en el futuro)
# Editar vbox y que use el nombre de usuario creado anteriormente
# Autointroducir la contraseña que se introdujo antes para el usuario
echo "Ejecutando su vbox instalar yaourt, Xfce y lxdm y varios extras"
su vbox -c 'yaourt -S --noconfirm --needed xdg-user-dirs xfce4 xfce4-goodies lxdm lxdm-themes zsh git wget curl && xdg-user-dirs-update'
echo "yaourt Xfce y lxdm y sus extras instalados"
systemctl enable lxdm.service
systemctl enable NetworkManager.service
ls
rm $0
ls
exit
