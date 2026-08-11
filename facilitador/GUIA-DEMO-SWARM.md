# Runbook de facilitación — Demo Swarm para la S5

> **Objetivo de la demo:** que el grupo vea una diferencia observable entre patrones de comunicación. No demuestres que el Swarm “gana”; demuestra qué capacidad agrega y pregunta si el caso realmente la necesita.

Esta guía asume que los alumnos ya leyeron el caso de Cobranza Pro y corrieron el Nest. La demo dura **12–15 minutos**. Al final, los alumnos ejecutan el Swarm en su propio repo si Agent Teams aparece; si no, completan la tarjeta con el contraste visual y el transcript del Nest.

---

## Antes de que entre el grupo — preparación de 10 minutos

Haz esta prueba en tu propia máquina, no frente al grupo por primera vez:

```bash
git clone https://github.com/nabolom/nest-a-juicio.git
cd nest-a-juicio
bash scripts/empezar.sh
bash scripts/correr-swarm.sh
```

La última línea activa `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` y abre Claude Code con el caso y el prompt ya cargados. No copies el prompt manualmente; el launcher mantiene consistente la experiencia de todos.

Antes de empezar, confirma tres cosas en pantalla:

| Check | Debe verse | Si no se ve |
|---|---|---|
| Teammates | Filas para los compañeros de Producto, Ventas, Riesgo y Operaciones en el panel de agentes. | Espera 30 segundos; si no aparecen, pasa al Plan B. |
| Lista compartida | Tareas de las cuatro perspectivas más síntesis. | Pide explícitamente: “Crea la lista compartida ahora”. Si no responde, Plan B. |
| Comunicación entre pares | Un mensaje entre Riesgo y Ventas, seguido de una respuesta de Operaciones. | Pide el mensaje de nuevo una vez. Si no aparece, Plan B. |

> **Regla de oro:** no esperes más de 90 segundos por una función experimental. Tu trabajo es facilitar un aprendizaje, no depurar software en vivo.

Abre antes de la clase estas tres pestañas o ventanas:

1. El [`README del ejercicio`](../README.md), en la sección de los dos diagramas.
2. Una terminal en el repo, lista para `bash scripts/correr-swarm.sh`.
3. La [`tarjeta de decisión arquitectónica`](../tarjetas/DECISION-ARQUITECTURA.md).

---

## El guion hablado y las acciones en pantalla

### Minuto 0:00–1:30 — Nombra la pregunta

**[En pantalla: README, diagramas Nest y Swarm]**

**Dices:**

> “Acabamos de ver un Nest. Cuatro especialistas investigan su área y le reportan a un líder. Eso ya es multiagente. La pregunta no es si podemos agregar más agentes; la pregunta es qué problema requiere que los agentes se hablen directamente, no solo que le reporten al líder.”

> “Ahora voy a correr exactamente el mismo caso como Swarm. Aquí el cambio no es el modelo ni la información. El cambio es la topología: hay tareas compartidas y mensajes directos entre especialistas.”

**Pregunta al grupo:**

> “Antes de verlo: ¿qué conversación creen que Ventas, Riesgo y Operaciones necesitarían tener entre ellos?”

**Escucha una o dos respuestas.** No las confirmes todavía.

---

### Minuto 1:30–2:30 — Inicia el Swarm

**[En pantalla: Terminal]**

Ejecuta:

```bash
bash scripts/correr-swarm.sh
```

**Dices mientras abre Claude Code:**

> “No estoy escribiendo un prompt para que parezca Swarm. El script activa Agent Teams y le exige al sistema crear cuatro teammates, una lista compartida y una conversación explícita entre pares.”

> “En el Nest, Producto, Ventas, Riesgo y Operaciones eran lectores que reportaban. En el Swarm cada uno tiene una sesión propia y puede recibir un mensaje de otro especialista.”

**Checkpoint a los 30 segundos:** busca el panel de agentes.

| Si ves | Dices |
|---|---|
| Cuatro teammates | “Ya tenemos cuatro contextos independientes. Ahora veamos si realmente necesitan coordinarse.” |
| Solo subagentes o ningún teammate | “Esto no es todavía un Swarm válido. No vamos a fingir que el patrón apareció.” Pasa al Plan B en el minuto 3:00. |

---

### Minuto 2:30–5:30 — Haz visible la diferencia

**[En pantalla: panel de teammates y lista de tareas]**

No narres todo lo que lee cada agente. Señala solo tres evidencias.

| Evidencia que muestras | Qué dices | Qué debe aprender el grupo |
|---|---|---|
| Cuatro tareas de perspectiva | “En un Swarm no solo hay agentes: hay trabajo coordinado. Cada compañero sabe qué está pendiente y qué ya se completó.” | La lista compartida sirve para coordinar dependencias, no para decorar la interfaz. |
| Mensaje Riesgo → Ventas | “Este es el punto de la demo: Riesgo no solo reporta al líder. Le dice directamente a Ventas qué promesa no puede cumplir.” | El Swarm agrega comunicación horizontal. |
| Respuesta de Operaciones | “Operaciones entra a la conversación para probar si la alternativa cabe en capacidad real.” | Un tercer rol puede resolver el trade-off sin pasar toda la negociación por el líder. |

