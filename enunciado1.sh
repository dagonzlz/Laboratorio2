#!/bin/bash

#
#Verificando argumentos de entrada
#
if [ $# -ne]; then
        echo "Error, proporciona un ID"
        exit 1
fi

PID=$1
echo "ID DEL PROCESO: $1"

#Luego tiene que vertificar que existe
if ! ps -p $PID > /dev/null 2>$1
        echo "El proceso con PID $PID no existe"
        exit 1
fi


#a)NOMBRE
Nombre=$(ps -p $PID -o comm=)

#b)ID del proceso
Proceso_id=$(ps -p $PID -o pid=)

#c)Parent process
Parent=$(ps -p $PID -o ppid=)

#d)Usuario
Usuario=$(ps -p $PID -o user=)

#e)porcentaje de uso del cpu
CPU=$(ps -p $PID -o %cpu=)

#f)Memoria
Memoria=$(ps -p $PID -o %mem=)

#g)Estado
Estado=$(ps -p $PID -o stat=)

#h)Path del ejecutable
Ruta=$(readlink -f /proc/$PID/exe)

#Mostrar la informacion

echo "Procesando-------"
echo "a)Nombre del proceso: $Nombre"
echo "b)ID del proceso: $Proceso_id"
echo "c)Parent process ID: $Parent"
echo "d)Usuario propietario: $Usuario"
echo "e)Porcentaje de uso de CPU: $CPU"
echo "f)Consumo de memoria: $Memoria"
echo "g)Estado: $Estado"
echo "h)Path del ejecutable: $Ruta"


