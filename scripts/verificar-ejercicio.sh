#!/usr/bin/env bash
set -euo pipefail

required=(
  "CLAUDE.md"
  "README.md"
  "tareas/tarea-a-paralela.md"
  "tareas/tarea-b-secuencial.md"
  "rubricas/rubrica-a.md"
  "rubricas/rubrica-b.md"
  "tarjetas/PLANTILLA-veredicto.md"
  "scripts/registrar-corrida.sh"
  "trazas/README.md"
)

for file in "${required[@]}"; do
  test -s "$file" || { echo "FALTA: $file" >&2; exit 1; }
done

for i in 1 2 3 4 5 6; do
  test -s ".claude/agents/fuente-${i}.md" || { echo "FALTA agente fuente-${i}" >&2; exit 1; }
  grep -q '^model: inherit$' ".claude/agents/fuente-${i}.md" || { echo "Modelo no heredado: fuente-${i}" >&2; exit 1; }
  test -s "fuentes/tarea-a/A${i}.md" || { echo "FALTA fuente A${i}" >&2; exit 1; }
  test -s "fuentes/tarea-b/B${i}.md" || { echo "FALTA fuente B${i}" >&2; exit 1; }
done

grep -q 'claude --disallowedTools Agent' README.md || { echo "Baseline no bloqueado" >&2; exit 1; }
grep -q 'fuente-1 a fuente-6' README.md || { echo "Nest no documentado" >&2; exit 1; }
grep -q 'A1, A2, A3, A4, A5 y A6' rubricas/rubrica-a.md || { echo "Rúbrica A incompleta" >&2; exit 1; }
grep -q 'OC-2847' rubricas/rubrica-b.md || { echo "Rúbrica B incompleta" >&2; exit 1; }

echo "OK — nest-a-juicio está completo para el ensayo de facilitación."
