#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
mock_dir="$(mktemp -d)"
log_file="$(mktemp)"
cleanup() {
  rm -rf "$mock_dir" "$log_file"
}
trap cleanup EXIT

cat > "$mock_dir/claude" <<'EOF'
#!/usr/bin/env bash
if [ "${1:-}" = "auth" ] && [ "${2:-}" = "status" ]; then
  exit 0
fi
if [ "${1:-}" = "--version" ]; then
  echo "2.1.test"
  exit 0
fi
printf '%s\n' "$*" >> "${NEST_TEST_LOG}"
EOF
chmod +x "$mock_dir/claude"

run_and_assert() {
  local script="$1"
  local expected_flag="$2"
  local expected_task="$3"
  : > "$log_file"
  PATH="$mock_dir:$PATH" NEST_TEST_LOG="$log_file" bash "$repo_dir/$script" >/dev/null
  grep -Fq -- "$expected_flag" "$log_file"
  grep -Fq -- "$expected_task" "$log_file"
}

run_and_assert "scripts/correr-baseline-a.sh" "--disallowedTools Agent" "EJERCICIO NEST A JUICIO — BASELINE, TAREA A"
run_and_assert "scripts/correr-baseline-b.sh" "--disallowedTools Agent" "EJERCICIO NEST A JUICIO — BASELINE, TAREA B"
run_and_assert "scripts/correr-nest-a.sh" "--agent nest-coordinador" "EJERCICIO NEST A JUICIO — NEST, TAREA A"
run_and_assert "scripts/correr-nest-b.sh" "--agent nest-coordinador" "EJERCICIO NEST A JUICIO — NEST, TAREA B"

echo "OK — los cuatro launchers abren Claude Code con el modo y la tarea correctos."
