#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
mock_dir="$(mktemp -d)"
log_file="$(mktemp)"
cleanup() { rm -rf "$mock_dir" "$log_file"; }
trap cleanup EXIT

cat > "$mock_dir/claude" <<'MOCK'
#!/usr/bin/env bash
if [ "${1:-}" = "auth" ] && [ "${2:-}" = "status" ]; then exit 0; fi
if [ "${1:-}" = "--version" ]; then echo "2.1.test"; exit 0; fi
printf 'ENV=%s ARGS=%s\n' "${CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS:-}" "$*" >> "${SWARM_TEST_LOG}"
MOCK
chmod +x "$mock_dir/claude"

PATH="$mock_dir:$PATH" SWARM_TEST_LOG="$log_file" bash "$repo_dir/scripts/correr-swarm.sh" >/dev/null
grep -Fq -- 'ENV=1' "$log_file"
grep -Fq -- 'EJERCICIO S5 — SWARM BREVE COMO AGENT TEAM' "$log_file"
grep -Fq -- 'exactamente tres teammates' "$log_file"
grep -Fq -- 'Riesgo debe enviar a Ventas' "$log_file"
grep -Fq -- 'resultados/reporte-swarm.md' "$log_file"
grep -Fq -- 'SWARM COMPLETADO: teammates, tareas compartidas y dos mensajes entre pares observados.' "$log_file"

echo "OK — launcher Swarm breve activa Agent Teams y exige un reporte final con comunicación entre pares."
