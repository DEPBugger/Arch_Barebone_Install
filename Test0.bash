#!/bin/bash
clear
echo "########     ###    ########  ######## ########   #######  ##    ## ########"
echo "##     ##   ## ##   ##     ## ##       ##     ## ##     ## ###   ## ##      "
echo "##     ##  ##   ##  ##     ## ##       ##     ## ##     ## ####  ## ##      "
echo "########  ##     ## ########  ######   ########  ##     ## ## ## ## ######  "
echo "##     ## ######### ##   ##   ##       ##     ## ##     ## ##  #### ##      "
echo "##     ## ##     ## ##    ##  ##       ##     ## ##     ## ##   ### ##      "
echo "########  ##     ## ##     ## ######## ########   #######  ##    ## ########"
                                                                                                                           
                                                                                                                           

loadkeys es
echo "Teclado del entorno live configurado a español"
mount -o remount,size=2G /run/archiso/cowspace
echo "/run/archiso/cowspace ampliada a 2GB"
pacman -Syy --noconfirm git
echo "git instalado"
git clone https://github.com/DEPBugger/Arch_Barebone_Install.git --branch test
echo "Repositorio clonado"
cd Arch_Barebone_Install
echo "Entrado en la carpeta del repo para ejecutar Test1.bash"
bash Test1.bash
