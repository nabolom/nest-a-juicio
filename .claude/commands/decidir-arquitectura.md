---
description: Te entrevista sobre Nest y Swarm, contrasta la evidencia y guarda tu decisión arquitectónica.
---

# Decidir arquitectura

Tu objetivo es ayudar al alumno a llegar a una decisión razonada, no elegir por él ni completar una tarjeta con evidencia inventada.

## 1. Lee lo que ya existe

1. Lee `caso/lanzamiento-cobranza-pro.md`.
2. Lee `resultados/conclusion-nest.md` si existe. Si no existe, explica que puede correr el Nest primero, pero permite continuar con la entrevista si quiere razonar a partir de la demo.
3. Lee `resultados/decision-arquitectonica.md` si existe. Si ya contiene respuestas, pregunta si el alumno quiere **revisarla** o **reemplazarla**.

## 2. Entrevista: una pregunta a la vez

Haz estas preguntas en orden, espera una respuesta antes de pasar a la siguiente y reformula en lenguaje claro si el alumno se confunde.

1. **Nest:** “¿Qué viste en la corrida del Nest? Dame una evidencia concreta: una delegación, un reporte o una tensión que el líder resolvió.”
2. **Swarm:** “¿Corriste o viste la demo del Swarm? Si sí, ¿viste teammates, tareas compartidas o un mensaje directo entre pares? Si no, dilo; no lo inventaremos.”
3. **Necesidad de comunicación:** “Para Cobranza Pro, ¿Riesgo, Ventas y Operaciones necesitaban hablarse directamente para llegar al plan, o el líder podía resolverlo con reportes claros? ¿Por qué?”
4. **Lista compartida:** “¿Una lista de tareas compartida habría evitado una confusión real o solo añadido coordinación? Dame el ejemplo del caso.”
5. **Decisión:** “Elige una: un solo agente, Nest o Swarm. ¿Cuál es tu razón principal?”
6. **Condición de cambio:** “¿Qué tendría que cambiar en el caso para que eligieras otra arquitectura?”

No sugieras una respuesta hasta que el alumno haya contestado. Si una respuesta es vaga, pide un ejemplo específico del caso. Si no hay evidencia del Swarm, permite que elija Nest o “evidencia insuficiente para justificar Swarm”; nunca presentes una corrida no observada como hecho.

## 3. Devuelve la decisión y pide confirmación

Resume en máximo seis líneas: evidencia del Nest, evidencia o ausencia de evidencia del Swarm, necesidad de comunicación y decisión sugerida. Pregunta: **“¿Confirmas que guarde esta decisión?”**

No escribas ningún archivo hasta recibir una confirmación explícita.

## 4. Guarda el artefacto

Después de la confirmación, escribe `resultados/decision-arquitectonica.md` con esta estructura:

```markdown
# Decisión arquitectónica — S5

**Fecha:** [fecha actual si está disponible; si no, `no registrada`]

## Caso observado

Cobranza Pro: [resumen de una o dos líneas, basado en el archivo del caso]

## Evidencia del Nest

[Lo que el alumno observó. Si no corrió Nest, escribe `no observada`.]

## Evidencia del Swarm

[Lo que el alumno observó. Si no hubo corrida válida, escribe `no observada; no se usa como evidencia`.]

## Necesidad de comunicación entre pares

[Respuesta y ejemplo concreto del alumno.]

## Decisión

**Arquitectura elegida:** `un solo agente / Nest / Swarm / evidencia insuficiente`

**Justificación:**

1. [razón basada en evidencia]
2. [razón basada en evidencia]
3. [razón basada en evidencia]

## Qué tendría que cambiar para elegir otra arquitectura

[Respuesta del alumno.]
```

Luego responde exactamente:

```text
DECISIÓN GUARDADA: resultados/decision-arquitectonica.md
```

Recuérdale que luego puede correr `/cerrar-s5` para crear `resultados/entrega-s5.md`.
