# Formato de plan v0.4

Cada step es un objeto con:
- id: número
- tool: file_write_workspace | file_read | shell | docker
- requires_confirmation: true|false
- expected_output: texto

Campos por tool

file_write_workspace
- path: ruta relativa dentro de workspace
- content: texto a escribir

file_read
- path: ruta a leer
- max_bytes: límite opcional

shell
- cmd: comando
- cwd: workspace

docker
- cmd: comando docker permitido
