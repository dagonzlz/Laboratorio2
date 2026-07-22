#!/bin/bash
#
# Verificar que se proporciona un argumento de entrada
if [ $# -ne 1 ]; then
    echo "Se requiere un argumento de entrada. ERROR"
    exit 1
fi

# Asignar variable del ejecutable
ejecutable=$1
echo "Este es el  $ejecutable"
# Archivo de log
log_file="cpu_consumo.txt"
# Limpiar archivo de log previo si existe
> $log_file
echo "Archivo de log $log_file limpiado."

# Ejecutar el binario
$ejecutable &

# Obtener el id del proceso
pid=$!
echo "PID del proceso: $pid"


# Usamos while para registrar el consumo de CPU y memoria
while ps -p $pid > /dev/null; do
    cpu=$(ps -p $pid -o %cpu --no-header | tr -d '[:space:]')
    memoria=$(ps -p $pid -o %mem --no-header | tr -d '[:space:]')
    fecha=$(date +%s)  # Tiempo en segundos
    echo "$fecha $cpu $memoria" >> $log_file
    echo "Escribiendo: $fecha $cpu $memoria"
    sleep 1
done

# Esperar que termine el proceso
wait $pid
echo "Proceso terminado, esperando."

# Graficar los valores con gnuplot
gnuplot << EOF
gnuplot << EOF
set terminal png size 800,600
set output "grafico.png"
set title "Consumo de CPU y Memoria"
set xlabel "Tiempo (s)"
set ylabel "Consumo (%)"
plot "$log_file" using 1:2 title "CPU" with lines, \
     "$log_file" using 1:3 title "Memoria" with lines
EOF
echo "Gráfico generado."

