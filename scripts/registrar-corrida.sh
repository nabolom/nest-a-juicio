#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 6 ]; then
  echo "Uso: $0 <nombre> <tokens> <costo_usd> <pct_subagentes> <segundos> <calidad_0a5>" >&2
  exit 1
fi

nombre="$1"
tokens="$2"
costo="$3"
pct="$4"
segundos="$5"
calidad="$6"
archivo="trazas/${nombre}.md"

cat > "$archivo" <<EOF2
# Registro de corrida — ${nombre}

> Captura de \\`/usage\\` y rúbrica registrada manualmente. Fecha: $(date -Iseconds).

| Métrica | Valor |
|---|---:|
| Tokens totales | ${tokens} |
| Costo estimado (USD) | ${costo} |
| % atribuido a subagentes | ${pct}% |
| Duración (segundos) | ${segundos} |
| Calidad (0–5) | ${calidad} |

## Captura

Agrega debajo una captura de \\`/usage\\` o un enlace a ella. No sustituyas esta evidencia por memoria.
EOF2

echo "Registro creado: ${archivo}"
