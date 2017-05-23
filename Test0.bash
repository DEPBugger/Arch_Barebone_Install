#!/bin/bash
# Este script es solo una prueba, lo usas bajo tu propio riesgo. No lo uses en tu ordenador real, pruébalo en una máquina virtual.
# Pensado para computadoras de 64 bits
echo "##################--------Test--------##################"
# ¿Continuar?
loadkeys es
echo "Teclado del entorno live configurado a español"
dhcpcd
ping -c 3 kernel.org
lsblk
# ¿Continuar?
echo "Ahora deberás editar el particionado de tu disco"
# Añadir opción para eliminar la tabla de particiones
cfdisk /dev/sda
lsblk
# ¿Es correcto?
# Añadir opción para editar el /dev/sdXY de los mkfs
mkfs.vfat -F32 /dev/sda1
mkfs.ext4 -L "Arch Linux" /dev/sda2
# mkfs.ext4 -L "home" /dev/sda3
# mkswap /dev/sda4
# swapon /dev/sda4
# mkdir /mnt/home
mkdir -p /mnt/boot/efi
mount /dev/sda2 /mnt
mount /dev/sda1 /mnt/boot/efi
# mount /dev/sda3 /mnt/home
pacman -Syy reflector --noconfirm
reflector --latest 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel networkmanager net-tools
genfstab -U -p /mnt >> /mnt/etc/fstab
arch-chroot /mnt ./Test1.bash
############-----Ahora ejecutará el siguiente script-----############
############-----Todo lo que hay a continuación se ejecuta después de que Test1.bash haya finalizado-----############
poweroff
# Hay que ejecutar en el siguiente inicio
# systemctl start NetworkManager.service
# systemctl enable NetworkManager.service
