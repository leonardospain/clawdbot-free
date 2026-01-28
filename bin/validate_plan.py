import json,sys,os

plan_path=sys.argv[1]

def fail(msg):
  print(msg)
  sys.exit(1)

try:
  plan=json.load(open(plan_path))
except Exception:
  fail("invalid_json")

if not isinstance(plan, dict):
  fail("plan_not_object")

steps=plan.get("steps")
if not isinstance(steps, list) or len(steps) == 0:
  fail("steps_missing")

allowed_tools={"file_write_workspace","file_read","shell","docker"}

for s in steps:
  if not isinstance(s, dict):
    fail("step_not_object")
  tool=s.get("tool")
  if tool not in allowed_tools:
    fail("tool_invalid")
  if tool=="file_write_workspace":
    path=s.get("path","")
    if not isinstance(path,str) or path=="":
      fail("path_missing")
    if path.startswith("/") or path.startswith("..") or "/.." in path:
      fail("path_invalid")
    content=s.get("content","")
    if not isinstance(content,str):
      fail("content_invalid")
  if tool=="file_read":
    path=s.get("path","")
    if not isinstance(path,str) or path=="":
      fail("path_missing")
    if path.startswith("/") or path.startswith("..") or "/.." in path:
      fail("path_invalid")
  if tool in ("shell","docker"):
    cmd=s.get("cmd","")
    if not isinstance(cmd,str) or cmd.strip()=="":
      fail("cmd_missing")

print("ok")
