usuario=""
host=""
dispositivo=""
efi=""
boot=""
root=""
home=""
gui=""
passroot=""
passuser=""

function Start() {
    echo "Bienvenido al instalador de Arch Linux."    
    
    # Compruebo si existe un archivo de configuración.
    FIND=$(find . -name archq.conf | wc -l) 
    if [ $FIND -eq 1 ]
    then
        echo "Hemos detectado que tiene un archivo de configuración."
        echo ""
        cat arch.conf
        echo ""
        echo  "Presione una tecla para empezar la instalación."
        read
        Archivo
    else
        echo "No hemos encontrado ningún archivo de configuración. Si lo tiene, cambie su nombre por \"arch.conf\" y ejecute de nuevo el script. Si no lo tiene, pulse cualquier tecla para empezar."
        read
        Preguntas
    fi

}

# Función que hace todas las preguntas necesarias para realizar la configuración.
function Preguntas() {
    read -p "Introduce el nombre de usuario: " usuario
    read -p "Introduce el hostname: " host
    read -s -p "Introduce la contraseña del usuario root: " passroot
    echo
    read -s -p "Introduce la contraseña de tu usuario: " passuser
    echo
    echo "Vamos a empezar el particionado guiado. ¡Prepárate para las preguntas!"
    read -p "Introduce el dispositivo (Ej. /dev/sda): " dispositivo
    #cfdisk # Particionado manual
    read -p "Introduce la GUI que desea instalar [XFCE/KDE]: " gui
    
}

function Archivo() {
    echo "Archivo"
}

Start
