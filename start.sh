function Start() {
    echo "Bienvenido al instalador de Arch Linux."    
    
    # Compruebo si existe un archivo de configuración.
    FIND=$(find . -name arch.conf | wc -l) 
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

	read input

    # En caso afirmativo vamos a tratar el archivo de configuración.
	if [ "$input" == "Y" ] || [ "$input" == "y" ]
    then
        echo $input
    fi
}

function Preguntas() {
    echo "Preguntas"
}

function Archivo() {
    echo "Archivo"
}

Start
