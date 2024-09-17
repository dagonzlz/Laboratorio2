#!/bin/bash
#
#se elije un directorio
directorio= "/home/usuario/monitoriar"
archivo_log="home/usuario/monitoriar/cambios_log.txt"

#escribir el mensaje
write_log() {
	tiempo=$(date +%Y-%m-%d-%H-%M-%S)
	echo "$tiempo $1" >> $archivo_log
}

#MOnitorear el directorio usando inotifywait
while true: do
	inotifywait -q -e create,modify,delete --format "%w%f" $directorio | while read ARCHIVO; do
	write_log "Detectado: $ARCHIVO"
done
done
