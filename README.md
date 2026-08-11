# Nest a juicio — ejercicio final de la S5

> **La pregunta no es “¿puedo usar seis agentes?”. La pregunta es “¿qué gané que justifique seis agentes?”.**

Este es el ejercicio que cierra el curso. En S1 diseñaste antes de automatizar. En S2 mediste antes de confiar. En S3 hiciste que el sistema corriera y parara. En S4 pusiste límites y trazabilidad. Ahora aplicas la misma disciplina a la arquitectura: **un nest de subagentes no se adopta por intuición; se compara contra una línea base y se juzga con evidencia.**

No estás haciendo cuatro demos. Estás ejecutando un pequeño experimento controlado.

---

## Qué vas a aprender

Al terminar podrás defender una de estas frases con números, no con gusto personal:

> “Para esta tarea, distribuir el trabajo entre seis subagentes **sí** justificó el costo adicional porque…”

> “Para esta tarea, seis subagentes **no** justificaron el costo adicional porque…”

> “Todavía no puedo decidir porque mi comparación no controló una condición importante.”

Tu entregable final son **dos tarjetas de veredicto**: una para una tarea paralela y otra para una tarea secuencial. El contraste entre ambas es la lección.

---

## El diseño del experimento

En las cuatro corridas se mantienen constantes el corpus, el formato de salida, la rúbrica y el modelo del líder. Solo cambia una variable: **si el líder puede o no delegar a subagentes**.

| Concepto | Qué significa aquí | Por qué importa |
|---|---|---|
| **Baseline** | Un solo agente resuelve la tarea; la herramienta `Agent` está bloqueada. | Es tu línea base. Sin ella no sabes si el nest agregó valor o solo costo. |
| **Nest** | Un líder (`nest-coordinador`) delega una fuente a cada uno de seis lectores y después sintetiza. | Es la arquitectura bajo juicio. |
| **Corpus fijo** | Las seis fuentes ya viven en `fuentes/`; no uses web ni archivos externos. | Las fuentes no cambian entre corridas. Así no atribuyes al nest una diferencia causada por información distinta. |
| **Rúbrica** | Cinco checks verificables por tarea. | Evita calificar “se ve mejor” y obliga a comparar con la misma definición de calidad. |
| **`/usage`** | Tokens, costo estimado y atribución de uso. | Hace visible el costo relativo del diseño. No es una factura ni una traza completa. |

> **Regla experimental:** si cambias el modelo, las fuentes, la tarea, las herramientas o la rúbrica entre baseline y nest, ya no comparas una sola variable. No podrás defender el resultado.

---

## Antes de correr nada: escribe tu predicción

Antes de abrir Claude Code, completa estas dos frases en una nota o al inicio de tus tarjetas:

1. **Tarea A:** “Creo que el nest [sí/no] justificará su costo porque…”
2. **Tarea B:** “Creo que el nest [sí/no] justificará su costo porque…”

No intentes acertar. Esta predicción te obliga a revelar tu intuición antes de ver los números. La brecha entre tu predicción y los datos será parte de tu debrief.

---

## Paso 1 — Preflight: confirma que puedes participar

Primero clona y valida el entorno:

```bash
git clone https://github.com/nabolom/nest-a-juicio.git
cd nest-a-juicio
bash scripts/empezar.sh
```

**Qué ejecuta:** una revisión de instalación, autenticación y estructura del ejercicio.

**Por qué lo ejecutas:** queremos detectar un problema de setup antes de entrar a las cuatro corridas. No pierdas veinte minutos del ejercicio porque tu terminal no encuentra Claude Code o porque no iniciaste sesión.

**Qué debe ocurrir:** debes ver `OK` y una lista de las cuatro corridas. Si no sucede, el mensaje te dirá si falta Claude Code o si debes correr `claude auth login`.

---

## Paso 2 — La Tarea A: fuentes independientes

La Tarea A pide producir un brief de lanzamiento a partir de seis notas independientes: producto, ventas, soporte, finanzas, legal y operaciones. Ninguna fuente necesita el resultado de otra para ser leída.

> **Hipótesis A:** al repartir seis lecturas independientes, el nest podría mejorar cobertura o duración. Pero solo justifica su costo si la rúbrica detecta una mejora suficiente.

### 2A. Corre el baseline A

```bash
bash scripts/correr-baseline-a.sh
```

**Qué ejecuta:** Claude Code abre con la Tarea A ya cargada y con `--disallowedTools Agent`. El agente principal lee y sintetiza por sí solo.

