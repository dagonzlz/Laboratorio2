#!/bin/bash
#

#Argumentos proporcionados de forma correcta??
#
if [ $# -ne 2]; then
	echo "Se necesitan dos argumentos de entrada"
	exit 1
fi

#Hay que asignar los argumentos a las variables
nombre_proceso=$1
comando_ejecutar=$2

#Verifar
verificando() {
	pgrep "nombre_proceso" >/dev/null
}

while true; do
	if verificando; then
		echo "Proceso $nombre_proceso corriendo"
	else
		echo "Proceso $nombre_proceso no esta corriendo"
		#necesita iniciar el proceso si no esta corriendo entonces
		echo "Proceso $nombre_proceso inciando..."
	fi
	sleep 1

done


	
