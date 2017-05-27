#!/bin/bash
clear
echo "____                           __                                  ______                   __             ___    ___      "
echo "/\  _ \                        /\ \                                /\__  _\                 /\ \__         /\_ \  /\_ \    "
echo "\ \ \L\ \     __     _ __    __\ \ \____    ___     ___      __    \/_/\ \/     ___     ____\ \ ,_\    __  \//\ \ \//\ \   "
echo "\ \  _ <   / __ \  /\  __\/ __ \ \  __ \  / __ \ /  _  \  / __ \     \ \ \   /  _  \  / ,__\\ \ \/  / __ \  \ \ \  \ \ \   "
echo " \ \ \L\ \/\ \L\.\_\ \ \//\  __/\ \ \L\ \/\ \L\ \/\ \/\ \/\  __/      \_\ \__/\ \/\ \/\__,  \\ \ \_/\ \L\.\_ \_\ \_ \_\ \_ "
echo "  \ \____/\ \__/.\_\\ \_\\ \____\\ \_,__/\ \____/\ \_\ \_\ \____\     /\_____\ \_\ \_\/\____/ \ \__\ \__/.\_\/\____\/\____\ "
echo "   \/___/  \/__/\/_/ \/_/ \/____/ \/___/  \/___/  \/_/\/_/\/____/     \/_____/\/_/\/_/\/___/   \/__/\/__/\/_/\/____/\/____/"
                                                                                                                           
                                                                                                                           

loadkeys es
echo "Teclado del entorno live configurado a español"
mount -o remount,size=2G /run/archiso/cowspace
echo "/run/archiso/cowspace ampliada a 2GB"
pacman -Syy --noconfirm git
echo "git instalado"
git clone https://github.com/DEPBugger/Arch_Barebone_Install.git
echo "Repositorio clonado"
cd Arch_Barebone_Install
echo "Entrado en la carpeta del repo para ejecutar Test1.bash"
bash Test1.bash