**Por qué empieza aquí:** necesitas saber qué tan bien puede resolver la tarea **sin** arquitectura distribuida. Si el baseline ya obtiene 5/5 rápidamente, el nest tiene una carga de prueba muy alta: debe aportar algo adicional para merecer sus tokens.

**Qué debes observar:** no verás delegaciones. Al terminar, la respuesta debe contener el brief con evidencia por fuente, riesgos y condiciones para lanzar.

### 2B. Corre el nest A

```bash
bash scripts/correr-nest-a.sh
```

**Qué ejecuta:** Claude Code abre con `nest-coordinador`. Ese líder tiene una regla obligatoria: llamar a `fuente-1` hasta `fuente-6`, una por fuente, recibir seis hallazgos y solo entonces sintetizar.

**Por qué existe esta segunda corrida:** ahora pones a prueba la intuición de que la paralelización ayuda cuando las unidades de investigación son independientes.

**Qué debe ocurrir para que sea válida:** debes ver seis delegaciones en el transcript y esta línea final exacta:

```text
NEST COMPLETADO: 6/6 fuentes recibidas.
```

Si falta una delegación o el cierre, la corrida no prueba la arquitectura que queríamos probar. Escribe `/exit` y repite **el mismo script**; no pegues instrucciones adicionales.

### 2C. Captura la evidencia A

Después de cada una de las dos corridas A, antes de salir:

1. Escribe `/usage` dentro de Claude Code.
2. Toma una captura de la salida.
3. Registra cuánto tardó la tarea con tu cronómetro.
4. Aplica [`rubricas/rubrica-a.md`](rubricas/rubrica-a.md): cada check vale un punto, máximo 5.
5. Escribe `/exit` para volver a la terminal.

**Qué estás aprendiendo:** no preguntas “¿cuál respuesta me gustó más?”. Preguntas si los tokens y la coordinación adicionales compraron más cobertura, más calidad o menos tiempo.

---

## Paso 3 — La Tarea B: dependencias secuenciales

La Tarea B decide qué hacer con una factura. Sus seis fuentes no son seis opiniones independientes: forman una cadena de reglas. La política de OC afecta el estado; el estado afecta el umbral; el umbral afecta el escalamiento; y la restricción final determina qué puede hacer el sistema.

> **Hipótesis B:** distribuir una cadena de decisión puede añadir coordinación sin mejorar la respuesta. El nest podría perder contra un solo agente y ese resultado sería valioso.

### 3A. Corre el baseline B

```bash
bash scripts/correr-baseline-b.sh
```

**Qué ejecuta:** un solo agente resuelve la cadena de B1 a B6. La delegación está bloqueada.

**Por qué lo ejecutas:** estableces la calidad y el costo de un agente que puede leer la cadena completa en un solo contexto. Esta es la alternativa real que un nest tendría que superar.

**Qué debes observar:** la respuesta correcta no aprueba ni rechaza definitivamente: debe escalar, nombrar la OC faltante, el umbral y el canal correcto.

### 3B. Corre el nest B

```bash
bash scripts/correr-nest-b.sh
```

**Qué ejecuta:** el mismo `nest-coordinador` distribuye B1–B6 a seis lectores y después intenta recomponer la cadena.

**Por qué lo ejecutas:** no para demostrar que “multiagente funciona”, sino para probar cuándo la arquitectura añade fricción. Una cadena secuencial puede necesitar contexto compartido más que paralelización.

**Qué debe ocurrir para que sea válida:** de nuevo, seis delegaciones y `NEST COMPLETADO: 6/6 fuentes recibidas.`. Después captura `/usage`, cronometra y aplica [`rubricas/rubrica-b.md`](rubricas/rubrica-b.md).

---

## Paso 4 — Registra los cuatro resultados

Ahora que tienes evidencia, conviértela en archivos. Reemplaza los valores entre `< >` con lo que viste en `/usage`, tu cronómetro y la rúbrica.

```bash
bash scripts/registrar-corrida.sh baseline-a <tokens> <costo_usd> <pct_subagentes> <segundos> <calidad_0a5>
bash scripts/registrar-corrida.sh nest-a     <tokens> <costo_usd> <pct_subagentes> <segundos> <calidad_0a5>
bash scripts/registrar-corrida.sh baseline-b <tokens> <costo_usd> <pct_subagentes> <segundos> <calidad_0a5>
bash scripts/registrar-corrida.sh nest-b     <tokens> <costo_usd> <pct_subagentes> <segundos> <calidad_0a5>
```

