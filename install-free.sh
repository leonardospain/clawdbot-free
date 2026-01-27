#!/bin/bash
set -euo pipefail
# Clawdbot Installer GRATUITO - Modificado por Leonardo Spain (España)
# 100% offline • Sin APIs pagadas • Sin contraseñas • Español por defecto
BOLD='\033[1m'
ACCENT='\033[38;2;255;90;45m'
SUCCESS='\033[38;2;47;191;113m'
WARN='\033[38;2;255;176;32m'
ERROR='\033[38;2;226;61;45m'
NC='\033[0m'

echo -e "${ACCENT}${BOLD}"
echo "  🦞 Clawdbot GRATUITO - Instalador 100% Libre"
echo -e "${NC}${ACCENT}  Modificado por Leonardo Spain (España)${NC}"
echo -e "${NC}${ACCENT}  Sin APIs pagadas • Sin contraseñas • Modo offline${NC}"
echo ""

# Detectar sistema
OS="unknown"
[[ "$OSTYPE" == "darwin"* ]] && OS="macos"
[[ "$OSTYPE" == "linux-gnu"* ]] && OS="linux"

[[ "$OS" == "unknown" ]] && { echo -e "${ERROR}Error: Sistema no soportado${NC}"; exit 1; }
echo -e "${SUCCESS}✓${NC} Sistema: $OS"

# Node.js
if ! command -v node &>/dev/null || [[ "$(node -v | cut -d'v' -f2 | cut -d'.' -f1)" -lt 22 ]]; then
  echo -e "${WARN}→${NC} Instalando Node.js 22..."
  [[ "$OS" == "macos" ]] && brew install node@22 2>/dev/null || true
  [[ "$OS" == "linux" ]] && { curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash - && sudo apt-get install -y nodejs; }
fi
echo -e "${SUCCESS}✓${NC} Node.js listo"

# Git
command -v git &>/dev/null || { echo -e "${WARN}→${NC} Instalando Git..."; [[ "$OS" == "macos" ]] && brew install git || sudo apt-get install -y git; }
echo -e "${SUCCESS}✓${NC} Git listo"

# Clawdbot
echo -e "${WARN}→${NC} Instalando Clawdbot (CLI gratuito)..."
npm install -g clawdbot@latest --no-fund --no-audit --loglevel=error 2>/dev/null || npm install -g clawdbot@next --no-fund --no-audit --loglevel=error

# Config offline
mkdir -p "$HOME/.config/clawdbot"
cat > "$HOME/.config/clawdbot/config.json" << 'EOF'
{
  "offline_mode": true,
  "disable_whatsapp": true,
  "disable_telegram": true,
  "disable_gemini": true,
  "disable_openai": true,
  "local_llm": "qwen:latest",
  "language": "es",
  "modified_by": "Leonardo Spain"
}
EOF

echo ""
echo -e "${SUCCESS}${BOLD}🦞 INSTALACIÓN COMPLETADA${NC}"
echo -e "${SUCCESS}✓${NC} 100% gratuito • Sin APIs pagadas"
echo -e "${SUCCESS}✓${NC} Modo offline activado"
echo -e "${SUCCESS}✓${NC} Español + LLM local (Qwen)"
echo ""
echo -e "${ACCENT}Modificado por:${NC} Leonardo Spain (España)"
echo -e "${ACCENT}Repositorio:${NC} https://github.com/leonardospain/clawdbot-free"
