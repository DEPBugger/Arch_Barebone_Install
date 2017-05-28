function InfoHelp() {
	clear
	echo "This installer script will takes the following steps, please write them down so that you can easily follow the installation process"
	echo "1) ....."
	echo "2) ....."
	echo "3) ....."
	echo "4) ....."
	echo "5) ....."
	echo "6) ....."
	echo ""
	echo "From now on keep in mind that when you see [y/n] you must answer y (affirmative answer) or n (negative answer)"
	echo "Continue? [y/n]"

	while true
		do
			read input

			case $input in
				Y|y) break;;
				N|n) exit 0;;
				*) echo "Invalid answer, please answer just y for yes or n for no [y/n]";;
			esac
		done
}

