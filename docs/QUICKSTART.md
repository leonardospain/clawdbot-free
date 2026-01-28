# Quickstart

1) Instala
curl -fsSL https://raw.githubusercontent.com/leonardospain/clawdbot-free/main/install.sh | bash

2) Arranca stack local
docker compose -f ~/.clawdbot/docker-compose.yml up -d

3) Diagnóstico
~/.clawdbot/bin/clawdbot doctor

4) Crear tarea sin ejecutar
~/.clawdbot/bin/clawdbot new-task "resume este texto en 5 puntos"

5) Ejecutar modo Agent
~/.clawdbot/bin/clawdbot agent "resume este texto en 5 puntos"

6) Ver resultados
ls -la ~/.clawdbot/workspace
