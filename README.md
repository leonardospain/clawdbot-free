# clawdbot-free

clawdbot-free es un instalador local.
Prepara la carpeta ~/.clawdbot, un stack Docker local gratis, y un modo Agent básico.

Estado hoy
- Instalación local mínima
- Auditoría y dry-run incluidos
- Modo Agent v0.1 genera un plan JSON usando Ollama local
- Sin promesas de funciones no implementadas

Requisitos
- Linux o macOS
- curl
- Docker y Docker Compose para usar el stack

Instalación
curl -fsSL https://raw.githubusercontent.com/leonardospain/clawdbot-free/main/install.sh | bash

Auditoría
curl -fsSL https://raw.githubusercontent.com/leonardospain/clawdbot-free/main/install.sh | bash -s -- --audit

Dry run
curl -fsSL https://raw.githubusercontent.com/leonardospain/clawdbot-free/main/install.sh | DRY_RUN=1 bash -s -- --dry-run

Desinstalar
curl -fsSL https://raw.githubusercontent.com/leonardospain/clawdbot-free/main/install.sh | bash -s -- --uninstall

Stack local gratis
En el repo:
- docker-compose.yml levanta ollama y redis
- start.sh arranca el stack

Modo Agent v0.1
1) Arranca servicios
docker compose -f ~/.clawdbot/docker-compose.yml up -d

2) Ejecuta una tarea
~/.clawdbot/bin/clawdbot agent "resume este texto en 5 puntos"

3) Revisa salida
ls -la ~/.clawdbot/workspace

Qué no hace
- No envía emails
- No integra calendarios
- No hace reservas
- No abre firewall
- No modifica .bashrc ni .zshrc

Docs
- docs/WHAT-IT-DOES.md
- docs/MODE-AGENT-SPEC.md
- docs/WINDOWS.md
