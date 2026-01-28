#!/usr/bin/env bash
set -euo pipefail

VERSION="v2.0.1"
INSTALL_DIR="${HOME}/.clawdbot"
LOG_FILE="${INSTALL_DIR}/install.log"
DRY_RUN="${DRY_RUN:-0}"
MODE="${1:-install}"

log() {
  mkdir -p "${INSTALL_DIR}" >/dev/null 2>&1 || true
  touch "${LOG_FILE}" >/dev/null 2>&1 || true
  printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$1" | tee -a "${LOG_FILE}" >/dev/null
}

run() {
  log "RUN: $*"
  if [ "${DRY_RUN}" = "1" ]; then
    printf '[DRY_RUN] %s\n' "$*"
    return 0
  fi
  "$@"
}

detect_platform() {
  local os
  os="$(uname -s 2>/dev/null || echo unknown)"
  case "${os}" in
    Linux)  echo "linux" ;;
    Darwin) echo "macos" ;;
    *)      echo "unknown" ;;
  esac
}

audit_mode() {
  cat <<EOF2
=== AUDIT clawdbot-free ${VERSION} ===
Rutas que crea:
  ${HOME}/.clawdbot/
  ${HOME}/.clawdbot/workspace/
  ${HOME}/.clawdbot/templates/
  ${HOME}/.clawdbot/install.log

Acciones:
  - Detecta plataforma con uname -s
  - Si falta ollama y la plataforma es linux o macos, descarga e instala desde:
      https://ollama.ai/install.sh
  - No usa sudo
  - No modifica .bashrc ni .zshrc
  - No abre firewall
  - No crea servicios de arranque

Modos:
  --audit
  --dry-run
  --uninstall
EOF2
  exit 0
}

uninstall() {
  log "UNINSTALL: inicio"
  printf 'Confirmar borrado total de %s ? [s/N]: ' "${INSTALL_DIR}"
  read -r CONFIRM
  case "${CONFIRM}" in
    s|S) ;;
    *) log "UNINSTALL: cancelado"; exit 0 ;;
  esac

  if [ "${DRY_RUN}" = "1" ]; then
    printf '[DRY_RUN] rm -rf %s\n' "${INSTALL_DIR}"
    exit 0
  fi

  rm -rf "${INSTALL_DIR}"
  log "UNINSTALL: completado"
  exit 0
}

install_ollama_if_missing() {
  local platform
  platform="$(detect_platform)"

  if command -v ollama >/dev/null 2>&1; then
    log "OLLAMA: ya existe"
    return 0
  fi

  if [ "${platform}" != "linux" ] && [ "${platform}" != "macos" ]; then
    log "ERROR: plataforma no soportada para instalar ollama. Usa Linux o macOS."
    exit 1
  fi

  log "OLLAMA: instalando desde https://ollama.ai/install.sh"
  if [ "${DRY_RUN}" = "1" ]; then
    printf '[DRY_RUN] curl -fsSL https://ollama.ai/install.sh | bash\n'
    return 0
  fi

  curl -fsSL https://ollama.ai/install.sh | bash
  log "OLLAMA: instalado"
}

install() {
  log "INSTALL: clawdbot-free ${VERSION}"
  run mkdir -p "${INSTALL_DIR}"
  run mkdir -p "${INSTALL_DIR}/workspace"
  run mkdir -p "${INSTALL_DIR}/templates"

  install_ollama_if_missing

  log "INSTALL: completado"
  log "Siguiente paso"
  log "Abre una issue en GitHub si quieres que el instalador también arranque servicios"
}

case "${MODE}" in
  --audit) audit_mode ;;
  --dry-run) DRY_RUN=1; install ;;
  --uninstall) uninstall ;;
  install|*) install ;;
esac
