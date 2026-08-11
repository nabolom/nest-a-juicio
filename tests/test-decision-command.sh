#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_dir"

command=".claude/commands/decidir-arquitectura.md"
test -s "$command"
grep -q '^description:' "$command"
grep -q 'una pregunta a la vez' "$command"
grep -q 'No escribas ningún archivo hasta recibir una confirmación explícita' "$command"
grep -q 'resultados/decision-arquitectonica.md' "$command"
grep -q 'DECISIÓN GUARDADA: resultados/decision-arquitectonica.md' "$command"

echo "OK — /decidir-arquitectura entrevista, pide confirmación y guarda la decisión."
