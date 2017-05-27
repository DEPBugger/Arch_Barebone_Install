#!/bin/bash
# Este script es solo una prueba, y aunque no lo fuera lo usas bajo tu propio riesgo. No lo uses en tu ordenador real, pruébalo en una máquina virtual.
# Pensado para computadoras de 64 bits
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
read -p 'Press Enter to begin installation process.'
mount -o remount,size=2G /run/archiso/cowspace
echo '/run/archiso/cowspace ampliada a 2GB'
pacman -Syy --noconfirm git
echo 'git instalado'
git clone https://github.com/DEPBugger/Arch_Barebone_Install.git
echo 'Repositorio clonado'
cd Arch_Barebone_Install
echo 'Se ha entrado en la carpeta del repo'
# ¿Continuar?
dhcpcd
ping -c 3 kernel.org
lsblk
# ¿Continuar?
echo''
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
echo '########---Instalando reflector y actualizando la mirrorlist del live para usar lor mirrors más rápidos---########'
pacman -Syy reflector --noconfirm
reflector --latest 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel networkmanager net-tools
genfstab -U /mnt >> /mnt/etc/fstab
cp Test1.bash /mnt
ls /mnt
arch-chroot /mnt bash Test1.bash
############-----Ahora ejecutará el siguiente script-----############
############-----Todo lo que hay a continuación se ejecuta después de que Test1.bash haya finalizado-----############
echo ''
umount -R /mnt
echo 'A continuación se reiniciará el ordenador, por favor extrae el medio de instalación de Arch Linux (memoria USB, DVD, CD...) en cuanto desaparezcan estas letras.'
read -p 'Pulsa Enter cuando hayas leído y comprendido el mensaje anterior.'
reboot
