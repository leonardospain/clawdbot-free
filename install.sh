#!/usr/bin/env bash
set -euo pipefail

VERSION="v2.0.2"
INSTALL_DIR="${HOME}/.clawdbot"
LOG_FILE="${INSTALL_DIR}/install.log"
DRY_RUN="${DRY_RUN:-0}"
MODE="${1:-install}"

mkdir -p "${INSTALL_DIR}" 2>/dev/null || true
touch "${LOG_FILE}" 2>/dev/null || true

log() { printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$1" | tee -a "${LOG_FILE}"; }

run() {
  log "RUN: $*"
  if [ "${DRY_RUN}" = "1" ]; then
    printf '[DRY_RUN] %s\n' "$*"
    return 0
  fi
  "$@"
}

audit_mode() {
  cat <<EOF_AUDIT
=== AUDIT clawdbot-free ${VERSION} ===
Rutas que crea:
  ${INSTALL_DIR}/
  ${INSTALL_DIR}/workspace/
  ${INSTALL_DIR}/templates/
  ${INSTALL_DIR}/bin/
  ${LOG_FILE}

Acciones:
  - Detecta plataforma con uname -s
  - Si falta ollama y la plataforma es linux o macos, descarga e instala desde:
      https://ollama.ai/install.sh
  - Copia binarios desde el repo a ${INSTALL_DIR}/bin
  - Copia docker-compose.yml desde el repo a ${INSTALL_DIR}/docker-compose.yml
  - No usa sudo
  - No modifica .bashrc ni .zshrc
  - No abre firewall
  - No crea servicios de arranque

Modos:
  --audit
  --dry-run
  --uninstall
EOF_AUDIT
  exit 0
}

uninstall() {
  log "UNINSTALL: inicio"
  printf 'Confirmar borrado total de %s ? [s/N]: ' "${INSTALL_DIR}"
  read -r CONFIRM
  case "${CONFIRM}" in
    s|S) run rm -rf "${INSTALL_DIR}"; log "UNINSTALL: completado" ;;
    *) log "UNINSTALL: cancelado" ;;
  esac
  exit 0
}

install_ollama_if_missing() {
  if command -v ollama >/dev/null 2>&1; then
    log "OLLAMA: ya existe"
    return 0
  fi

  os="$(uname -s)"
  case "${os}" in
    Linux|Darwin) ;;
    *) log "ERROR: plataforma no soportada para instalar ollama. Usa Linux o macOS."; exit 1 ;;
  esac

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
  run mkdir -p "${INSTALL_DIR}/bin"

  if [ -f "${PWD}/bin/clawdbot" ]; then
    run cp "${PWD}/bin/clawdbot" "${INSTALL_DIR}/bin/clawdbot"
    run chmod +x "${INSTALL_DIR}/bin/clawdbot"
    log "COPIA: clawdbot -> ${INSTALL_DIR}/bin/clawdbot"
  else
    log "AVISO: no existe ${PWD}/bin/clawdbot"
  fi

  if [ -f "${PWD}/bin/executor.sh" ]; then
    run cp "${PWD}/bin/executor.sh" "${INSTALL_DIR}/bin/executor.sh"
    run chmod +x "${INSTALL_DIR}/bin/executor.sh"
    log "COPIA: executor.sh -> ${INSTALL_DIR}/bin/executor.sh"
  else
    log "AVISO: no existe ${PWD}/bin/executor.sh"
  fi

  if [ -f "${PWD}/bin/validate_plan.py" ]; then
    run cp "${PWD}/bin/validate_plan.py" "${INSTALL_DIR}/bin/validate_plan.py"
    log "COPIA: validate_plan.py -> ${INSTALL_DIR}/bin/validate_plan.py"
  else
    log "AVISO: no existe ${PWD}/bin/validate_plan.py"
  fi

  install_ollama_if_missing

  if [ -f "${PWD}/docker-compose.yml" ]; then
    run cp "${PWD}/docker-compose.yml" "${INSTALL_DIR}/docker-compose.yml"
    log "COPIA: docker-compose.yml -> ${INSTALL_DIR}/docker-compose.yml"
  else
    log "AVISO: no existe ${PWD}/docker-compose.yml"
  fi

  log "INSTALL: completado"
  log "Siguiente paso"
  log "Arranca: docker compose -f ${INSTALL_DIR}/docker-compose.yml up -d"
  log "Diagnóstico: ${INSTALL_DIR}/bin/clawdbot doctor"
}

case "${MODE}" in
  --audit) audit_mode ;;
  --dry-run) DRY_RUN=1; install ;;
  --uninstall) uninstall ;;
  install|*) install ;;
esac
