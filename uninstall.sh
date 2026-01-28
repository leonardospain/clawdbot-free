#!/bin/bash
set -e

# 🦞 Clawdbot MULTI-AGENTE — Desinstalador público seguro
# Modificado por Leonardo Spain (España)
# Limpieza total sin perder datos importantes sin confirmación

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}
  🦞 Clawdbot MULTI-AGENTE — Desinstalador público seguro
  Modificado por Leonardo Spain (España)
${NC}"

# Verificar requisitos
if ! command -v npm &> /dev/null; then
  echo -e "${RED}✗ npm no encontrado. ¿Está Node.js instalado?${NC}"
  exit 1
fi

# === ADVERTENCIA DE SEGURIDAD ===
echo -e "\n${YELLOW}⚠️  ATENCIÓN — Se eliminará:${NC}"
echo -e "   • clawdbot-free (aplicación)"
echo -e "   • Configuración y preferencias"
echo -e "   • Historial de conversaciones"
echo -e "\n${RED}❌ NO se eliminarán tus archivos personales ni otros programas${NC}"

read -p "¿Confirmas la desinstalación? (escribe 'sí' para continuar): " CONFIRM
if [[ ! "$CONFIRM" =~ ^[SsíÍsSíÍ]$ ]]; then
  echo -e "\n${RED}Cancelado por el usuario. Nada fue eliminado.${NC}"
  exit 0
fi

# === DETENER PROCESOS ===
echo -e "\n${BLUE}→ Deteniendo agentes en ejecución...${NC}"
if pgrep -f "clawdbot" &> /dev/null; then
  pkill -f "clawdbot" 2>/dev/null || true
  sleep 2
  echo -e "${GREEN}✓${NC} Procesos detenidos"
else
  echo -e "${GREEN}✓${NC} No hay procesos activos"
fi

# === DESINSTALAR ===
echo -e "\n${BLUE}→ Eliminando clawdbot-free...${NC}"
if npm list -g clawdbot-free &> /dev/null; then
  npm uninstall -g clawdbot-free &> /dev/null || true
  echo -e "${GREEN}✓${NC} Aplicación eliminada"
else
  echo -e "${YELLOW}⚠${NC} clawdbot-free no estaba instalado globalmente"
fi

# === ELIMINAR CONFIGURACIÓN ===
echo -e "\n${BLUE}→ Eliminando configuración...${NC}"
if [ -d "$HOME/.clawdbot" ]; then
  rm -rf "$HOME/.clawdbot"
  echo -e "${GREEN}✓${NC} Configuración eliminada (~/.clawdbot)"
else
  echo -e "${YELLOW}⚠${NC} No existe configuración previa"
fi

# === MODELOS OLLAMA (OPCIONAL) ===
echo -e "\n${BLUE}=== Modelos Ollama ===${NC}"
echo -e "Los modelos ocupan espacio pero pueden reusarse en otros proyectos."
echo -e "  [1] Eliminar modelos clawdbot (libera espacio)"
echo -e "  [2] Conservar modelos (recomendado)"
read -p "Elige [1-2] (por defecto: 2): " OLLAMA_CHOICE
OLLAMA_CHOICE="${OLLAMA_CHOICE:-2}"

if [ "$OLLAMA_CHOICE" = "1" ]; then
  echo -e "\n${BLUE}→ Eliminando modelos...${NC}"
  if command -v ollama &> /dev/null; then
    for model in $(ollama list 2>/dev/null | grep -E "(qwen|mistral|phi|llama)" | awk '{print $1}'); do
      if ollama rm "$model" &> /dev/null; then
        echo -e "   ${GREEN}✗${NC} $model eliminado"
      fi
    done
    echo -e "${GREEN}✓${NC} Modelos eliminados"
  else
    echo -e "${YELLOW}⚠${NC} Ollama no está instalado"
  fi
else
  echo -e "${GREEN}✓${NC} Modelos conservados (puedes reusarlos)"
fi

# === RESULTADO ===
echo -e "\n${GREEN}🦞 DESINSTALACIÓN COMPLETADA${NC}"
echo -e "${GREEN}✓${NC} clawdbot-free eliminado"
echo -e "${GREEN}✓${NC} Configuración eliminada"
echo -e "${GREEN}✓${NC} Procesos detenidos"
echo -e "\n${BLUE}Modificado por: Leonardo Spain (España)${NC}"
echo -e "Repositorio: https://github.com/leonardospain/clawdbot-free"
