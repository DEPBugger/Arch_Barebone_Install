usuario=""
host=""
dispositivo=""
efi=""
size_efi=""
size_boot=""
size_root=""
size_home=""
size_swap=""
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
    # No voy a comentar las preguntas, se explican ellas mismas :)
    read -p "Introduce el nombre de usuario: " usuario
    read -p "Introduce el hostname: " host
    read -s -p "Introduce la contraseña del usuario root: " passroot
    echo
    read -s -p "Introduce la contraseña de tu usuario: " passuser
    echo
    echo "Vamos a empezar el particionado guiado. ¡Prepárate para las preguntas!"
    read
    read -p "Introduce el dispositivo (Ej. /dev/sda): " dispositivo
    read -p "Indique la partición EFI si ya tiene una (Ej. /dev/sda1) o asigne el espacio deseado para crear una nueva (Recomendado: 512M): " efi
    read -p "Asigne el espacio que quiere asignar a la partición \"/\": " size_root
    read -p "Asigne el espacio que quiere asignar a la partición \"/boot\" (si no desea una partición \"/boot\" déjelo en blanco): " size_boot
    read -p "Asigne el espacio que quiere asignar a la partición \"/home\" (si no desea una partición \"/home\" déjelo en blanco): " size_home
    read -p "Asigne el espacio que quiere asignar a la partición de intercambio (si no desea una partición de intercambio déjelo en blanco): " size_swap
    
    # Si nos ha dado una partición seguimos avanzando, si nos ha dado un tamaño creamos la partición.
    if [ "${efi:0:1}" != "/" ]
    then
        size_efi=$efi
        CrearEfi
    fi

    # Crear particiones.
    CrearObligatorias
    CrearOpcionales

    read -p "Introduce la GUI que desea instalar [XFCE/KDE]: " gui
    
}

function Archivo() {
    echo "Archivo"
}

function CrearEfi() {
    # Crea la partición de EFI.
    (
    echo n
    echo
    echo
    echo +$size_efi
    echo EF00
    echo w
    echo Y
    ) | gdisk $dispositivo

}

function CrearRoot() {
    # Crea la partición /.
    (
    echo n
    echo
    echo
    echo +$size_root
    echo 8300
    echo w
    echo Y
    ) | gdisk $dispositivo
}

function CrearOpcionales() {
    # Si se ha asignado un valor a /home, creala.
    if [ "$size_home" != "" ]
    then
        (
        echo n
        echo
        echo
        echo +$size_home
        echo 8300
        echo w
        echo Y
        ) | gdisk $dispositivo
    fi
    
    # Lo mismo con boot.
    if [ "$size_boot" != "" ]
    then
        (
        echo n
        echo
        echo
        echo +$size_boot
        echo 8300
        echo w
        echo Y
        ) | gdisk $dispositivo
    fi

    # Lo mismo con swap.
    if [ "$size_swap" != "" ]
    then
        (
        echo n
        echo
        echo
        echo +$size_swap
        echo 8200
        echo w
        echo Y
        ) | gdisk $dispositivo
    fi

}


Start

