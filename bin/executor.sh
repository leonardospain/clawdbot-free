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

log "Executor v0.4"
log "Plan: ${PLAN}"

python3 - <<'PY' "${PLAN}" > "${WORKSPACE_DIR}/output/steps.ndjson"
import json,sys
plan=json.load(open(sys.argv[1]))
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

  log "Tool: ${tool}"

  if [ "${tool}" = "file_write_workspace" ]; then
    relpath="$(python3 - <<'PY' "$step"
import json,sys
d=json.loads(sys.argv[1])
print(d.get("path",""))
PY
)"
    content="$(python3 - <<'PY' "$step"
import json,sys
d=json.loads(sys.argv[1])
print(d.get("content",""))
PY
)"
    if [ -z "${relpath}" ]; then
      log "BLOQUEADO: falta path"
      continue
    fi
    if echo "${relpath}" | grep -qE '^\.\.|/'; then
      log "BLOQUEADO: path inválido"
      continue
    fi
    out="${WORKSPACE_DIR}/${relpath}"
    mkdir -p "$(dirname "${out}")"
    printf '%s\n' "${content}" > "${out}"
    log "OK: escrito ${relpath}"
    continue
  fi

  if [ "${tool}" = "file_read" ]; then
    relpath="$(python3 - <<'PY' "$step"
import json,sys
d=json.loads(sys.argv[1])
print(d.get("path",""))
PY
)"
    if [ -z "${relpath}" ]; then
      log "BLOQUEADO: falta path"
      continue
    fi
    if echo "${relpath}" | grep -qE '^\.\.|/'; then
      log "BLOQUEADO: path inválido"
      continue
    fi
    inp="${WORKSPACE_DIR}/${relpath}"
    if [ ! -f "${inp}" ]; then
      log "BLOQUEADO: no existe ${relpath}"
      continue
    fi
    head -c 2000 "${inp}" > "${WORKSPACE_DIR}/output/read_preview.txt" || true
    log "OK: preview en output/read_preview.txt"
    continue
  fi

  if [ "${tool}" = "shell" ]; then
    cmd="$(python3 - <<'PY' "$step"
import json,sys
d=json.loads(sys.argv[1])
print(d.get("cmd",""))
PY
)"
    if [ -z "${cmd}" ]; then
      log "BLOQUEADO: falta cmd"
      continue
    fi
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
    cmd="$(python3 - <<'PY' "$step"
import json,sys
d=json.loads(sys.argv[1])
print(d.get("cmd",""))
PY
)"
    if [ -z "${cmd}" ]; then
      log "BLOQUEADO: falta cmd"
      continue
    fi
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

  log "BLOQUEADO: tool desconocida"
done < "${WORKSPACE_DIR}/output/steps.ndjson"

log "FIN"
