function Start() {
    echo "Bienvenido al instalador de Arch Linux."    
    
    FIND=$(find . -name arch.conf | wc -l) 
    if [ $FIND -eq 1 ]
    then
         echo "Hemos detectado que tiene un archivo de configuración. ¿Afirmativo? [Y/n]"
    else
        echo "No hemos encontrado ningún archivo de configuración. Si lo tiene, cambie su nombre por \"arch.conf\" y ejecute de nuevo el script. Si no lo tiene, pulse cualquier tecla para empezar."
        read
        Preguntas
    fi

	read input

    # En caso afirmativa vamos a tratar el archivo de configuración.
	if [ "$input" == "Y" ] || [ "$input" == "y" ]
    then
        echo $input
    fi
}

function Preguntas() {
    echo "Preguntas"
}

Start
