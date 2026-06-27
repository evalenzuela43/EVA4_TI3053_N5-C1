#!/bin/bash

echo "=== Iniciando prueba de estrés CPU ==="
echo "Esto disparará el Auto Scaling. Duración: 5 minutos"

# Estresar todos los núcleos disponibles
CORES=$(nproc)
echo "Núcleos detectados: $CORES"

for i in $(seq 1 $CORES); do
  dd if=/dev/zero of=/dev/null &
done

sleep 300
kill $(jobs -p)
echo "=== Prueba de estrés finalizada ==="