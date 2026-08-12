---
description: Crea una entrega final descargable de la S5 a partir de la conclusión Nest y el debrief automático de Swarm.
---

# Cerrar la S5

Tu trabajo es convertir el ejercicio en un artefacto entregable. No inventes evidencia, resultados de Swarm ni respuestas faltantes.

## 1. Verifica los insumos

Lee estos archivos, en este orden:

1. `resultados/conclusion-nest.md` — obligatorio. Si no existe, detente y explica que primero se debe correr `bash scripts/correr-nest.sh`.
2. `resultados/debrief-swarm.md` — recomendado. Si no existe, continúa, pero marca el diagnóstico de arquitectura como pendiente y no lo inventes.
3. `resultados/reporte-swarm.md` — opcional. Úsalo solo como evidencia adicional si existe.
4. `resultados/decision-arquitectonica.md` — opcional. Si existe, puede complementar, pero no reemplaza el debrief automático.

## 2. Crea el archivo de entrega

Escribe `resultados/entrega-s5.md` con esta estructura exacta:

```markdown
# Entrega final — S5: Nest vs. Swarm

## 1. Conclusión del caso Cobranza Pro

[Incluye íntegra la conclusión guardada por el Nest: decisión, evidencia por área, tensiones, plan de 72 horas y lo que aún no se puede afirmar.]

## 2. Qué ocurrió en el Swarm

[Incluye el contenido de `resultados/debrief-swarm.md`. Si no existe, escribe: "Pendiente: correr /explicar-swarm después de la prueba Swarm o del Plan B".]

## 3. Conclusión de aprendizaje

[En dos o tres frases, separa la decisión de negocio de la decisión de arquitectura. No digas que Swarm es mejor por defecto. Explica qué comunicación necesitaba —o no necesitaba— este caso.]

## 4. Evidencia disponible

- Conclusión del Nest: `resultados/conclusion-nest.md`
- Reporte Swarm: `resultados/reporte-swarm.md` o `no disponible`
- Debrief de Claude: `resultados/debrief-swarm.md` o `pendiente`
- Captura del transcript: [indica si el alumno dijo que la guardó; si no, escribe `no entregada`]
```

## 3. Confirma al alumno

Después de escribir el archivo, responde exactamente:

```text
ENTREGA LISTA: resultados/entrega-s5.md
```

Luego explica en una frase: el archivo se puede adjuntar desde la carpeta `resultados` en Finder, Explorador de archivos o el selector de archivos de la plataforma donde lo vaya a entregar.
