# Nest a juicio — ejercicio final de la S5

> **La pregunta no es “¿puedo usar seis agentes?”. La pregunta es “¿qué ganó este diseño que justifique seis agentes?”.**

En la S1 diseñaste antes de automatizar. En la S2 mediste antes de confiar. Ahora aplicarás la misma disciplina a la arquitectura: un sistema con subagentes no se adopta porque se ve avanzado; se compara con una alternativa simple y se juzga con evidencia.

Este repo es un experimento controlado. Primero conocerás los dos casos. Luego verás las dos arquitecturas que los resolverán. **Solo después** harás una predicción. Finalmente correrás el experimento y confrontarás tu intuición con los datos.

---

## Parte 0 — Conoce los dos casos antes de predecir

No ejecutes nada todavía. Lee estos dos escenarios; son la situación sobre la que vas a formar una hipótesis.

| Caso | Situación de negocio | Tipo de información | Lo que debe decidir el sistema |
|---|---|---|---|
| **A — Lanzamiento de Cobranza Pro** | Horizonte debe decidir si lanza un nuevo módulo el 15 de octubre. | Seis notas independientes de producto, ventas, soporte, finanzas, legal y operaciones. | Lanzar, lanzar con condiciones o posponer; además, identificar evidencia, riesgos y condiciones. |
| **B — Factura con OC faltante** | Debes decidir qué hacer con una factura de $54,500 con una orden de compra que no aparece. | Seis reglas que forman una cadena: factura → política de OC → resultado disponible → umbral → escalamiento → restricción de operación. | Aprobar, rechazar o escalar; además, justificar cada eslabón y producir una acción operativa. |

Puedes abrir los contratos completos si quieres ver el formato de salida:

- [`tareas/tarea-a-paralela.md`](tareas/tarea-a-paralela.md)
- [`tareas/tarea-b-secuencial.md`](tareas/tarea-b-secuencial.md)

> **La diferencia importante:** en A, cada fuente puede leerse sin esperar a las otras. En B, cada regla cambia cómo entiendes la siguiente. No estamos afirmando que una arquitectura ganará; estamos identificando una diferencia estructural que vale la pena poner a prueba.

---

## Parte 1 — Entiende qué va a ejecutar cada arquitectura

No compararás “Claude contra seis Claudes”. Compararás dos formas de organizar el mismo trabajo.

### Arquitectura 1: un solo agente — el baseline

```text
                ┌──────────────────────────────────┐
                │          UN SOLO AGENTE           │
                │ lee A1…A6 (o B1…B6), decide y     │
                │ entrega la respuesta final        │
                └──────────────────────────────────┘
```

El agente único recibe todo el corpus en el mismo contexto. Para el ejercicio, Claude Code abre con la herramienta `Agent` bloqueada: no puede delegar aunque quisiera hacerlo.

**Qué pregunta responde el baseline:** “¿Qué calidad, tiempo y consumo necesito si no agrego coordinación?” Sin esta línea base, un nest no puede demostrar valor; solo puede mostrar que gastó más.

### Arquitectura 2: líder + seis lectores — el nest

```text
                         ┌──────────────────────┐
                         │  nest-coordinador    │
                         └──────────┬───────────┘
            ┌───────────┬───────────┼───────────┬───────────┬───────────┐
            ▼           ▼           ▼           ▼           ▼           ▼
       fuente-1    fuente-2    fuente-3    fuente-4    fuente-5    fuente-6
       lee una      lee una     lee una      lee una     lee una      lee una
       fuente       fuente      fuente       fuente      fuente       fuente
            └───────────┴───────────┴───────────┴───────────┴───────────┘
                                      ▼
                         ┌──────────────────────┐
                         │ líder recibe seis    │
                         │ hallazgos y sintetiza│
                         └──────────────────────┘
```

El líder no debería leer y resolver todo por sí solo. Debe delegar una fuente a cada lector, esperar los seis resultados y sintetizar después. El archivo [`.claude/agents/nest-coordinador.md`](.claude/agents/nest-coordinador.md) impone ese comportamiento; los seis archivos `fuente-*` delimitan el trabajo de cada lector.

