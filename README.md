# clawdbot-free

clawdbot-free es un instalador local.
Prepara la carpeta ~/.clawdbot y asegura Ollama.

Estado hoy
- Instalación local mínima
- Auditoría y dry-run incluidos
- Sin promesas de funciones no implementadas

Requisitos
- macOS o Linux
- curl

Instalación
curl -fsSL https://raw.githubusercontent.com/leonardospain/clawdbot-free/main/install.sh | bash

Auditoría
curl -fsSL https://raw.githubusercontent.com/leonardospain/clawdbot-free/main/install.sh | bash -s -- --audit

Dry run
curl -fsSL https://raw.githubusercontent.com/leonardospain/clawdbot-free/main/install.sh | DRY_RUN=1 bash -s -- --dry-run

Desinstalar
curl -fsSL https://raw.githubusercontent.com/leonardospain/clawdbot-free/main/install.sh | bash -s -- --uninstall

Archivos creados
- ~/.clawdbot/
- ~/.clawdbot/workspace/
- ~/.clawdbot/templates/
- ~/.clawdbot/install.log

Qué no hace
- No instala servicios al arranque
- No abre firewall
- No modifica .bashrc ni .zshrc
- No envía emails
- No integra calendarios
- No hace reservas

Windows
docs/WINDOWS.md
