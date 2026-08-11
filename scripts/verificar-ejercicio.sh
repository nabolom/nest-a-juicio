#!/usr/bin/env bash
set -euo pipefail

required=(
  "README.md"
  "CLAUDE.md"
  "caso/lanzamiento-cobranza-pro.md"
  ".claude/agents/nest-coordinador.md"
  ".claude/commands/cerrar-s5.md"
  ".claude/commands/decidir-arquitectura.md"
  ".claude/agents/producto.md"
  ".claude/agents/ventas.md"
  ".claude/agents/riesgo.md"
  ".claude/agents/operaciones.md"
  "scripts/preflight.sh"
  "scripts/empezar.sh"
  "scripts/correr-nest.sh"
  "scripts/correr-swarm.sh"
  "tarjetas/DECISION-ARQUITECTURA.md"
  "resultados/.gitkeep"
  "resultados/README.md"
  "facilitador/PROMPT-SWARM.md"
  "facilitador/GUIA-DEMO-SWARM.md"
  "tests/test-nest-launcher.sh"
  "tests/test-swarm-launcher.sh"
  "tests/test-conclusion-flow.sh"
  "tests/test-decision-command.sh"
)

for file in "${required[@]}"; do
  test -s "$file" || { echo "FALTA: $file" >&2; exit 1; }
done

for role in producto ventas riesgo operaciones; do
  grep -q "name: ${role}" ".claude/agents/${role}.md" || { echo "Rol inválido: ${role}" >&2; exit 1; }
done

grep -q 'Agent(producto)' .claude/agents/nest-coordinador.md || { echo "Nest no puede delegar a producto" >&2; exit 1; }
grep -q 'Agent(ventas)' .claude/agents/nest-coordinador.md || { echo "Nest no puede delegar a ventas" >&2; exit 1; }
grep -q 'Agent(riesgo)' .claude/agents/nest-coordinador.md || { echo "Nest no puede delegar a riesgo" >&2; exit 1; }
grep -q 'Agent(operaciones)' .claude/agents/nest-coordinador.md || { echo "Nest no puede delegar a operaciones" >&2; exit 1; }
grep -q 'exec claude --agent nest-coordinador' scripts/correr-nest.sh || { echo "Launcher Nest no ejecutable" >&2; exit 1; }
grep -q 'CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1' scripts/correr-swarm.sh || { echo "Launcher Swarm no activa Agent Teams" >&2; exit 1; }
grep -q 'Agent Team' scripts/correr-swarm.sh || { echo "Launcher Swarm no exige Agent Team" >&2; exit 1; }
grep -q 'NEST COMPLETADO: 4/4 reportes recibidos' README.md || { echo "Señal de salida ausente" >&2; exit 1; }
grep -q 'resultados/conclusion-nest.md' README.md || { echo "README no explica la conclusión guardada" >&2; exit 1; }
grep -q '/cerrar-s5' README.md || { echo "README no explica la entrega final" >&2; exit 1; }
grep -q '/decidir-arquitectura' README.md || { echo "README no explica la decisión guiada" >&2; exit 1; }
grep -q 'No necesitas escribir /usage' scripts/correr-nest.sh || { echo "Launcher Nest no explica que /usage queda fuera del ejercicio" >&2; exit 1; }

echo "OK — ejercicio S5: Nest y Swarm ejecutables + decisión guiada y entrega descargable."
