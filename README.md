# Nest vs. Swarm — ejercicio final S5

> **No vas a medir la factura de Claude. Vas a observar qué comunicación necesita un problema para elegir la arquitectura mínima suficiente.**

En este ejercicio todos ejecutan un **Nest** y después observan una demostración de **Swarm** dirigida por el facilitador. Al final no entregas una tabla de tokens: entregas una decisión arquitectónica defendible.

---

## 1. Primero clona el ejercicio

Abre tu **Terminal**. Copia y pega estas tres líneas, una sola vez y en este orden:

```bash
git clone https://github.com/nabolom/nest-a-juicio.git
cd nest-a-juicio
bash scripts/empezar.sh
```

| Comando | En palabras simples |
|---|---|
| `git clone …` | Descarga una copia del ejercicio a tu computadora. |
| `cd nest-a-juicio` | Entra a la carpeta que acabas de descargar. |
| `bash scripts/empezar.sh` | Revisa que Claude Code esté listo y te recuerda el siguiente paso. **Aún no ejecuta agentes.** |

Si el último comando dice `OK`, estás listo. Si marca un error, no sigas: lee el mensaje. Si pide autenticación, corre `claude auth login` y vuelve a intentar `bash scripts/empezar.sh`.

> **Importante:** no necesitas escribir `cat`. `cat` solo imprime un archivo en la Terminal y no lo usaremos como instrucción para alumnos.

---

## 2. El caso — léelo aquí antes de ejecutar agentes

Horizonte, una empresa ficticia de software de facturación, quiere lanzar **Cobranza Pro** el **15 de octubre**. Debes ayudar a decidir si debe lanzar, hacer un piloto cerrado o posponer.

Estas son las cuatro piezas de información. Todas son verdaderas al mismo tiempo:

| Área | Lo que sabemos | La tensión que introduce |
|---|---|---|
| **Producto** | La funcionalidad está lista. Si cambian el flujo de consentimiento, necesitan diez días hábiles de congelamiento y pruebas. | No hay margen para cambiar el consentimiento antes de un lanzamiento amplio el 15 de octubre. |
| **Ventas** | Hay 40 clientes interesados. Doce pertenecen a sectores regulados. El equipo comercial prometió acceso el 15 de octubre. | Quieren cumplir una promesa comercial sin perder pipeline. |
| **Riesgo** | Los 12 clientes regulados requieren inscripción manual hasta aprobar el modelo de consentimiento. | No se puede activar automáticamente a esos 12 clientes. |
| **Operaciones** | Dos personas pueden completar, como máximo, 15 inscripciones manuales durante la primera semana. | Un piloto es viable; una activación amplia puede rebasar la capacidad. |

Al terminar, Claude debe entregar una decisión, evidencia por área, dos tensiones, un plan de 72 horas y algo que aún no puede afirmarse. **No puede inventar aprobaciones, recursos ni fechas.**

---

## 3. Las dos arquitecturas que vamos a comparar

| Patrón | Qué sucede | Cuándo tiene sentido |
|---|---|---|
| **Nest** | Producto, Ventas, Riesgo y Operaciones investigan su perspectiva y **reportan a un líder**. El líder integra y decide. | Cuando el líder puede recomponer la información con reportes claros. |
| **Swarm** | Los agentes tienen una lista de tareas compartida y pueden **mandarse mensajes directos** entre sí. | Cuando los especialistas necesitan negociar, cuestionarse o coordinar entre pares. |

```text
NEST                              SWARM
producto ─────┐                   producto <──> ventas
ventas ───────┼──> líder          riesgo   <──> operaciones
riesgo ───────┤       │              \_______ líder _______/
operaciones ──┘       └──> decisión
```

La pregunta no es cuál se ve más avanzado. La pregunta es:

> **Para Cobranza Pro, ¿basta con que las áreas reporten a un líder o necesitan hablarse directamente para resolver las tensiones?**

---

## 4. Ahora sí: tu predicción

Después de leer el caso y entender ambos patrones, completa esta frase en una nota:

> “Para Cobranza Pro elegiría [Nest / Swarm] porque los especialistas [sí / no] necesitan comunicarse directamente para resolver las tensiones entre Ventas, Riesgo y Operaciones.”

No hay una respuesta esperada. Vas a contrastar tu intuición después de observar ambos patrones.

---

## 5. Ejecuta el Nest — todos los alumnos

En la Terminal, dentro de la carpeta `nest-a-juicio`, ejecuta:

```bash
bash scripts/correr-nest.sh
```

**Qué ocurrirá:** Claude Code se abrirá. El coordinador abrirá cuatro especialistas: Producto, Ventas, Riesgo y Operaciones. Cada especialista reporta su lectura al líder. El líder integra los cuatro reportes en una decisión y un plan de 72 horas.

**Qué debes mirar:** verás cuatro delegaciones y, al final, esta línea:

```text
NEST COMPLETADO: 4/4 reportes recibidos.
```

Guarda una captura del transcript. Después escribe `/exit` para volver a la Terminal. No necesitas usar `/usage` y no necesitas calcular costos.

---

## 6. Observa el Swarm — demo del facilitador

Tu facilitador mostrará el mismo caso como un **Agent Team**. En la demo, Riesgo, Ventas y Operaciones pueden enviarse mensajes directos y usar una lista de tareas común.

Mientras lo observas, responde estas tres preguntas:

1. ¿Qué información viajó directamente de un especialista a otro?
2. ¿Ese intercambio cambió algo que un líder no habría podido resolver con cuatro reportes?
3. ¿La lista de tareas compartida resolvió una confusión real o añadió complejidad?

Agent Teams es experimental. Si no aparece, el facilitador usará la guía de respaldo en [`facilitador/GUIA-DEMO-SWARM.md`](facilitador/GUIA-DEMO-SWARM.md). No se simulan resultados.

---

## 7. Entrega tu decisión arquitectónica

En la Terminal, copia la tarjeta:

```bash
cp tarjetas/DECISION-ARQUITECTURA.md mi-decision-arquitectonica.md
```

Ábrela en tu editor, completa las preguntas con evidencia del Nest y de la demo Swarm, y elige una opción: **un solo agente**, **Nest** o **Swarm**.

> Si concluyes que el Nest basta, esa es una excelente respuesta. Acabas de evitar complejidad que este caso no necesitaba.

---

## Para el facilitador

- [Prompt exacto para la demo Swarm](facilitador/PROMPT-SWARM.md)
- [Guía de demo y plan B honesto](facilitador/GUIA-DEMO-SWARM.md)

## Si te atoras

| Problema | Qué haces |
|---|---|
| `claude: command not found` | Instala Claude Code, abre una Terminal nueva y corre otra vez `bash scripts/empezar.sh`. |
| Error de autenticación | Ejecuta `claude auth login` y vuelve a empezar. |
| No aparecen cuatro delegaciones | Escribe `/exit` y repite `bash scripts/correr-nest.sh`. |
| No entiendes la diferencia Nest/Swarm | Relee los dos diagramas y pregunta: “¿quién necesita hablar con quién?”. |

## Referencias

- [Claude Code: custom subagents](https://code.claude.com/docs/en/sub-agents)
- [Claude Code: agent teams](https://code.claude.com/docs/en/agent-teams)
