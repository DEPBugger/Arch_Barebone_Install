loadkeys es
echo "Teclado del entorno live configurado a español"
mount -o remount,size=2G /run/archiso/cowspace
pacman -Syy --noconfirm git
git clone https://github.com/DEPBugger/Arch_Barebone_Install.git
cd Arch_Barebone_Install
bash Test1.bash
