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
  "trazas/README.md"
  "scripts/preflight.sh"
  "scripts/empezar.sh"
  "scripts/abrir-corrida.sh"
  "scripts/registrar-corrida.sh"
  "tests/test-launchers.sh"
  ".claude/agents/nest-coordinador.md"
)

for file in "${required[@]}"; do
  test -s "$file" || { echo "FALTA: $file" >&2; exit 1; }
done

for i in 1 2 3 4 5 6; do
  test -s ".claude/agents/fuente-${i}.md" || { echo "FALTA agente fuente-${i}" >&2; exit 1; }
  grep -q '^model: inherit$' ".claude/agents/fuente-${i}.md" || { echo "Modelo no heredado: fuente-${i}" >&2; exit 1; }
  grep -q "A${i}.md" ".claude/agents/fuente-${i}.md" || { echo "Ruta A incorrecta: fuente-${i}" >&2; exit 1; }
  grep -q "B${i}.md" ".claude/agents/fuente-${i}.md" || { echo "Ruta B incorrecta: fuente-${i}" >&2; exit 1; }
  test -s "fuentes/tarea-a/A${i}.md" || { echo "FALTA fuente A${i}" >&2; exit 1; }
  test -s "fuentes/tarea-b/B${i}.md" || { echo "FALTA fuente B${i}" >&2; exit 1; }
done

for launcher in correr-baseline-a correr-nest-a correr-baseline-b correr-nest-b; do
  test -x "scripts/${launcher}.sh" || { echo "FALTA launcher ejecutable: ${launcher}" >&2; exit 1; }
done

grep -q -- '--disallowedTools Agent' README.md || { echo "Baseline no documentado" >&2; exit 1; }
grep -q 'NEST COMPLETADO: 6/6 fuentes recibidas' README.md || { echo "Criterio de nest no documentado" >&2; exit 1; }
grep -q 'exec claude --disallowedTools Agent' scripts/abrir-corrida.sh || { echo "Baseline no ejecutable" >&2; exit 1; }
grep -q 'exec claude --agent nest-coordinador' scripts/abrir-corrida.sh || { echo "Nest no ejecutable" >&2; exit 1; }
grep -q 'NEST COMPLETADO: 6/6 fuentes recibidas' .claude/agents/nest-coordinador.md || { echo "Cierre de nest no definido" >&2; exit 1; }
grep -q 'A1, A2, A3, A4, A5 y A6' rubricas/rubrica-a.md || { echo "Rúbrica A incompleta" >&2; exit 1; }
grep -q 'OC-2847' rubricas/rubrica-b.md || { echo "Rúbrica B incompleta" >&2; exit 1; }

echo "OK — el ejercicio tiene corpus, agentes, launchers y criterios de salida ejecutables."