**Qué pregunta responde el nest:** “¿La distribución de lectura y la posterior síntesis compran suficiente cobertura o velocidad para justificar tokens y coordinación adicionales?”

| Mantienes fijo | Cambias |
|---|---|
| Caso, corpus, formato de salida, modelo del líder, rúbrica y herramientas externas | Solo la posibilidad de delegar a subagentes |

> Si cambias fuentes, modelo, tarea o rúbrica entre dos corridas, ya no sabrás qué causó la diferencia.

---

## Parte 2 — Ahora sí: escribe una predicción informada

Con el contexto de A/B y de ambas arquitecturas, escribe dos frases en una nota o al inicio de tus tarjetas:

1. **A:** “Dado que las seis notas son independientes, creo que el nest [sí/no] justificará su costo porque…”
2. **B:** “Dado que las seis reglas forman una cadena, creo que el nest [sí/no] justificará su costo porque…”

No estás adivinando una respuesta correcta. Estás declarando una hipótesis que los datos podrán confirmar, contradecir o dejar sin resolver.

---

## Parte 3 — Valida el entorno

Ahora sí prepara tu terminal:

```bash
git clone https://github.com/nabolom/nest-a-juicio.git
cd nest-a-juicio
bash scripts/empezar.sh
```

**Qué ejecuta:** verifica instalación, autenticación y archivos del ejercicio.

**Por qué lo haces ahora:** un error de setup no es evidencia sobre multiagente. Lo sacamos del experimento antes de correr las cuatro comparaciones.

**Qué debe pasar:** debe aparecer `OK` y una lista de los cuatro scripts. Si te pide iniciar sesión, corre `claude auth login` y vuelve a lanzar `bash scripts/empezar.sh`.

---

## Parte 4 — Corre el experimento, por pares

No corras las cuatro sesiones de memoria ni interpretes al vuelo. Ejecuta cada par completo y toma evidencia antes de pasar al siguiente caso.

### Par A — ¿la paralelización de fuentes independientes compra valor?

| Orden | Ejecutas en la terminal | Qué estás probando | Qué debe ocurrir |
|---|---|---|---|
| A1 | `bash scripts/correr-baseline-a.sh` | La referencia: qué tan bien puede un agente único leer las seis notas y producir el brief. | No hay delegaciones. |
| A2 | `bash scripts/correr-nest-a.sh` | Si seis lectores especializados mejoran cobertura o duración frente a esa referencia. | Seis delegaciones y `NEST COMPLETADO: 6/6 fuentes recibidas.` |

### Par B — ¿la paralelización de una cadena agrega valor o fricción?

| Orden | Ejecutas en la terminal | Qué estás probando | Qué debe ocurrir |
|---|---|---|---|
| B1 | `bash scripts/correr-baseline-b.sh` | La referencia: un agente único conserva la cadena completa en un solo contexto. | No hay delegaciones. |
| B2 | `bash scripts/correr-nest-b.sh` | Si repartir una cadena de reglas mejora algo suficiente para compensar que el líder tenga que recomponerla. | Seis delegaciones y `NEST COMPLETADO: 6/6 fuentes recibidas.` |

El baseline inicia Claude Code con `--disallowedTools Agent`, así que la ausencia de delegación es una condición técnica, no una promesa. El nest inicia `nest-coordinador`, que debe llamar a `fuente-1` hasta `fuente-6`. [1] [2]

> **Una corrida nest inválida** no prueba nada. Si no ves las seis delegaciones y la línea exacta `NEST COMPLETADO: 6/6 fuentes recibidas.`, escribe `/exit` y repite el mismo script. No agregues un prompt extra: cambiarías el experimento.

---

## Parte 5 — Después de cada corrida: captura evidencia antes de opinar

Cuando Claude entregue su respuesta, pero antes de salir:

1. Escribe `/usage` dentro de Claude Code y toma una captura.
2. Detén tu cronómetro.
3. Aplica la rúbrica correcta: [`A`](rubricas/rubrica-a.md) o [`B`](rubricas/rubrica-b.md). Son cinco checks verificables; no califiques por gusto.
4. Escribe `/exit`.
5. Registra los seis datos que obtuviste:

