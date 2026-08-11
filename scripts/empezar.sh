#!/usr/bin/env bash
set -euo pipefail

bash scripts/preflight.sh
bash scripts/verificar-ejercicio.sh
cat <<'MSG'

Antes de ejecutar, abre README.md y lee:
  1. El caso de Cobranza Pro.
  2. La diferencia entre Nest y Swarm.
  3. La pregunta de predicción.

Después corre solamente:
  bash scripts/correr-nest.sh

Tu facilitador demostrará el Swarm. Tu entregable no es un número de /usage:
es la tarjeta tarjetas/DECISION-ARQUITECTURA.md.
MSG
