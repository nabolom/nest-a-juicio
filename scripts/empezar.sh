#!/usr/bin/env bash
set -euo pipefail

bash scripts/preflight.sh
bash scripts/verificar-ejercicio.sh
cat <<'MSG'

Antes de ejecutar, abre README.md y lee:
  1. El caso de Cobranza Pro.
  2. La diferencia entre Nest y Swarm.
  3. La pregunta de predicción.

Después corre los dos patrones, uno a la vez:
  1. bash scripts/correr-nest.sh
  2. bash scripts/correr-swarm.sh

El Swarm usa Agent Teams, una función experimental. Si no aparecen teammates
ni tareas compartidas en 90 segundos, escribe /exit y usa el Plan B del README.
Tu entregable es la tarjeta tarjetas/DECISION-ARQUITECTURA.md.
MSG
