#!/usr/bin/env bash
set -euo pipefail

bash scripts/preflight.sh
caso="$(cat caso/lanzamiento-cobranza-pro.md)"
prompt=$(cat <<EOF2
EJERCICIO S5 — SWARM BREVE COMO AGENT TEAM

Quiero un **Agent Team real**, no subagentes normales. Esta es una demostración de arquitectura: necesitamos ver teammates, una tarea compartida y comunicación directa entre pares, pero no necesitamos una investigación larga.

Tú eres el líder y conservas el contexto de Producto. Crea exactamente tres teammates usando estos roles de proyecto: ventas, riesgo y operaciones. Cada teammate debe leer el caso y devolver un reporte de **máximo tres líneas**.

Crea una lista de tareas compartida con estas cuatro tareas y no agregues otras:
1. Ventas: proponer cómo conservar la fecha sin prometer una activación prohibida.
2. Riesgo: declarar la prohibición y la condición de control.
3. Operaciones: confirmar la capacidad de primera semana.
4. Líder: sintetizar la decisión y guardar el reporte.

Exige solo estos dos mensajes directos entre pares antes de sintetizar:
- Riesgo debe enviar a Ventas la restricción de los 12 clientes regulados.
- Ventas debe responder a Riesgo con una propuesta concreta que respete esa restricción.

Operaciones debe leer esa propuesta desde la tarea compartida y confirmar si cabe en 15 inscripciones manuales. No abras web, MCP ni fuentes fuera del repositorio. No inventes aprobaciones, recursos ni fechas.

CASO:
${caso}

Después de terminar las tres tareas de análisis y los dos mensajes, escribe el archivo resultados/reporte-swarm.md. Debe contener exactamente estas secciones:

# Reporte Swarm — Cobranza Pro
## Decisión
## Evidencia por rol
## Comunicación entre pares observada
## Qué cambió — o no cambió — frente al Nest
## Plan de 72 horas
## Lo que aún no se puede afirmar
## Estado del experimento

En la sección Estado del experimento, declara si viste: teammates, tarea compartida y los dos mensajes directos. Si falta cualquiera, escribe Swarm no validado y no lo presentes como una corrida válida.

Cierra solo después de escribir el archivo, con estas líneas exactas:
SALIDA GUARDADA: resultados/reporte-swarm.md
SWARM COMPLETADO: teammates, tareas compartidas y dos mensajes entre pares observados.
EOF2
)

echo "Abriendo SWARM breve (Agent Team experimental)."
echo "Busca 3 teammates, 4 tareas compartidas, 2 mensajes y el archivo resultados/reporte-swarm.md."
echo "Si en 90 segundos no aparecen teammates, escribe /exit: no cuentes la corrida como Swarm válido."
exec env CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 claude "$prompt"
