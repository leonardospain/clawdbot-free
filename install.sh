#!/bin/bash
set -e

# 🦞 Clawdbot MULTI-AGENTE — Tu asistente personal autónomo
# Modificado por Leonardo Spain (España)
# Sin foto/vídeo • Sin APIs pagadas • Solo texto + acción

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${BLUE}
  🦞 Clawdbot MULTI-AGENTE — Tu asistente personal autónomo
  Modificado por Leonardo Spain (España)
  Sin foto/vídeo • Sin APIs pagadas • Solo texto + acción
${NC}"

# Verificar requisitos
check_requirement() {
  if ! command -v "$1" &> /dev/null; then
    echo -e "${RED}✗ $2 no encontrado. Instala $2 primero.${NC}"
    exit 1
  fi
  echo -e "${GREEN}✓${NC} $2 listo"
}

check_requirement "node" "Node.js 18+"
check_requirement "git" "Git"
check_requirement "curl" "curl"

# Instalar Ollama si no existe
if ! command -v ollama &> /dev/null; then
  echo -e "${YELLOW}⚠ Ollama no encontrado. Instalando...${NC}"
  curl -fsSL https://ollama.com/install.sh | sh
fi
echo -e "${GREEN}✓${NC} Ollama listo"

# Detectar IP LAN automáticamente
detect_ip() {
  if command -v ip &> /dev/null; then
    ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v '127.0.0.1' | head -1
  elif command -v ifconfig &> /dev/null; then
    ifconfig | grep -oE 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | awk '{print $2}' | sed 's/addr://'
  else
    hostname -I | awk '{print $1}'
  fi
}

AUTO_IP=$(detect_ip)
if [ -z "$AUTO_IP" ]; then
  AUTO_IP="127.0.0.1"
fi

# === MENÚ INTERACTIVO ===

# 1. Elegir LLM principal
echo -e "\n${BLUE}=== 1. Elige tu LLM principal (100% gratuito) ===${NC}"
echo -e "${YELLOW}💡 Mini = menos recursos | Estándar = mejor razonamiento${NC}"
PS3=$'\nTu elección (1-7): '
options=(
  "Qwen3 0.6B (ultra-mini • ~400MB • Raspberry Pi)"
  "Qwen3 1.7B (mini • ~1GB • rápido)"
  "Qwen3 4B (ligero • ~2.3GB • equilibrio)"
  "Qwen3 8B (estándar • ~4.7GB • calidad óptima)"
  "Mistral 7B (estándar • ~4.1GB • razonamiento)"
  "Phi-3.5-mini (ultra-ligero • ~2.1GB • Microsoft)"
  "Llama3.2 3B (ligero • ~2GB • Meta)"
)
select opt in "${options[@]}"; do
  case $REPLY in
    1) LLM="qwen3:0.6b"; SIZE="~400MB"; break;;
    2) LLM="qwen3:1.7b"; SIZE="~1GB"; break;;
    3) LLM="qwen3:4b"; SIZE="~2.3GB"; break;;
    4) LLM="qwen3:8b"; SIZE="~4.7GB"; break;;
    5) LLM="mistral:7b"; SIZE="~4.1GB"; break;;
    6) LLM="phi3.5:mini"; SIZE="~2.1GB"; break;;
    7) LLM="llama3.2:3b"; SIZE="~2GB"; break;;
    *) echo -e "${RED}Opción inválida. Elige 1-7.${NC}";;
  esac
done

# 2. Modo conexión
echo -e "\n${BLUE}=== 2. Modo de conexión ===${NC}"
echo -e "  [1] Offline puro (100% privado)"
echo -e "  [2] Híbrido Inteligente (recomendado para agentes)"
read -p "Elige modo [1-2] (por defecto: 2): " MODE_CHOICE
MODE_CHOICE="${MODE_CHOICE:-2}"
MODE=$( [ "$MODE_CHOICE" = "1" ] && echo "offline" || echo "hybrid" )
echo -e "${GREEN}✓${NC} Modo: $( [ "$MODE" = "offline" ] && echo "Offline puro" || echo "Híbrido Inteligente" )"

# 3. Puerto
echo -e "\n${BLUE}=== 3. Puerto HTTP ===${NC}"
echo -e "${YELLOW}💡 8765 = poco usado${NC}"
read -p "Puerto (por defecto: 8765): " PORT
PORT="${PORT:-8765}"
echo -e "${GREEN}✓${NC} Puerto: $PORT"

