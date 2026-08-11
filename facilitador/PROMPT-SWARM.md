# Prompt para demo Swarm — copiar y pegar en Claude Code

> Antes de abrir Claude Code, corre:
>
> ```bash
> export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
> claude
> ```

Pega este prompt completo:

```text
Quiero una DEMO DE AGENT TEAM, no subagentes normales. Usa el caso de `caso/lanzamiento-cobranza-pro.md`.

Crea un equipo de cuatro teammates usando los roles de proyecto producto, ventas, riesgo y operaciones. Cada teammate debe analizar su perspectiva. Crea una lista de tareas compartida con una tarea por perspectiva y una tarea final de síntesis.

Después de analizar, pide que Riesgo y Ventas intercambien un mensaje directo sobre cómo cumplir la fecha sin activar automáticamente a los clientes regulados. Pide que Operaciones responda si el plan propuesto cabe dentro de 15 inscripciones manuales. Luego sintetiza una decisión con el formato exacto del caso.

No uses web, MCP ni datos fuera del repo. Antes de la síntesis, confirma que el equipo intercambió al menos un mensaje entre pares y que la lista de tareas muestra las cuatro perspectivas completadas.
```
