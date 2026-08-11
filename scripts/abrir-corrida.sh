#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 2 ]; then
  echo "Uso: $0 <baseline|nest> <a|b>" >&2
  exit 1
fi

modo="$1"
tarea="$2"
case "$tarea" in
  a) archivo_tarea="tareas/tarea-a-paralela.md"; etiqueta="A" ;;
  b) archivo_tarea="tareas/tarea-b-secuencial.md"; etiqueta="B" ;;
  *) echo "La tarea debe ser a o b." >&2; exit 1 ;;
esac

case "$modo" in
  baseline|nest) ;;
  *) echo "El modo debe ser baseline o nest." >&2; exit 1 ;;
esac

bash scripts/preflight.sh

contenido="$(cat "$archivo_tarea")"
if [ "$modo" = "baseline" ]; then
  prompt=$(cat <<EOF2
EJERCICIO NEST A JUICIO — BASELINE, TAREA ${etiqueta}

Resuelve la siguiente tarea tú solo. La herramienta Agent está bloqueada deliberadamente: no intentes delegar, no pidas subagentes y no uses web, MCP ni fuentes externas. Lee exclusivamente los archivos del corpus que la tarea indica y responde con el formato exacto solicitado.

TAREA:
${contenido}

Cuando termines la salida, permanece en esta sesión. El participante escribirá /usage para medir tokens, costo estimado y atribución antes de salir.
EOF2
)
  echo "Abriendo BASELINE ${etiqueta}. Cuando Claude termine: 1) escribe /usage; 2) toma captura; 3) escribe /exit."
  exec claude --disallowedTools Agent "$prompt"
else
  prompt=$(cat <<EOF2
EJERCICIO NEST A JUICIO — NEST, TAREA ${etiqueta}

Ejecuta esta tarea usando el agente principal nest-coordinador. El coordinador debe delegar obligatoriamente a fuente-1, fuente-2, fuente-3, fuente-4, fuente-5 y fuente-6 antes de sintetizar. No uses web, MCP ni fuentes externas. Al final debe aparecer: NEST COMPLETADO: 6/6 fuentes recibidas.

TAREA:
${contenido}

Cuando termines la salida, permanece en esta sesión. El participante escribirá /usage para medir tokens, costo estimado y atribución antes de salir.
EOF2
)
  echo "Abriendo NEST ${etiqueta}. Debes ver seis delegaciones. Al terminar: 1) escribe /usage; 2) toma captura; 3) escribe /exit."
  exec claude --agent nest-coordinador "$prompt"
fi
