#!/bin/bash
#

# Verificar que se han proporcionado dos argumentos
if [ $# -ne 2 ]; then
        echo "Se necesitan dos argumentos de entrada: nombre del proceso y comando a ejecutar."
        exit 1
fi

# Asignar los argumentos a las variables
nombre_proceso=$1
comando_ejecutar=$2

# Función para verificar el estado del proceso y ejecutarlo si no corre
verificando() {
        if pgrep -x "$nombre_proceso" >/dev/null 2>&1; then
                echo "Proceso $nombre_proceso ejecutándose..."
        else
                echo "$nombre_proceso no encontrado. Iniciando proceso..."
                $comando_ejecutar >> /var/log/monitoreo_proceso.log 2>&1 &
        fi
}

# Bucle infinito para verificar el proceso cada 15 segundos
while true; do
        verificando
        sleep 15
done



