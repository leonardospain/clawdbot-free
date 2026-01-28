# Modo Agent. Especificación v0.1

Objetivo
Ejecutar tareas locales de bajo riesgo con modelo local. Sin APIs pagadas.

Definición de tarea
Entrada: texto en CLI.
Salida: carpeta en ~/.clawdbot/workspace/<timestamp>-<slug> con:
- task.txt
- plan.json
- output/
- logs/agent.log

Seguridad y permisos
Por defecto
- Solo lectura de archivos.
- Escritura solo dentro de workspace.

Requiere confirmación explícita
- Borrar archivos
- Modificar archivos fuera de workspace
- Ejecutar comandos del sistema
- Operaciones docker destructivas

Fuentes online
- Desactivadas por defecto.
- Si se habilitan en el futuro, debe existir un flag y lista de dominios permitidos.

Compatibilidad
- Linux server
- macOS dev

Dependencias
- Docker y docker compose para servicios
- Ollama local en 11434

Comandos CLI previstos
- clawdbot agent "tarea"
- clawdbot status
- clawdbot logs
- clawdbot purge
