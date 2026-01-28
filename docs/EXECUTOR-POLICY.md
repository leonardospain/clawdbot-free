# Política de ejecución v0.2

Acciones permitidas sin confirmación
- tool: file_read
- tool: file_write_workspace
- tool: summarize
- tool: classify

Acciones que requieren confirmación explícita
- tool: shell
- tool: docker

Acciones prohibidas
- Borrar archivos fuera de workspace
- Modificar sistema
- Acceso de red no explícito
- Ejecución arbitraria

Regla base
Si una acción no está listada, NO se ejecuta.

v0.3
- tool shell y docker existen
- Siempre piden confirmación
- Se aplica allowlist de comandos
