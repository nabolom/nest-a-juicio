#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_dir"

for file in \
  "resultados/.gitkeep" \
  "resultados/README.md" \
  ".claude/commands/cerrar-s5.md" \
  ".claude/agents/nest-coordinador.md"; do
  test -s "$file" || { echo "FALTA: $file" >&2; exit 1; }
done

grep -q '  - Write' .claude/agents/nest-coordinador.md
grep -q 'resultados/conclusion-nest.md' .claude/agents/nest-coordinador.md
grep -q 'ARCHIVO GUARDADO: resultados/conclusion-nest.md' .claude/agents/nest-coordinador.md
grep -q 'resultados/entrega-s5.md' .claude/commands/cerrar-s5.md
grep -q 'ENTREGA LISTA: resultados/entrega-s5.md' .claude/commands/cerrar-s5.md
grep -q '/cerrar-s5' README.md

echo "OK — Nest guarda conclusión y /cerrar-s5 consolida una entrega descargable."
