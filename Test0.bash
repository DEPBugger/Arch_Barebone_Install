#!/bin/bash
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
loadkeys es
echo 'Teclado del entorno live configurado a español'
mount -o remount,size=2G /run/archiso/cowspace
echo '/run/archiso/cowspace ampliada a 2GB'
pacman -Syy --noconfirm git
echo 'git instalado'
git clone https://github.com/DEPBugger/Arch_Barebone_Install.git
echo 'Repositorio clonado'
cd Arch_Barebone_Install
echo 'Entrado en la carpeta del repo para ejecutar Test1.bash'
bash Test1.bash
