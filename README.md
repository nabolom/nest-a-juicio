# Nest a juicio — ejercicio ejecutable S5

> **No copies prompts. No adivines cómo usar los agentes. Ejecuta los scripts en orden.**

Este repo compara el mismo trabajo con un solo agente y con un líder que **debe** coordinar seis subagentes. El resultado no es “qué respuesta se ve mejor”: es una comparación de tokens, costo estimado, duración y calidad bajo la misma rúbrica.

## Paso 1 — Clona y valida

```bash
git clone https://github.com/nabolom/nest-a-juicio.git
cd nest-a-juicio
bash scripts/empezar.sh
```

Si el último comando no responde `OK`, no sigas: te dice exactamente qué falta. Debes tener Claude Code instalado e iniciar sesión con `claude auth login` si la validación lo pide.

## Paso 2 — Corre las cuatro sesiones

Ejecuta **una por una** desde la terminal. Cada script abre Claude Code con la tarea ya cargada.

| # | Qué copias en la terminal | Qué debe pasar |
|---|---|---|
| 1 | `bash scripts/correr-baseline-a.sh` | Claude resuelve A solo; no hay delegaciones |
| 2 | `bash scripts/correr-nest-a.sh` | Claude usa `nest-coordinador`, delega a seis fuentes y muestra `NEST COMPLETADO: 6/6 fuentes recibidas.` |
| 3 | `bash scripts/correr-baseline-b.sh` | Claude resuelve B solo; no hay delegaciones |
| 4 | `bash scripts/correr-nest-b.sh` | Claude usa seis fuentes y muestra el cierre del nest |

> **En cada corrida:** cuando Claude termine, escribe `/usage`, toma una captura y luego escribe `/exit` para volver a la terminal.

Si una corrida nest no muestra seis delegaciones en el transcript **y** la línea `NEST COMPLETADO: 6/6 fuentes recibidas.`, no es válida. Ciérrala y vuelve a correr el script correspondiente.

## Paso 3 — Registra los números

Después de cada `/usage`, copia los números que ves. Reemplaza los valores entre `< >`:

```bash
bash scripts/registrar-corrida.sh baseline-a <tokens> <costo_usd> <pct_subagentes> <segundos> <calidad_0a5>
bash scripts/registrar-corrida.sh nest-a     <tokens> <costo_usd> <pct_subagentes> <segundos> <calidad_0a5>
bash scripts/registrar-corrida.sh baseline-b <tokens> <costo_usd> <pct_subagentes> <segundos> <calidad_0a5>
bash scripts/registrar-corrida.sh nest-b     <tokens> <costo_usd> <pct_subagentes> <segundos> <calidad_0a5>
```

La calidad se obtiene al aplicar [`rubricas/rubrica-a.md`](rubricas/rubrica-a.md) o [`rubricas/rubrica-b.md`](rubricas/rubrica-b.md). Es 1 punto por check: máximo 5.

## Paso 4 — Emite tus dos veredictos

```bash
cp tarjetas/PLANTILLA-veredicto.md resultados/veredicto-a.md
cp tarjetas/PLANTILLA-veredicto.md resultados/veredicto-b.md
```

Llena cada tarjeta con sus dos corridas. Tu respuesta puede ser **justifica**, **no justifica** o **evidencia insuficiente**. Un nest que pierde es evidencia útil: no lo maquilles.

## Qué hay dentro

| Ruta | Para qué sirve |
|---|---|
| `scripts/` | El camino ejecutable; empieza en `empezar.sh` |
| `.claude/agents/` | `nest-coordinador` + seis lectores especializados |
| `tareas/` | Las dos tareas que los scripts ya cargan por ti |
| `fuentes/` | Corpus fijo; no uses web ni archivos externos |
| `rubricas/` | La definición objetiva de calidad |
| `trazas/` | Tus registros y capturas de `/usage` |
| `tarjetas/` | Tus dos conclusiones finales |

## La regla experimental

La única variable entre baseline y nest es la delegación a subagentes. El baseline abre Claude Code con `--disallowedTools Agent`. El nest abre el agente principal `nest-coordinador`, que debe invocar `fuente-1` a `fuente-6` y esperar sus resultados antes de responder.

## Si te atoraste

| Lo que ves | Qué haces |
|---|---|
| `claude: command not found` | Instala Claude Code y abre una terminal nueva |
| Error de autenticación | Corre `claude auth login` y después `bash scripts/empezar.sh` |
| No veo seis delegaciones | Cierra con `/exit` y repite el script nest; no copies un prompt suelto |
| No entiendo un número de `/usage` | Toma captura y sigue al siguiente paso; lo leeremos en el debrief |

## Referencias

- [Claude Code CLI reference](https://code.claude.com/docs/en/cli-reference)
- [Custom subagents](https://code.claude.com/docs/en/sub-agents)
- [Cost and usage](https://code.claude.com/docs/en/costs)
