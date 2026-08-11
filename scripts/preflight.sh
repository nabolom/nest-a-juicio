#!/usr/bin/env bash
set -euo pipefail

if ! command -v claude >/dev/null 2>&1; then
  cat >&2 <<'MSG'
ERROR: No encuentro el comando `claude`.

Instala Claude Code, cierra y vuelve a abrir la terminal, y confirma con:
  claude --version
MSG
  exit 1
fi

if ! claude auth status >/dev/null 2>&1; then
  cat >&2 <<'MSG'
ERROR: Claude Code está instalado, pero no has iniciado sesión.

Corre:
  claude auth login

Luego vuelve a ejecutar este script.
MSG
  exit 1
fi

echo "OK — Claude Code está instalado y autenticado."
echo "Versión: $(claude --version)"