| Dato | Qué responde | Cómo interpretarlo |
|---|---|---|
| Tokens totales | ¿Cuánto trabajo de modelo consumió cada diseño? | Es la métrica principal de costo relativo. |
| Costo estimado | ¿Cómo se traduce ese consumo a dólares de lista? | Úsalo para comparar dentro de la misma configuración, no como factura. |
| % atribuido a subagentes | ¿Qué porción del uso ocurrió fuera del hilo líder? | Es trabajo distribuido, no solamente “coordinación”. |
| Duración | ¿Qué diseño terminó antes? | La paralelización solo vale si baja tiempo o sube calidad de forma útil. |
| Calidad 0–5 | ¿Cuántos checks objetivamente cumplió? | Es la defensa contra el “me pareció mejor”. |

---

## Paso 5 — Emite el juicio, no un resumen

Crea tus dos tarjetas:

```bash
cp tarjetas/PLANTILLA-veredicto.md resultados/veredicto-a.md
cp tarjetas/PLANTILLA-veredicto.md resultados/veredicto-b.md
```

En cada una calcula:

| Cálculo | Pregunta que responde |
|---|---|
| **N× tokens** = `tokens_nest ÷ tokens_baseline` | ¿Cuánto consumo adicional compró el nest? |
| **N× costo** = `costo_nest ÷ costo_baseline` | ¿Cuánto costo estimado adicional pagaste? |
| **Δ calidad** = `calidad_nest − calidad_baseline` | ¿La arquitectura mejoró la respuesta verificable? |
| **Δ duración** = `duración_nest − duración_baseline` | ¿La arquitectura ganó o perdió tiempo? |

Elige una sola conclusión por tarea:

| Veredicto | Cuándo es defendible |
|---|---|
| **Justifica** | El beneficio de calidad o duración compensa el N× adicional para esta tarea. |
| **No justifica** | El nest costó más y no produjo un beneficio proporcional. |
| **Evidencia insuficiente** | Una condición cambió, faltan datos o no puedes aplicar la rúbrica con honestidad. |

> Un nest que pierde **no es un fracaso del ejercicio**. Es un hallazgo: evitaste meter complejidad donde no compraba valor.

---

## El debrief: compara pares, no las cuatro corridas juntas

1. Compara **baseline A vs. nest A**. ¿Qué compraron las seis lecturas paralelas?
2. Compara **baseline B vs. nest B**. ¿Qué costo introdujo distribuir una cadena de decisión?
3. Vuelve a tus dos predicciones. ¿Qué creías antes de ejecutar y qué te obligan a creer los datos?
4. Termina con una regla para tu propio proyecto: “Usaré subagentes cuando…” o “No usaré subagentes cuando…”.

Esta es la conclusión de la S5 y del curso: **no adoptes una arquitectura porque existe. Diseña la prueba que tendría que ganar para merecer existir.**

---

## Si te atoraste

| Lo que ves | Qué significa | Qué haces |
|---|---|---|
| `claude: command not found` | Claude Code no está instalado o no está en tu PATH. | Instálalo, abre una terminal nueva y repite `bash scripts/empezar.sh`. |
| Error de autenticación | Claude Code no puede iniciar una sesión. | Corre `claude auth login` y repite el preflight. |
| No aparecen seis delegaciones | No ejecutaste una corrida nest válida. | Escribe `/exit` y repite `bash scripts/correr-nest-a.sh` o `...nest-b.sh`. |
| No entiendes `/usage` | Tienes datos, pero aún no sabes interpretarlos. | Toma captura y consérvala para el debrief. |

## Qué hay dentro

| Ruta | Por qué existe |
|---|---|
| `scripts/` | El camino ejecutable; evita que tengas que copiar prompts o flags. |
| `.claude/agents/` | Hace explícita la división de trabajo entre líder y seis lectores. |
| `tareas/` | Define exactamente lo que ambas arquitecturas deben resolver. |
| `fuentes/` | Mantiene fija la información entre corridas. |
| `rubricas/` | Define calidad antes de ver las respuestas. |
| `trazas/` | Guarda la evidencia de uso y duración. |
| `tarjetas/` | Convierte mediciones en una decisión defendible. |

## Referencias

- [Claude Code CLI reference](https://code.claude.com/docs/en/cli-reference)
- [Custom subagents](https://code.claude.com/docs/en/sub-agents)
- [Cost and usage](https://code.claude.com/docs/en/costs)