```bash
bash scripts/registrar-corrida.sh baseline-a <tokens> <costo_usd> <pct_subagentes> <segundos> <calidad_0a5>
bash scripts/registrar-corrida.sh nest-a     <tokens> <costo_usd> <pct_subagentes> <segundos> <calidad_0a5>
bash scripts/registrar-corrida.sh baseline-b <tokens> <costo_usd> <pct_subagentes> <segundos> <calidad_0a5>
bash scripts/registrar-corrida.sh nest-b     <tokens> <costo_usd> <pct_subagentes> <segundos> <calidad_0a5>
```

| Evidencia | Lo que te permite afirmar |
|---|---|
| Tokens y costo estimado | Cuánto consumo adicional compró el nest. |
| Duración | Si repartir trabajo redujo o agregó tiempo. |
| Calidad 0–5 | Si la respuesta mejoró según una definición fijada antes de verla. |
| % atribuido a subagentes | Qué parte del uso ocurrió fuera del hilo líder. No equivale solo a coordinación. |

`/usage` es un indicador relativo de consumo para comparar la misma configuración; no es una factura ni una traza de cada handoff. [3]

---

## Parte 6 — Emite dos veredictos

Crea tus tarjetas:

```bash
cp tarjetas/PLANTILLA-veredicto.md resultados/veredicto-a.md
cp tarjetas/PLANTILLA-veredicto.md resultados/veredicto-b.md
```

En cada tarjeta calcula:

| Cálculo | Pregunta que responde |
|---|---|
| **N× tokens** = `tokens_nest ÷ tokens_baseline` | ¿Cuánto consumo adicional pagaste? |
| **N× costo** = `costo_nest ÷ costo_baseline` | ¿Cuánto costo estimado adicional pagaste? |
| **Δ duración** = `duración_nest − duración_baseline` | ¿La arquitectura ganó o perdió tiempo? |
| **Δ calidad** = `calidad_nest − calidad_baseline` | ¿La arquitectura mejoró la respuesta verificable? |

Elige una sola conclusión por caso:

| Veredicto | Cuándo aplica |
|---|---|
| **Justifica** | La mejora de calidad o duración compensa el costo adicional para este tipo de tarea. |
| **No justifica** | El nest gastó más y no compró un beneficio proporcional. |
| **Evidencia insuficiente** | Cambiaste una condición, faltan datos o la rúbrica no permite decidir. |

Al final, vuelve a las predicciones que escribiste después de entender el escenario. ¿Qué confirmó o cambió la evidencia? Esa conversación es el debrief.

> Un nest que pierde no es un fracaso. Es una decisión de arquitectura que ya no tendrás que justificar ni pagar en producción.

---

## Si te atoras

| Lo que ves | Qué significa | Qué haces |
|---|---|---|
| `claude: command not found` | Claude Code no está instalado o no quedó en el PATH. | Instálalo, abre una terminal nueva y corre `bash scripts/empezar.sh`. |
| Error de autenticación | No hay una sesión iniciada. | Corre `claude auth login` y vuelve al preflight. |
| No hay seis delegaciones | No ejecutaste un nest válido. | `/exit` y repite el launcher nest. |
| No entiendes `/usage` | Tienes evidencia, pero necesitas ayuda para leerla. | Toma captura; se interpreta durante el debrief. |

## Qué hay dentro

| Ruta | Por qué existe |
|---|---|
| `scripts/` | Abre cada condición experimental sin copiar prompts ni flags a mano. |
| `.claude/agents/` | Hace explícita la división de trabajo entre el líder y seis lectores. |
| `tareas/` | Define los dos escenarios que ambas arquitecturas deben resolver. |
| `fuentes/` | Mantiene fija la información entre corridas. |
| `rubricas/` | Define calidad antes de ver las respuestas. |
| `trazas/` | Guarda evidencia de uso, tiempo y calidad. |
| `tarjetas/` | Convierte mediciones en una decisión defendible. |

## Referencias

- [Claude Code CLI reference](https://code.claude.com/docs/en/cli-reference)
- [Custom subagents](https://code.claude.com/docs/en/sub-agents)
- [Cost and usage](https://code.claude.com/docs/en/costs)
