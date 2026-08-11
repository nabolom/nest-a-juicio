# Trazas de referencia y ensayo de facilitación

Las corridas de Claude Code requieren una cuenta autenticada y no deben inventarse. Antes de facilitar la S5, ejecuta las cuatro corridas (baseline A, nest A, baseline B, nest B), guarda una captura de `/usage` y registra los valores con:

```bash
bash scripts/registrar-corrida.sh <nombre> <tokens> <costo_usd> <pct_subagentes> <segundos> <calidad_0a5>
```

El script genera un archivo Markdown por corrida aquí. Esos cuatro archivos son el plan B de clase si alguien no logra completar el setup.
