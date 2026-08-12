# Runbook de facilitación — Swarm breve con reporte y debrief

> **Objetivo:** que el grupo observe qué añade un Agent Team, vea por qué requiere más coordinación que un Nest y reciba una explicación de Claude sin tener que completar una entrevista larga.

Esta demo viene después de que todos corrieron el Nest. Dura **8–10 minutos**. No mide costo ni usa `/usage`; mide si la comunicación entre pares cambió algo que el líder no podía resolver con reportes claros.

---

## Antes de que entre el grupo — preparación de 5 minutos

Haz una prueba en tu propia máquina:

```bash
git clone https://github.com/nabolom/nest-a-juicio.git
cd nest-a-juicio
bash scripts/empezar.sh
bash scripts/correr-swarm.sh
```

El launcher abre un Swarm breve con tres teammates: Ventas, Riesgo y Operaciones. El líder conserva Producto.

| Check | Debe verse | Si no se ve en 90 segundos |
|---|---|---|
| Teammates | Tres filas: Ventas, Riesgo y Operaciones | Escribe `/exit` y usa el Plan B. |
| Tareas compartidas | Cuatro tareas: tres análisis + síntesis | Pide una vez “crea las cuatro tareas compartidas”; si no, Plan B. |
| Mensajes entre pares | Riesgo → Ventas y respuesta de Ventas | Pide una vez que complete los dos mensajes; si no, Plan B. |
| Reporte | `resultados/reporte-swarm.md` | Pide exactamente “escribe el reporte ahora”; si no ocurre, Plan B. |

> **Regla:** no depures Agent Teams frente al grupo. Si no aparece en 90 segundos, la función experimental pasó a ser parte de la lección, no un problema a resolver en vivo.

Abre antes de iniciar: el [`README`](../README.md), una Terminal con el repo y la carpeta `resultados/`.

---

## Guion hablado y acciones en pantalla

### Minuto 0:00–1:00 — La pregunta

**[En pantalla: los diagramas Nest y Swarm del README]**

**Dices:**

> “El Nest ya nos dio una decisión: cada especialista leyó su parte y le reportó al líder. Ahora no vamos a preguntar si un Swarm se ve más avanzado. Vamos a preguntar si el caso exigía que Riesgo y Ventas se hablaran directamente.”

> “La diferencia es simple: un Nest concentra reportes; un Swarm agrega tareas compartidas y conversación entre pares. Esa capacidad tiene un costo operativo: más sesiones, coordinación y espera.”

### Minuto 1:00–2:00 — Lanza el Swarm

**[En pantalla: Terminal]**

```bash
bash scripts/correr-swarm.sh
```

**Dices mientras abre Claude Code:**

> “El líder se queda con Producto. Solo abrimos tres teammates, con reportes de máximo tres líneas. Hay cuatro tareas y solo dos mensajes obligatorios. Simplificamos la demo para que la arquitectura sea visible sin esperar una investigación larga.”

### Minuto 2:00–4:30 — Señala tres evidencias

**[En pantalla: panel de agentes y lista de tareas]**

| Evidencia | Qué dices |
|---|---|
| Tres teammates | “Cada teammate tiene su propio contexto. Eso es útil si necesitamos perspectivas separadas; también explica por qué toma más tiempo que un Nest.” |
| Tareas compartidas | “Aquí no solo trabajan: pueden ver qué sigue y qué ya se resolvió. Esa es coordinación explícita.” |
| Riesgo → Ventas → respuesta | “Esta es la capacidad que el Nest no tiene de forma directa: Riesgo corrige la promesa de Ventas sin que el líder sea el mensajero.” |

Pregunta al grupo:

> “¿Esta conversación cambió la solución, o el líder del Nest podía obtener ambos reportes y llegar al mismo piloto cerrado?”

No aceptes “Swarm gana” como respuesta. Busca: *depende de si esa negociación directa modifica la decisión o reduce un riesgo real*.

### Minuto 4:30–5:30 — Exige y muestra el reporte

**[En pantalla: `resultados/reporte-swarm.md`]**

**Dices:**

> “El experimento no termina en una conversación. Termina en un artefacto. Este reporte deja evidencia de qué roles participaron, qué mensajes ocurrieron, qué decisión tomaron y si la coordinación cambió algo frente al Nest.”

Si el archivo no aparece, escribe una vez:

```text
Escribe ahora resultados/reporte-swarm.md con las secciones que pide el prompt y confirma que lo guardaste.
```

Si sigue sin aparecer, no esperes: pasa al Plan B.

### Minuto 5:30–6:30 — Deja que Claude haga el diagnóstico

**[En pantalla: Terminal]**

```bash
claude
```

Luego:

```text
/explicar-swarm
```

**Dices:**

> “No les voy a pedir que llenen una entrevista larga. Claude lee el Nest, el reporte Swarm si existe y el caso. Nos explica qué pasó, por qué el Swarm tardó más y si esa comunicación adicional justificó la arquitectura.”

Muestra `resultados/debrief-swarm.md`. Lee en voz alta solamente el diagnóstico de arquitectura.

### Minuto 6:30–8:30 — Alumnos

Diles:

> “Corran el Swarm. Si aparecen tres teammates, cuatro tareas, dos mensajes y el reporte, corran `/explicar-swarm`. Si no aparecen teammates en 90 segundos, escriban `/exit` y corran `/explicar-swarm` de todos modos: Claude explicará que no hay evidencia de un Swarm válido y usará el Nest como contraste.”

Comandos del alumno:

```bash
bash scripts/correr-swarm.sh
```

Después:

```bash
claude
```

```text
/explicar-swarm
/cerrar-s5
```

---

## Plan B honesto

Di esto:

> “Agent Teams es experimental y no formó un equipo en esta máquina. No vamos a fingir una corrida. Sí podemos explicar qué habríamos agregado: teammates, tareas compartidas y mensajes entre pares. La ausencia también revela riesgo operativo.”

Muestra:

```text
NEST                              SWARM
Ventas ───┐                       Riesgo ──mensaje──> Ventas
Riesgo ───┼──> líder ──> plan               \ tareas compartidas /
Operación ┘                         Operaciones ──> líder ──> plan
```

Luego corre `/explicar-swarm`. El archivo debe declarar: **“No hay evidencia de un Swarm válido en esta corrida.”** Eso es una conclusión honesta, no una falla pedagógica.

---

## Cierre de 45 segundos

> “El Nest ya añadió especialización con una síntesis clara. El Swarm añadió coordinación horizontal. Si esa coordinación no cambió el plan, el Nest era suficiente. Si los roles necesitan negociar, corregirse y ver tareas compartidas, el Swarm puede ganar su derecho a existir. La arquitectura correcta es la mínima que resuelve la comunicación que el caso exige.”

## Referencia técnica

Agent Teams se habilita con `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`, es experimental y usa teammates con sesiones propias, lista de tareas compartida y mensajería directa. Los subagentes de un Nest solo reportan al líder. Fuente: [Claude Code — Agent teams](https://code.claude.com/docs/en/agent-teams)
