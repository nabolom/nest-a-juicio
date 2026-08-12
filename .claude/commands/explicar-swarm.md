---
description: Explica automáticamente qué ocurrió en Nest y Swarm, guarda un diagnóstico breve y no hace una entrevista.
---

# Explicar el Swarm

Tu papel es ser el debrief pedagógico del ejercicio. **No entrevistes al alumno, no pidas que complete una tarjeta y no inventes evidencia.** Lee los archivos que existan y explica de forma clara qué pasó.

## 1. Lee la evidencia disponible

1. `resultados/conclusion-nest.md` — obligatorio si existe.
2. `resultados/reporte-swarm.md` — opcional; puede no existir si Agent Teams no apareció o la corrida no terminó.
3. `caso/lanzamiento-cobranza-pro.md` — para anclar la explicación al caso.

Si `conclusion-nest.md` no existe, detente y di que primero se debe correr el Nest. Si no existe `reporte-swarm.md`, continúa de todos modos: el diagnóstico debe explicar que no hubo evidencia de un Swarm válido.

## 2. Escribe el debrief

Crea `resultados/debrief-swarm.md` con esta estructura exacta:

```markdown
# Qué sucedió en el experimento Nest vs. Swarm

## 1. Lo que resolvió el Nest

[Resume en lenguaje llano la decisión de Cobranza Pro y por qué el líder pudo integrarla con reportes de Producto, Ventas, Riesgo y Operaciones.]

## 2. Lo que intentó hacer el Swarm

[Explica que Agent Teams creó —o intentó crear— sesiones separadas, tareas compartidas y mensajes directos. Si existe el reporte, nombra los teammates, la tarea compartida y los mensajes que sí aparecen. Si no existe, di literalmente: "No hay evidencia de un Swarm válido en esta corrida".]

## 3. Por qué el Swarm tardó más

[Explica sin números inventados: cada teammate tiene que abrir contexto, completar una tarea, coordinar y esperar la síntesis. El retraso no prueba que Agent Teams esté roto; muestra el costo operativo de agregar coordinación.]

## 4. ¿La comunicación adicional cambió la decisión?

[Compara la decisión del Nest contra el reporte Swarm si existe. Si el Swarm no cambió la decisión, dilo claramente: para este caso, el líder podía resolver la tensión con reportes claros. Si no hay evidencia, di que no se puede concluir.]

## 5. Diagnóstico de arquitectura de Claude

**Recomendación para Cobranza Pro:** `un solo agente / Nest / Swarm / evidencia insuficiente`

**Porque:** [máximo tres razones basadas únicamente en archivos disponibles.]

## 6. Qué aprendimos

[Explica en tres frases: Nest = reportes a líder; Swarm = tareas compartidas y mensajes entre pares; la arquitectura mínima suficiente gana al patrón más complejo.]
```

La recomendación debe ser **Nest** si la evidencia muestra que el líder pudo resolver la tensión sin que la conversación directa modificara el plan. No elijas Swarm solo porque se logró formar un Agent Team.

## 3. Confirma

Después de escribir el archivo, responde exactamente:

```text
DEBRIEF GUARDADO: resultados/debrief-swarm.md
```

Después muestra un resumen de tres viñetas, no más.
