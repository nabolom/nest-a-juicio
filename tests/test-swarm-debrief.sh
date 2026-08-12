#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
command="$repo_dir/.claude/commands/explicar-swarm.md"
closure="$repo_dir/.claude/commands/cerrar-s5.md"

for file in "$command" "$closure"; do
  test -s "$file" || { echo "FALTA: $file" >&2; exit 1; }
done

grep -Fq 'No entrevistes al alumno' "$command"
grep -Fq 'resultados/debrief-swarm.md' "$command"
grep -Fq 'No hay evidencia de un Swarm válido en esta corrida' "$command"
grep -Fq '## 5. Diagnóstico de Claude: para este caso elegimos Nest' "$command"
grep -Fq '**Recomendación:** `Nest`' "$command"
grep -Fq 'Por qué no elegimos Swarm aquí' "$command"
grep -Fq 'VEREDICTO: para Cobranza Pro, Nest es suficiente.' "$command"
grep -Fq 'resultados/debrief-swarm.md' "$closure"
grep -Fq '/explicar-swarm' "$repo_dir/README.md"
grep -Fq 'resultados/reporte-swarm.md' "$repo_dir/README.md"

echo "OK — diagnóstico compara Nest vs. Swarm y explica por qué Nest es suficiente para Cobranza Pro."
