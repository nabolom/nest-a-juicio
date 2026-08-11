# Nest a juicio

**Ejercicio final de la Sesión 5 — Productividad con Claude (IA) AVANZADO.**

Aquí no asumimos que “más agentes” es mejor. Vas a resolver dos tareas con la misma configuración y el mismo corpus: una vez con un solo agente y otra con un líder que delega en seis subagentes. Después usarás `/usage`, un cronómetro y una rúbrica para emitir el veredicto.

> La única variable que cambia entre cada par de corridas es **delegación a subagentes: sí o no**.

## Qué contiene

| Ruta | Contenido |
|---|---|
| `tareas/` | Tarea A (fuentes independientes) y Tarea B (dependencias secuenciales) |
| `fuentes/` | Corpus fijo, sintético y autocontenido para que las corridas sean comparables |
| `.claude/agents/` | Seis subagentes de lectura, uno por fuente |
| `rubricas/` | Cinco criterios comunes de calidad por tarea |
| `tarjetas/` | Plantilla para emitir los veredictos A y B |
| `trazas/` | Plantillas para registrar las cuatro capturas de `/usage` del ensayo del facilitador |
| `scripts/` | Verificación de integridad y registro manual de las corridas |

## Antes de la sesión

```bash
git clone https://github.com/nabolom/nest-a-juicio.git
cd nest-a-juicio
bash scripts/verificar-ejercicio.sh
claude --version
```

La prueba de integridad debe terminar en `OK`. Entra una vez con `claude`, escribe `hola`, corre `/usage` y confirma que ves tokens y costo estimado. Si no, resuélvelo antes de clase.

## Corrida 1 y 2 — baseline de un solo agente

Corre cada tarea en una sesión distinta. El flag de terminal niega la herramienta `Agent`; por eso la comparación no depende de que el modelo obedezca una instrucción de “no delegar”.

```bash
claude --disallowedTools Agent
```

Dentro de Claude Code, corre `/clear`, abre la tarea correspondiente en `tareas/`, pega su contenido literal y ejecuta. Inicia un cronómetro al enviar la tarea. Cuando termine, corre `/usage`, aplica la rúbrica y registra la corrida:

```bash
bash scripts/registrar-corrida.sh baseline-a <tokens> <costo_usd> <pct_subagentes> <segundos> <calidad_0a5>
bash scripts/registrar-corrida.sh baseline-b <tokens> <costo_usd> <pct_subagentes> <segundos> <calidad_0a5>
```

El porcentaje atribuido a subagentes debe ser aproximadamente 0%. Si no lo es, no compares: confirma que abriste la sesión con el flag correcto.

## Corrida 3 y 4 — nest con seis subagentes

Abre una sesión normal:

```bash
claude
```

Corre `/clear`. Copia la Tarea A o B y agrega al final:

```text
Usa los subagentes fuente-1 a fuente-6: uno por fuente del corpus de esta tarea. Devuélveles una asignación de lectura independiente y sintetiza sus hallazgos usando exactamente el formato de salida pedido.
```

Al terminar, corre `/usage`, aplica la misma rúbrica y registra:

```bash
bash scripts/registrar-corrida.sh nest-a <tokens> <costo_usd> <pct_subagentes> <segundos> <calidad_0a5>
bash scripts/registrar-corrida.sh nest-b <tokens> <costo_usd> <pct_subagentes> <segundos> <calidad_0a5>
```

## Emite el veredicto

Copia la plantilla dos veces y llena una por cada tarea:

```bash
cp tarjetas/PLANTILLA-veredicto.md resultados/veredicto-a.md
cp tarjetas/PLANTILLA-veredicto.md resultados/veredicto-b.md
```

Calcula:

| Métrica | Fórmula |
|---|---|
| N× tokens | `tokens_nest ÷ tokens_baseline` |
| N× costo | `costo_nest ÷ costo_baseline` |
| Δ calidad | `calidad_nest − calidad_baseline` |
| Δ duración | `duración_nest − duración_baseline` |

Tu conclusión debe ser una de tres: **justifica**, **no justifica** o **evidencia insuficiente**.

## Transparencia sobre las trazas

Los archivos en `trazas/` son plantillas de registro, no capturas fabricadas. El facilitador debe ensayar las cuatro corridas autenticadas antes de la sesión y registrar sus valores reales con `scripts/registrar-corrida.sh`. No uses números inventados: una captura real es parte del ejercicio.

## Referencias

- [Claude Code — Manage costs effectively](https://code.claude.com/docs/en/costs)
- [Claude Code — Create custom subagents](https://code.claude.com/docs/en/sub-agents)
- [Claude Code — Agent teams](https://code.claude.com/docs/en/agent-teams)