**Pausa y pregunta:**

> “¿El líder del Nest habría podido recibir estos tres reportes y tomar la misma decisión? ¿Qué se perdió —o se ganó— al permitir este intercambio directo?”

Busca una respuesta equilibrada: el Nest **podría** ser suficiente; el Swarm solo se justifica si esa negociación entre pares cambia la calidad, velocidad o seguridad de la decisión.

---

### Minuto 5:30–7:00 — Observa la síntesis sin venderla

**[En pantalla: salida final]**

**Dices:**

> “No evalúen esta respuesta por si suena más elegante. Evalúen si la conversación entre especialistas produjo una condición o un plan que un líder no habría podido construir con reportes claros.”

> “En un caso de lanzamiento como este, es posible que el Nest baste. Eso no hace inútil al Swarm. Solo dice que el Swarm tiene que ganar su derecho a existir.”

No califiques la respuesta como “mejor” ni uses `/usage`. El ejercicio no mide costo: mide **necesidad de comunicación**.

---

### Minuto 7:00–9:00 — Lanza la tarjeta de decisión

**[En pantalla: `tarjetas/DECISION-ARQUITECTURA.md`]**

**Dices:**

> “Ahora no me digan cuál les gustó. Digan qué arquitectura elegirían y por qué. La tarjeta les obliga a responder cuatro preguntas: ¿los roles podían trabajar solos?, ¿necesitaban hablarse?, ¿el líder podía resolver las tensiones con reportes?, ¿una lista compartida cambió algo?”

> “Pueden elegir un solo agente, Nest o Swarm. La respuesta de mayor nivel no es la más compleja; es la que necesita menos coordinación para lograr el resultado correcto.”

---

### Minuto 9:00–12:00 — Deja que los alumnos ejecuten el Swarm

**Dices:**

> “Ahora ustedes pueden correr el mismo Swarm. Si Agent Teams aparece, observen las mismas tres señales: teammates, tareas compartidas y mensajes entre pares. Si no aparece en 90 segundos, no se atoren: completen la tarjeta con el Nest que ya corrieron y con esta demo.”

Los alumnos ejecutan:

```bash
bash scripts/correr-swarm.sh
```

Circula con este diagnóstico rápido:

| Situación del alumno | Indicación exacta |
|---|---|
| Ve cuatro teammates | “Excelente. Busca el mensaje Riesgo → Ventas antes de mirar la respuesta final.” |
| Ve la respuesta pero no teammates | “Escribe `/exit`; esa no fue una corrida Swarm. Usa el Plan B y sigue con la tarjeta.” |
| El launcher muestra error de autenticación | “Corre `claude auth login`, vuelve a `bash scripts/empezar.sh` y luego al launcher.” |
| El launcher no encuentra Claude | “No gastes tiempo de taller. Usa la demo y completa la tarjeta; arreglamos setup al final.” |

---

## Plan B honesto — cuando Agent Teams no aparece

Di esto, sin pedir disculpas excesivas:

> “Agent Teams es experimental y no apareció en esta máquina. Eso también es una señal de arquitectura: una dependencia experimental agrega riesgo operativo. No vamos a fabricar una corrida. Usemos el contraste estructural y decidamos si este caso necesitaba la capacidad adicional.”

Muestra:

```text
NEST
producto ─────┐
ventas ───────┼──> líder ──> decisión
riesgo ───────┤
operaciones ──┘

SWARM
producto <──> ventas
   ▲             ▲
   │             │
riesgo <──> operaciones
   \______ líder ______/
```

Luego guía la tarjeta con preguntas concretas:

1. “¿Qué le habría dicho Riesgo directamente a Ventas?”
2. “¿Operaciones necesitaba conocer la respuesta de Ventas antes de opinar?”
3. “¿Podía el líder obtener ambos reportes y resolver el plan sin intercambio directo?”

El objetivo permanece: elegir la arquitectura mínima suficiente.

---

## Cierre de 60 segundos

**Dices:**

> “Un Nest añade especialización y un punto claro de síntesis. Un Swarm añade conversación entre pares y coordinación compartida. No existe una arquitectura ganadora en abstracto. Existe una pregunta: ¿qué información necesita viajar, entre quiénes y para qué?”

> “Cuando la respuesta es ‘todos le reportan a un líder’, usa Nest. Cuando la respuesta es ‘los roles tienen que negociar y corregirse entre ellos’, considera Swarm. Y cuando la respuesta es ‘una persona puede resolverlo’, no agregues agentes.”

## Referencia técnica

- Agent Teams se habilita con `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` y es experimental.
- Los teammates tienen sesiones propias, lista de tareas compartida y comunicación directa; los subagentes normales solo reportan al líder.

Fuente: [Claude Code — Agent teams](https://code.claude.com/docs/en/agent-teams)
