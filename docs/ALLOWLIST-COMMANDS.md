# Allowlist de comandos v0.3

shell permitido
- ls
- cat
- head
- tail
- wc
- grep
- sed
- awk
- find

docker permitido
- docker ps
- docker compose ps
- docker compose up -d
- docker compose down

Regla
Si un comando no está en esta lista, se bloquea.
