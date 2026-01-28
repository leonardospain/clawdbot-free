#!/usr/bin/env bash
set -euo pipefail

PLAN="${1:-}"
if [ -z "${PLAN}" ] || [ ! -f "${PLAN}" ]; then
  echo "ERROR: uso: executor.sh /ruta/a/plan.json"
  exit 1
fi

WORKSPACE_DIR="$(cd "$(dirname "${PLAN}")" && pwd)"
LOG_FILE="${WORKSPACE_DIR}/logs/executor.log"
mkdir -p "${WORKSPACE_DIR}/output" "${WORKSPACE_DIR}/logs"

log() {
  printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$1" | tee -a "${LOG_FILE}" >/dev/null
}

confirm() {
  local msg="$1"
  printf '%s [s/N]: ' "${msg}"
  read -r ans
  case "${ans}" in s|S) return 0 ;; *) return 1 ;; esac
}

is_allowed_shell() {
  case "$1" in
    ls|cat|head|tail|wc|grep|sed|awk|find) return 0 ;;
    *) return 1 ;;
  esac
}

is_allowed_docker() {
  case "$*" in
    "docker ps"|"docker compose ps"|"docker compose up -d"|"docker compose down") return 0 ;;
    *) return 1 ;;
  esac
}

log "Executor v0.3"
log "Plan: ${PLAN}"

python3 - <<'PY' "${PLAN}" "${WORKSPACE_DIR}" 2>/dev/null > "${WORKSPACE_DIR}/output/steps.ndjson"
import json,sys
plan_path=sys.argv[1]
workspace=sys.argv[2]
plan=json.load(open(plan_path))
for step in plan.get("steps",[]):
    print(json.dumps(step, ensure_ascii=False))
PY

while IFS= read -r step; do
  tool="$(python3 - <<'PY' "$step"
import json,sys
d=json.loads(sys.argv[1])
print(d.get("tool",""))
PY
)"
  action="$(python3 - <<'PY' "$step"
import json,sys
d=json.loads(sys.argv[1])
print(d.get("action",""))
PY
)"
  req="$(python3 - <<'PY' "$step"
import json,sys
d=json.loads(sys.argv[1])
print("1" if d.get("requires_confirmation",False) else "0")
PY
)"

  log "Paso: ${action} [${tool}]"

  if [ "${tool}" = "file" ]; then
    printf '%s\n' "${action}" >> "${WORKSPACE_DIR}/output/result.txt"
    log "OK: escrito en workspace"
    continue
  fi

  if [ "${tool}" = "shell" ]; then
    cmd="${action}"
    first="${cmd%% *}"

    if ! is_allowed_shell "${first}"; then
      log "BLOQUEADO: shell no permitido: ${first}"
      continue
    fi

    if ! confirm "Confirmar ejecutar shell: ${cmd}"; then
      log "CANCELADO: ${cmd}"
      continue
    fi

    log "RUN: ${cmd}"
    (cd "${WORKSPACE_DIR}" && bash -lc "${cmd}") >> "${LOG_FILE}" 2>&1 || log "ERROR: comando falló"
    continue
  fi

  if [ "${tool}" = "docker" ]; then
    cmd="${action}"

    if ! is_allowed_docker ${cmd}; then
      log "BLOQUEADO: docker no permitido: ${cmd}"
      continue
    fi

    if ! confirm "Confirmar ejecutar docker: ${cmd}"; then
      log "CANCELADO: ${cmd}"
      continue
    fi

    log "RUN: ${cmd}"
    (cd "${WORKSPACE_DIR}" && bash -lc "${cmd}") >> "${LOG_FILE}" 2>&1 || log "ERROR: comando falló"
    continue
  fi

  log "BLOQUEADO: herramienta no permitida"
done < "${WORKSPACE_DIR}/output/steps.ndjson"

log "FIN"
