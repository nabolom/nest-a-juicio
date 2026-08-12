# Nest vs. Swarm — ejercicio final S5

> **No vas a medir la factura de Claude. Vas a observar qué comunicación necesita un problema para elegir la arquitectura mínima suficiente.**

En este ejercicio todos ejecutan un **Nest** y después **Swarm**. Al final no entregas una tabla de tokens: entregas una decisión arquitectónica defendible.

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

**Qué debes mirar:** verás cuatro delegaciones y, al final, estas dos líneas:

```text
ARCHIVO GUARDADO: resultados/conclusion-nest.md
NEST COMPLETADO: 4/4 reportes recibidos.
```

La primera confirma que la conclusión de negocio ya quedó guardada en [`resultados/conclusion-nest.md`](resultados/README.md): ahí tendrás la decisión, la evidencia por área, las tensiones y el plan de 72 horas. Guarda una captura del transcript. Después escribe `/exit` para volver a la Terminal. No necesitas usar `/usage` y no necesitas calcular costos.

---

## 6. Ejecuta el Swarm — todos alumnos

Ahora corre el mismo caso como un **Agent Team**. En la Terminal, todavía dentro de la carpeta `nest-a-juicio`, ejecuta:

```bash
bash scripts/correr-swarm.sh
```

**Qué ocurrirá:** el líder conserva Producto y crea tres teammates: Ventas, Riesgo y Operaciones. Verás cuatro tareas compartidas y solo dos mensajes directos obligatorios: Riesgo → Ventas y la respuesta de Ventas. Esto es deliberadamente breve: queremos observar coordinación, no esperar una investigación larga.

**Qué debes mirar:** dentro de los primeros 90 segundos deben aparecer tres teammates, tareas compartidas y los dos mensajes entre pares. La corrida solo cuenta como Swarm cuando termina con:

```text
SALIDA GUARDADA: resultados/reporte-swarm.md
SWARM COMPLETADO: teammates, tareas compartidas y dos mensajes entre pares observados.
```

El archivo [`resultados/reporte-swarm.md`](resultados/README.md) debe contener la decisión, evidencia por rol, comunicación observada, qué cambió —o no— frente al Nest, plan de 72 horas y lo que aún no se puede afirmar.

Agent Teams es experimental. Si en 90 segundos no aparecen teammates, escribe `/exit`, no pierdas más tiempo y usa el Plan B de [`facilitador/GUIA-DEMO-SWARM.md`](facilitador/GUIA-DEMO-SWARM.md). El debrief de Claude también puede explicar el contraste sin una corrida válida.

---

## 7. Deja que Claude te explique qué sucedió

No necesitas completar una entrevista larga ni responder preguntas complejas durante el taller. Abre Claude Code dentro de este repo:

```bash
claude
```

Y escribe:

```text
/explicar-swarm
```

Claude lee la conclusión del Nest, el reporte Swarm si existe y el caso. Después crea:

```text
resultados/debrief-swarm.md
```

El debrief compara ambos patrones en lenguaje simple: qué resolvió el Nest, qué capacidad adicional intentó agregar el Swarm, si esa comunicación cambió realmente la decisión y el veredicto explícito para este caso: **Nest es suficiente** porque un líder puede integrar reportes claros sin negociación iterativa entre pares.

> Si concluye que el Nest basta, esa es una excelente respuesta. Acabas de evitar complejidad que este caso no necesitaba.

`/decidir-arquitectura` sigue disponible como actividad opcional para quien quiera defender una decisión propia en más detalle.

---

## 8. Crea y descarga tu entrega final

Cuando tengas `resultados/conclusion-nest.md` y `resultados/debrief-swarm.md`, abre Claude Code dentro de este repo:

```bash
claude
```

Y escribe:

```text
/cerrar-s5
```

El comando crea `resultados/entrega-s5.md`: un solo archivo que integra la conclusión del caso, tu decisión arquitectónica y la evidencia disponible. La Terminal te confirmará:

```text
ENTREGA LISTA: resultados/entrega-s5.md
```

Para adjuntarlo, abre la carpeta `resultados` en Finder, Explorador de archivos o el selector de archivos de la plataforma donde entregarás el trabajo. El archivo queda en **tu copia local** del repo; no se sube automáticamente al repositorio público.

---

## 9. Llévalo a tu propio proceso

`nest-a-juicio` es un caso guiado. Cuando termines, crea tu propia copia privada de la [plantilla para configurar Nest o Swarm](https://github.com/nabolom/plantilla-nest-swarm): ahí Claude te entrevista sobre **tu** proceso y solo después configura el patrón que tu caso necesita.

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
