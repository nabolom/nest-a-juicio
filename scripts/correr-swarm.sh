#!/usr/bin/env bash
set -euo pipefail

bash scripts/preflight.sh
caso="$(cat caso/lanzamiento-cobranza-pro.md)"
prompt=$(cat <<EOF2
EJERCICIO S5 — EJECUTA EL SWARM COMO AGENT TEAM

Quiero un **Agent Team**, no subagentes normales. Usa el caso siguiente.

Crea cuatro teammates con estos roles de proyecto: producto, ventas, riesgo y operaciones. Cada teammate debe leer el caso desde su perspectiva. Crea una lista de tareas compartida con una tarea para cada perspectiva y una tarea final de síntesis.

Cuando terminen sus análisis, exige esta comunicación entre pares antes de sintetizar:
- Riesgo debe enviar un mensaje directo a Ventas: explica por qué los 12 clientes regulados no pueden activarse automáticamente.
- Ventas debe responder a Riesgo con una propuesta concreta para cumplir la fecha sin prometer una activación prohibida.
- Operaciones debe responder a ambos: confirma si la propuesta cabe dentro de 15 inscripciones manuales durante la primera semana.

Solo después de esos mensajes, sintetiza una decisión con el formato exacto del caso. Antes de la respuesta final confirma: (1) cuatro tareas de perspectiva completadas; (2) mensajes directos entre Riesgo, Ventas y Operaciones; (3) una tarea final de síntesis completada.

CASO:
${caso}

Cierra con esta línea exacta: SWARM COMPLETADO: equipo, tareas compartidas y mensajes entre pares observados.
EOF2
)

echo "Abriendo SWARM (Agent Team experimental)."
echo "Mira el panel: deben aparecer 4 teammates y tareas compartidas."
echo "Si en 90 segundos no ves teammates, escribe /exit y usa el Plan B del README."
exec env CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 claude "$prompt"