# 4. IP de acceso (automática + opcional cambio)
echo -e "\n${BLUE}=== 4. IP de acceso ===${NC}"
echo -e "  IP detectada automáticamente: ${CYAN}$AUTO_IP${NC}"
read -p "¿Usar esta IP? (S/n): " USE_AUTO
if [[ "$USE_AUTO" =~ ^[Nn]$ ]]; then
  read -p "Introduce tu IP manualmente: " MANUAL_IP
  ACCESS_IP="$MANUAL_IP"
else
  ACCESS_IP="$AUTO_IP"
fi
echo -e "${GREEN}✓${NC} IP de acceso: $ACCESS_IP"

# 5. Tailscale (opcional)
echo -e "\n${BLUE}=== 5. Acceso remoto ===${NC}"
echo -e "  [1] Tailscale (acceso seguro desde cualquier lugar)"
echo -e "  [2] LAN local solamente (solo red local)"
read -p "Elige [1-2] (por defecto: 2): " TS_CHOICE
TS_CHOICE="${TS_CHOICE:-2}"
ACCESS=$( [ "$TS_CHOICE" = "1" ] && echo "tailscale" || echo "lan" )
echo -e "${GREEN}✓${NC} Acceso: $( [ "$ACCESS" = "tailscale" ] && echo "Tailscale" || echo "LAN local" )"

# === INSTALACIÓN ===
echo -e "\n${BLUE}→ Instalando Clawdbot Multi-Agente...${NC}"
npm install -g clawdbot-free@latest --no-fund --no-audit --silent 2>/dev/null || npm install -g clawdbot-free@latest

# Descargar modelo
echo -e "\n${BLUE}→ Descargando modelo $LLM ($SIZE)...${NC}"
ollama pull "$LLM" 2>&1 | grep -E "(pulling|success|error)" || true

# Configuración Multi-Agentes
mkdir -p ~/.clawdbot

cat > ~/.clawdbot/config.json <<EOF
{
  "system_type": "multi-agent",
  "llm": "$LLM",
  "mode": "$MODE",
  "port": $PORT,
  "access_ip": "$ACCESS_IP",
  "access": "$ACCESS",
  "agents": {
    "coordinator": {
      "role": "decide qué agente usar según la tarea",
      "always_active": true
    },
    "researcher": {
      "role": "búsquedas web actuales (hoteles, vuelos, emergencias)",
      "triggers": ["precio", "hotel", "vuelo", "emergencia", "actual", "2025", "2026"],
      "search_engines": ["duckduckgo", "brave"]
    },
    "analyst": {
      "role": "razonamiento profundo y análisis lógico",
      "triggers": ["por qué", "cómo funciona", "comparar", "analizar"]
    },
    "executor": {
      "role": "toma decisiones proactivas y sugiere acciones",
      "triggers": ["reservar", "comprar", "decidir", "recomendar"],
      "requires_confirmation": true
    },
    "memory": {
      "role": "mantiene contexto a largo plazo de tus preferencias",
      "storage": "local",
      "max_days": 90
    }
  },
  "capabilities": [
    "text_reasoning",
    "web_search_when_needed",
    "price_comparison",
    "proactive_suggestions",
    "long_term_memory"
  ],
  "restrictions": [
    "no_image_processing",
    "no_video_processing",
    "no_paid_apis"
  ]
}
EOF

# === RESULTADO ===
echo -e "\n${GREEN}🦞 INSTALACIÓN COMPLETADA — Tu Multi-Agente está listo${NC}"
echo -e "${GREEN}✓${NC} Sistema: Multi-Agentes Especializados"
echo -e "${GREEN}✓${NC} LLM: $LLM ($SIZE)"
echo -e "${GREEN}✓${NC} Modo: $MODE"
echo -e "${GREEN}✓${NC} Puerto: $PORT"
echo -e "${GREEN}✓${NC} Acceso: $( [ "$ACCESS" = "tailscale" ] && echo "Tailscale" || echo "LAN local" )"
echo -e "\n${YELLOW}➡️  ACCESO DIRECTO:${NC}"
echo -e "   ${CYAN}http://$ACCESS_IP:$PORT${NC}"
echo -e "\n${CYAN}▶️  Para iniciar:${NC}"
echo -e "      clawdbot start"
echo -e "\n${CYAN}▶️  Para detener:${NC}"
echo -e "      clawdbot stop"
echo -e "\n${BLUE}Modificado por: Leonardo Spain (España)${NC}"
echo -e "Repositorio: https://github.com/leonardospain/clawdbot-free"
