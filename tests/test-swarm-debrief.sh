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
grep -Fq 'Por qué el Swarm tardó más' "$command"
grep -Fq 'DEBRIEF GUARDADO: resultados/debrief-swarm.md' "$command"
grep -Fq 'resultados/debrief-swarm.md' "$closure"
grep -Fq '/explicar-swarm' "$repo_dir/README.md"
grep -Fq 'resultados/reporte-swarm.md' "$repo_dir/README.md"

echo "OK — debrief Swarm explica la evidencia disponible sin entrevista larga y alimenta la entrega final."
