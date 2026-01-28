# Seguridad

Este proyecto prioriza auditoría y control.

Garantías del instalador
- No usa sudo
- No modifica .bashrc ni .zshrc
- No abre puertos de firewall
- No crea servicios de arranque
- Registra acciones en ~/.clawdbot/install.log

Recomendación de auditoría
- Revisa install.sh antes de ejecutar
- Usa DRY_RUN=1 para ver acciones sin ejecutar

Reportar un problema
Abre un Issue con:
- Sistema operativo
- Salida de: bash -n install.sh
- Salida de: DRY_RUN=1 ./install.sh --dry-run
