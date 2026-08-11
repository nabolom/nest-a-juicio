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
fecha="$(date -Iseconds)"

{
  echo "# Registro de corrida — ${nombre}"
  echo
  echo "> Captura de \`/usage\` y rúbrica registrada manualmente. Fecha: ${fecha}."
  echo
  echo "| Métrica | Valor |"
  echo "|---|---:|"
  echo "| Tokens totales | ${tokens} |"
  echo "| Costo estimado (USD) | ${costo} |"
  echo "| % atribuido a subagentes | ${pct}% |"
  echo "| Duración (segundos) | ${segundos} |"
  echo "| Calidad (0–5) | ${calidad} |"
  echo
  echo "## Captura"
  echo
  echo "Agrega debajo una captura de \`/usage\` o un enlace a ella. No sustituyas esta evidencia por memoria."
} > "$archivo"

echo "Registro creado: ${archivo}"
