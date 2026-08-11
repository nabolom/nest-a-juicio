#!/usr/bin/env bash
set -euo pipefail

bash scripts/preflight.sh
caso="$(cat caso/lanzamiento-cobranza-pro.md)"
prompt=$(cat <<EOF2
EJERCICIO S5 — EJECUTA EL NEST

Resuelve el siguiente caso mediante el agente nest-coordinador. No leas ni resuelvas el caso tú solo: el coordinador debe delegar a producto, ventas, riesgo y operaciones; después sintetiza los cuatro reportes.

CASO:
${caso}

Al finalizar, la respuesta debe cerrar con: NEST COMPLETADO: 4/4 reportes recibidos.
EOF2
)

echo "Abriendo el NEST. Observa las cuatro delegaciones: producto, ventas, riesgo y operaciones."
echo "No necesitas escribir /usage. Cuando termine, guarda una captura del transcript y escribe /exit."
exec claude --agent nest-coordinador "$prompt"
