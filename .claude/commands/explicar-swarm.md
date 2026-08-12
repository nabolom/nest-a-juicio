---
description: Compara Nest vs. Swarm para Cobranza Pro y explica por qué Nest es la arquitectura mínima suficiente.
---

# Diagnóstico Nest vs. Swarm — Cobranza Pro

Tu papel es explicar el experimento completo a los alumnos. **No entrevistes al alumno, no le pidas completar una tarjeta y no inventes evidencia.** El diagnóstico de esta clase debe responder una pregunta concreta:

> **¿Por qué para Cobranza Pro se elegiría un Nest y no un Swarm?**

## 1. Lee la evidencia disponible

1. `resultados/conclusion-nest.md` — obligatorio. Si no existe, detente y pide correr `bash scripts/correr-nest.sh`.
2. `resultados/reporte-swarm.md` — opcional. Puede no existir si Agent Teams no apareció o la corrida no terminó.
3. `caso/lanzamiento-cobranza-pro.md` — obligatorio, para anclar el diagnóstico a los hechos del caso.

Si no existe `reporte-swarm.md`, continúa: la ausencia de una corrida válida no impide explicar la diferencia estructural entre los patrones. Decláralo como ausencia de evidencia de ejecución, no como evidencia de que Swarm falla siempre.

## 2. Escribe el diagnóstico

Crea `resultados/debrief-swarm.md` con esta estructura exacta:

```markdown
# Diagnóstico de arquitectura — Nest vs. Swarm

## 1. El problema que resolvimos

[Resume la decisión de Cobranza Pro: lanzamiento, piloto cerrado o posposición, y los cuatro hechos relevantes de Producto, Ventas, Riesgo y Operaciones.]

## 2. Qué hizo el Nest

[Explica que los cuatro roles trabajaron sobre perspectivas separadas y reportaron a un líder. Enumera qué aportó cada rol y cómo el líder pudo integrar los reportes en una decisión verificable.]

## 3. Qué habría agregado el Swarm

[Explica que un Swarm agrega teammates con sesiones separadas, tareas compartidas y mensajes directos entre pares. Si existe `reporte-swarm.md`, especifica qué tareas y mensajes se observaron. Si no existe, escribe literalmente: "No hay evidencia de un Swarm válido en esta corrida".]

## 4. Comparación directa

| Pregunta | Nest | Swarm |
|---|---|---|
| ¿Cómo viaja la información? | [reportes al líder] | [tareas compartidas y mensajes entre pares] |
| ¿Qué coordinación extra añade? | [síntesis del líder] | [sesiones, tareas, mensajes y síntesis] |
| ¿Cambió la decisión de Cobranza Pro? | [respuesta basada en evidencia] | [respuesta basada en reporte o evidencia no disponible] |

## 5. Diagnóstico de Claude: para este caso elegimos Nest

**Recomendación:** `Nest`

**Por qué Nest es suficiente:**

1. [Explica que Producto, Ventas, Riesgo y Operaciones aportan hechos que pueden investigarse por separado.]
2. [Explica que Riesgo establece una restricción no negociable —los 12 clientes regulados no se activan automáticamente— y el líder puede combinar esa restricción con la capacidad de 15 inscripciones y la promesa comercial sin una negociación iterativa entre peers.]
3. [Explica que la salida buscada es una decisión única y un plan de 72 horas; un líder con reportes claros puede producirla y verificarla.]

## 6. Por qué no elegimos Swarm aquí

[Explica que Swarm no es “malo”: agrega tareas compartidas, mensajes directos, sesiones separadas y tiempo de coordinación. Para Cobranza Pro, esa coordinación no es necesaria para descubrir o resolver una tensión que el líder no pueda sintetizar. Si el reporte Swarm produjo el mismo piloto y las mismas restricciones, dilo claramente.]

## 7. Cuándo sí cambiaría la decisión

[Explica que Swarm se justificaría si Ventas, Riesgo y Operaciones necesitaran negociar repetidamente cambios de capacidad, condiciones o prioridades en tiempo real y esos intercambios alteraran el plan. No inventes que eso ocurrió en Cobranza Pro.]

## 8. Qué aprendimos

[En tres frases: un Nest divide investigación y centraliza síntesis; un Swarm descentraliza coordinación; la arquitectura mínima suficiente es mejor que la más compleja.]
```

La recomendación debe ser **Nest**. No cambies el veredicto a Swarm solo porque Agent Teams se haya formado: para este caso, el propósito didáctico es mostrar que la comunicación directa agrega capacidad, pero no cambia la decisión que un líder puede construir con reportes claros.

## 3. Confirma

Después de escribir el archivo, responde exactamente:

```text
DIAGNÓSTICO GUARDADO: resultados/debrief-swarm.md
VEREDICTO: para Cobranza Pro, Nest es suficiente.
```

Después muestra un resumen de tres viñetas: qué hizo el Nest, qué añadió el Swarm y por qué el Nest gana en este caso.
