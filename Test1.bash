#!/bin/bash
# Este script es solo una prueba, y aunque no lo fuera lo usas bajo tu propio riesgo. No lo uses en tu ordenador real, pruébalo en una máquina virtual.
# Pensado para computadoras de 64 bits
echo ""
echo ""
echo ""
cat WelcomeTextFile
read -p "Press Enter to begin installation process."
# ¿Continuar?
dhcpcd
ping -c 3 kernel.org
lsblk
# ¿Continuar?
echo "Ahora deberás editar el particionado de tu disco"
# echo "Pulsa enter cuando estés list@"
# Añadir espera tras el echo anterior
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
mount /dev/sda2 /mnt
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
lsblk
# ¿Está correcto?
# mount /dev/sda3 /mnt/home
echo '########---Instalando reflector y actualizando la mirrorlist del live---########'
pacman -Syy reflector --noconfirm
reflector --latest 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel networkmanager net-tools
genfstab -U /mnt >> /mnt/etc/fstab
cp ~/Arch_Barebone_Install/Test2.bash /mnt
ls /mnt/tmp
arch-chroot /mnt bash Test2.bash
############-----Ahora ejecutará el siguiente script-----############
############-----Todo lo que hay a continuación se ejecuta después de que Test2.bash haya finalizado-----############
umount -R /mnt
poweroff
