#!/usr/bin/env bash
set -euo pipefail

if ! command -v claude >/dev/null 2>&1; then
  cat >&2 <<'MSG'
ERROR: No encuentro `claude`.

Instala Claude Code, abre una terminal nueva y confirma:
  claude --version
MSG
  exit 1
fi

if ! claude auth status >/dev/null 2>&1; then
  cat >&2 <<'MSG'
ERROR: Claude Code está instalado, pero no has iniciado sesión.

Corre:
  claude auth login
MSG
  exit 1
fi

echo "OK — Claude Code está listo."
