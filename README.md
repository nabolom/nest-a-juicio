# Nest vs. Swarm — ejercicio final S5

> **No vas a medir la factura de Claude. Vas a observar qué comunicación necesita el problema para elegir la arquitectura mínima suficiente.**

En este ejercicio todos ejecutan un **Nest** y después observan una demostración de **Swarm** dirigida por el facilitador. Al final no entregas una tabla de tokens: entregas una decisión arquitectónica defendible.

---

## 1. Primero: el caso

Horizonte quiere lanzar **Cobranza Pro** el 15 de octubre. Producto dice que el sistema está listo, Ventas tiene 40 clientes interesados, Riesgo prohíbe activación automática para 12 clientes regulados y Operaciones solo puede completar 15 inscripciones manuales en una semana.

Lee el caso completo antes de hacer nada:

```bash
cat caso/lanzamiento-cobranza-pro.md
```

Tu tarea será decidir si Horizonte debe lanzar, hacer un piloto cerrado o posponer; también tendrás que proponer un plan de 72 horas.

---

## 2. Después: dos formas de organizar el mismo trabajo

| Patrón | Qué sucede | Úsalo cuando… |
|---|---|---|
| **Nest** | Cuatro especialistas reportan a un líder. El líder decide y sintetiza. Los especialistas no se hablan. | El líder puede recomponer la información con reportes claros. |
| **Swarm** | Los agentes tienen una lista de tareas compartida y pueden enviarse mensajes directos. | Los especialistas necesitan negociar, desafiarse o coordinar entre sí. |

```text
NEST                              SWARM
producto ─────┐                   producto <──> ventas
ventas ───────┼──> líder          riesgo   <──> operaciones
riesgo ───────┤       │              \_______ líder _______/
operaciones ──┘       └──> decisión
```

La pregunta no es cuál se ve más avanzado. La pregunta es: **¿en este caso los especialistas necesitan hablarse entre sí, o basta con que reporten a un líder?**

---

## 3. Ahora sí: tu predicción

Con el caso y los patrones ya claros, escribe una frase:

> “Para Cobranza Pro elegiría [Nest / Swarm] porque los especialistas [sí / no] necesitan comunicarse directamente para resolver las tensiones entre Ventas, Riesgo y Operaciones.”

No hay respuesta esperada. Vas a contrastar esta hipótesis después de observar ambos patrones.

---

## 4. Ejecuta el Nest — todos los alumnos

Valida el entorno:

```bash
bash scripts/empezar.sh
```

Después ejecuta el Nest:

```bash
bash scripts/correr-nest.sh
```

**Qué ocurrirá:** el coordinador abre cuatro subagentes —Producto, Ventas, Riesgo y Operaciones—. Cada uno reporta su lectura al líder. El líder integra todo en una decisión y un plan de 72 horas.

**Qué debes mirar:** cuatro delegaciones en el transcript y la línea final:

```text
NEST COMPLETADO: 4/4 reportes recibidos.
```

No uses `/usage` y no calcules costos. Guarda una captura del transcript y escribe `/exit` al terminar.

---

## 5. Observa el Swarm — demo del facilitador

Tu facilitador mostrará el mismo caso como un **Agent Team**. Ahí no solo hay reportes al líder: Riesgo, Ventas y Operaciones pueden intercambiar mensajes, usar una lista de tareas común y ajustar un trade-off entre pares.

Observa tres cosas:

1. ¿Qué información viaja directamente de un especialista a otro?
2. ¿Ese intercambio cambia algo que el líder no habría podido resolver con cuatro reportes?
3. ¿La lista de tareas compartida evita una confusión real o solo añade coordinación?

Agent Teams es experimental y puede no estar disponible. Si falla la demo, tu facilitador usará el diagrama y la guía de respaldo en [`facilitador/GUIA-DEMO-SWARM.md`](facilitador/GUIA-DEMO-SWARM.md). No se simulan resultados.

---

## 6. Entrega tu decisión arquitectónica

Copia la tarjeta y complétala con evidencia del Nest y de la demo Swarm:

```bash
cp tarjetas/DECISION-ARQUITECTURA.md mi-decision-arquitectonica.md
```

Tu decisión puede ser **un solo agente**, **Nest** o **Swarm**. La elección correcta no es la más compleja; es la mínima que permite que la información circule como el caso lo necesita.

> Si concluyes que el Nest basta, esa es una excelente respuesta. Acabas de evitar complejidad innecesaria.

---

## Para el facilitador

- [Prompt exacto para la demo Swarm](facilitador/PROMPT-SWARM.md)
- [Guía de demo y plan B honesto](facilitador/GUIA-DEMO-SWARM.md)

## Si te atoras

| Problema | Qué haces |
|---|---|
| `claude: command not found` | Instala Claude Code, abre una terminal nueva y corre otra vez `bash scripts/empezar.sh`. |
| Error de autenticación | Ejecuta `claude auth login` y vuelve a empezar. |
| No aparecen cuatro delegaciones | Escribe `/exit` y repite `bash scripts/correr-nest.sh`. |
| No entiendes la diferencia Nest/Swarm | Relee los diagramas y pregunta: “¿quién necesita hablar con quién?”. |

## Referencias

- [Claude Code: custom subagents](https://code.claude.com/docs/en/sub-agents)
- [Claude Code: agent teams](https://code.claude.com/docs/en/agent-teams)
