#!/usr/bin/env bash
set -euo pipefail

required=(
  "README.md"
  "CLAUDE.md"
  "caso/lanzamiento-cobranza-pro.md"
  ".claude/agents/nest-coordinador.md"
  ".claude/agents/producto.md"
  ".claude/agents/ventas.md"
  ".claude/agents/riesgo.md"
  ".claude/agents/operaciones.md"
  "scripts/preflight.sh"
  "scripts/empezar.sh"
  "scripts/correr-nest.sh"
  "tarjetas/DECISION-ARQUITECTURA.md"
  "facilitador/PROMPT-SWARM.md"
  "facilitador/GUIA-DEMO-SWARM.md"
  "tests/test-nest-launcher.sh"
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
grep -q 'NEST COMPLETADO: 4/4 reportes recibidos' README.md || { echo "Señal de salida ausente" >&2; exit 1; }
! grep -q '/usage' scripts/correr-nest.sh || { echo "Launcher Nest no debe pedir /usage" >&2; exit 1; }

echo "OK — ejercicio S5 simplificado: Nest para alumnos, Swarm para demo y tarjeta de arquitectura."
