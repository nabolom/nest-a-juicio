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
printf '%s\n' "$*" >> "${NEST_TEST_LOG}"
MOCK
chmod +x "$mock_dir/claude"

PATH="$mock_dir:$PATH" NEST_TEST_LOG="$log_file" bash "$repo_dir/scripts/correr-nest.sh" >/dev/null
grep -Fq -- '--agent nest-coordinador' "$log_file"
grep -Fq -- 'EJERCICIO S5 — EJECUTA EL NEST' "$log_file"
grep -Fq -- 'Cobranza Pro' "$log_file"

echo "OK — launcher Nest abre el coordinador con el caso correcto."
