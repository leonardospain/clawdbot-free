# Qué hace este repo hoy

Incluye
- install.sh
  - Crea ~/.clawdbot, workspace, templates, install.log
  - Instala Ollama si no existe, desde https://ollama.ai/install.sh
  - Soporta --audit, --dry-run, --uninstall

- docker-compose.yml
  - Levanta servicios locales gratis:
    - ollama en 11434
    - redis en 6379

- start.sh
  - Arranca docker compose y muestra estado

No incluye
- No modo Agent todavía
- No envío de emails
- No calendarios
- No reservas
