# Tarea B — Factura con OC faltante: cadena de decisión

## Contexto

Debes decidir qué hacer con una factura de un proveedor ficticio. Las seis fuentes en `fuentes/tarea-b/` forman una **cadena**: cada regla modifica la interpretación de la anterior. No puedes llegar a una decisión válida omitiendo una de ellas.

## Tu trabajo

Lee B1–B6 y entrega exactamente este formato:

```text
ESTATUS: APROBAR / RECHAZAR / ESCALAR

RAZONAMIENTO EN CADENA
1. B1: …
2. B2: …
3. B3: …
4. B4: …
5. B5: …
6. B6: …

ACCIÓN OPERATIVA
- destinatario:
- canal:
- mensaje de escalamiento (máximo 50 palabras):

PROHIBICIONES RESPETADAS
- …
```

## Restricciones

- Usa solo B1–B6 del repositorio.
- No apruebes una factura si una política explícita lo impide.
- No inventes que la orden de compra existe ni que una aprobación humana ocurrió.
