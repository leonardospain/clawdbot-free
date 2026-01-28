# clawdbot-free

Agente local, gratis y auditable.
Funciona con Ollama local y ejecuta solo acciones permitidas por lista blanca.

Qué instala
- Crea ~/.clawdbot/
- Instala Ollama si falta, desde https://ollama.ai/install.sh
- Copia docker-compose.yml y binarios a ~/.clawdbot/
- No usa sudo
- No modifica .bashrc ni .zshrc
- No abre firewall
- No crea servicios de arranque

Qué hace hoy
- Modo Agent
  - Genera un plan JSON usando Ollama local
  - Valida el plan
  - Ejecuta solo acciones permitidas
  - Pide confirmación para shell y docker
  - Guarda todo en ~/.clawdbot/workspace

Qué no hace
- No emails
- No calendarios
- No reservas
- No scraping web por defecto
- No APIs de pago

Instalar
curl -fsSL https://raw.githubusercontent.com/leonardospain/clawdbot-free/main/install.sh | bash

Arrancar stack
docker compose -f ~/.clawdbot/docker-compose.yml up -d

Diagnóstico
~/.clawdbot/bin/clawdbot doctor

Modo Agent
~/.clawdbot/bin/clawdbot agent "resume este texto en 5 puntos"

Auditoría rápida
curl -fsSL https://raw.githubusercontent.com/leonardospain/clawdbot-free/main/install.sh -o install.sh
bash -n install.sh
less install.sh

Docs
- docs/QUICKSTART.md
- docs/WHAT-IT-DOES.md
- docs/PLAN-FORMAT.md
- docs/EXECUTOR-POLICY.md
- docs/ALLOWLIST-COMMANDS.md
- SECURITY.md
