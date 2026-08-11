# Demo de facilitación — Nest vs. Swarm

## Qué demuestras

No buscas que el Swarm produzca “la mejor respuesta”. Muestras una diferencia de comunicación.

| Patrón | Flujo de comunicación | Lo que señalas al grupo |
|---|---|---|
| Nest | Cada especialista reporta al líder. El líder decide y sintetiza. | “Los workers no se hablan; el líder hace toda la recomposición.” |
| Swarm / Agent Team | Los teammates tienen lista compartida y pueden mandarse mensajes directos. | “Aquí Riesgo, Ventas y Operaciones pueden negociar el trade-off sin pasar todo por el líder.” |

## Pasos de la demo

1. Abre una terminal nueva en el repo `nest-a-juicio`.
2. Corre los dos comandos de `PROMPT-SWARM.md`.
3. Pega el prompt y observa el panel de agentes.
4. No avances hasta que veas teammates, una lista de tareas y al menos un mensaje directo entre roles.
5. Pausa antes de la síntesis y pregunta: **“¿Qué información necesitaba viajar de un especialista a otro, no solo al líder?”**
6. Después de la salida, entrega la tarjeta de decisión a los alumnos.

## Plan B honesto si Agent Teams no aparece

Agent Teams es experimental y puede no estar disponible. No simules que funcionó.

Muestra este contraste y continúa con la tarjeta:

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

Di: “El Swarm añade mensajería entre pares y una lista compartida. La pregunta no es si es más impresionante: ¿este caso requería realmente ese intercambio directo?”

El grupo puede decidir Nest aun sin demo: el objetivo es elegir la arquitectura mínima suficiente, no venerar el patrón más complejo.
