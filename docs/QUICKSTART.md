# Quickstart

1) Instala
curl -fsSL https://raw.githubusercontent.com/leonardospain/clawdbot-free/main/install.sh | bash

2) Arranca el stack local
docker compose -f ~/.clawdbot/docker-compose.yml up -d

3) Ejecuta Modo Agent
~/.clawdbot/bin/clawdbot agent "resume este texto en 5 puntos"

4) Revisa resultado
ls -la ~/.clawdbot/workspace
