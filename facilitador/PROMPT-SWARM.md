# Prompt para demo Swarm breve — copiar y pegar en Claude Code

> Antes de abrir Claude Code, corre:
>
> ```bash
> export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
> claude
> ```

Pega este prompt completo:

```text
Quiero una DEMO BREVE DE AGENT TEAM, no subagentes normales. Usa el caso de `caso/lanzamiento-cobranza-pro.md`.

Tú eres el líder y conservas Producto. Crea exactamente tres teammates usando los roles de proyecto ventas, riesgo y operaciones. Cada teammate debe leer el caso y devolver un reporte de máximo tres líneas.

Crea una lista de tareas compartida con solo cuatro tareas: Ventas propone cómo conservar la fecha sin prometer una activación prohibida; Riesgo declara la prohibición y control; Operaciones confirma la capacidad; el líder sintetiza y guarda la salida.

Exige solo dos mensajes directos entre pares: Riesgo debe escribir a Ventas la restricción de los 12 clientes regulados; Ventas debe responder con una propuesta que respete esa restricción. Operaciones debe leer esa propuesta desde la tarea compartida y confirmar si cabe dentro de 15 inscripciones manuales.

No uses web, MCP ni datos fuera del repo. No inventes aprobaciones, recursos ni fechas. Después de completar las tres tareas y los dos mensajes, escribe `resultados/reporte-swarm.md` con estas secciones:

# Reporte Swarm — Cobranza Pro
## Decisión
## Evidencia por rol
## Comunicación entre pares observada
## Qué cambió — o no cambió — frente al Nest
## Plan de 72 horas
## Lo que aún no se puede afirmar
## Estado del experimento

En el estado declara si viste teammates, tarea compartida y los dos mensajes. Cierra solo después de guardar el archivo con:
SALIDA GUARDADA: resultados/reporte-swarm.md
SWARM COMPLETADO: teammates, tareas compartidas y dos mensajes entre pares observados.
```

> **Qué debe verse:** tres teammates, cuatro tareas compartidas, dos mensajes entre pares y el archivo `resultados/reporte-swarm.md`. Si no aparecen teammates, no presentes la demo como un Swarm válido; usa el Plan B de [`GUIA-DEMO-SWARM.md`](GUIA-DEMO-SWARM.md).
