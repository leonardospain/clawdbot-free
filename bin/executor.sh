#!/usr/bin/env bash
set -euo pipefail

PLAN="$1"
WORKSPACE_DIR="$(dirname "$PLAN")"

if [ ! -f "$PLAN" ]; then
  echo "ERROR: plan no encontrado"
  exit 1
fi

echo "Ejecutor v0.2"
echo "Plan: $PLAN"
echo

python3 - <<'PY' "$PLAN" "$WORKSPACE_DIR"
import json,sys,os

plan_path=sys.argv[1]
workspace=sys.argv[2]

plan=json.load(open(plan_path))
steps=plan.get("steps",[])

for step in steps:
    tool=step.get("tool")
    action=step.get("action")
    requires=step.get("requires_confirmation",False)

    print(f"Paso {step.get('id')}: {action} [{tool}]")

    if tool=="file":
        out=os.path.join(workspace,"output","result.txt")
        os.makedirs(os.path.dirname(out),exist_ok=True)
        with open(out,"a") as f:
            f.write(action+"\n")
        print("  OK: escrito en workspace")

    else:
        print("  BLOQUEADO: herramienta no permitida")
PY
