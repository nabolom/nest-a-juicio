# Nest a juicio — reglas del experimento

Este repo sirve para comparar una tarea resuelta por un solo agente contra la misma tarea resuelta por un líder que delega a seis subagentes.

## Contrato experimental

1. La Tarea A o B debe copiarse literalmente desde `tareas/`.
2. No uses web, MCP, fuentes externas ni archivos fuera de este repo. El corpus fijo vive en `fuentes/`.
3. Para el **baseline**, respeta que la herramienta `Agent` puede estar bloqueada. Si lo está, no intentes delegar ni sugieras saltarte la restricción.
4. Para el **nest**, solo usa `fuente-1` a `fuente-6`; cada una debe leer una fuente del corpus y regresar su análisis al líder.
5. El líder sintetiza, pero no inventa datos ni modifica los hechos de las fuentes.
6. La calidad se califica con la rúbrica correspondiente, no por impresiones generales.

## Formato de respuesta

Entrega exactamente el formato requerido por la tarea. Si hay conflicto entre fuentes, nómbralo con su identificador; no lo resuelvas inventando una regla.
