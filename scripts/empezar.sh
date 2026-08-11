#!/usr/bin/env bash
set -euo pipefail

bash scripts/preflight.sh
bash scripts/verificar-ejercicio.sh
cat <<'MSG'

Listo. No copies prompts manualmente. Corre estas cuatro sesiones en este orden:

  1. bash scripts/correr-baseline-a.sh
  2. bash scripts/correr-nest-a.sh
  3. bash scripts/correr-baseline-b.sh
  4. bash scripts/correr-nest-b.sh

Después de CADA corrida:
  a) dentro de Claude Code escribe /usage;
  b) guarda una captura;
  c) escribe /exit;
  d) en la terminal corre scripts/registrar-corrida.sh con tus seis datos.

En las dos corridas NEST debes ver seis delegaciones y la línea:
  NEST COMPLETADO: 6/6 fuentes recibidas.

Si no ves ambas cosas, detente: no tienes una corrida nest válida.
MSG
