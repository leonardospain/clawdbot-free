# 🦞 clawdbot-free v2.0 — Multi-Agent Selector

**clawdbot-free** es un instalador interactivo para configurar agentes de IA locales con Ollama. 100% libre, sin APIs pagadas, sin tarjetas.

> Modificado por Leonardo Spain (España)

## ✅ Lo que HACE HOY

- 🧠 **Selector interactivo** de agentes especializados:
  - Comms-Agent (Emails/Redes sociales)
  - IoT-Agent (Control dispositivos locales)
  - Secretary-Agent (Calendario básico, alertas)
  - Research-Agent (Búsquedas web con DuckDuckGo/Brave)
  - Alert-Agent (Notificaciones push)
  - Planner-Agent (Divide objetivos en pasos con tu OK)

- 📦 **Instalación automática** de Ollama si no está presente
- 🌐 **Detección automática** de plataforma (Linux/macOS/WSL2)
- 🌍 **Selector de idioma** (Español/Inglés/Rumano)
- 🔒 **Configuración local** en `~/.clawdbot/config.json` (nunca envía datos sin tu OK)
- ♻️ **Desinstalador limpio** (`uninstall.sh` borra ~/.clawdbot y wrapper)

## ❌ Lo que NO hace (aún)

- ❌ No scrapea Google Maps ni sitios web
- ❌ No envía emails automáticamente
- ❌ No integra calendarios (Google/Outlook)
- ❌ No monitoriza respuestas de restaurantes/hoteles
- ❌ No realiza reservas automáticas

> Estas capacidades requerirían APIs pagadas o acceso a sistemas privados. Se evaluarán en futuras versiones con código 100% auditable.

## 🚀 Instalar

```bash
curl -fsSL https://raw.githubusercontent.com/leonardospain/clawdbot-free/main/install.sh | bash
```

## 🔍 Auditoría para usuarios desconfiados

```bash
# 1. Descargar SIN ejecutar:
curl -fsSL https://raw.githubusercontent.com/leonardospain/clawdbot-free/main/install.sh -o install.sh

# 2. Verificar sintaxis:
bash -n install.sh

# 3. Revisar contenido:
less install.sh

# 4. Buscar comandos peligrosos:
grep -nE "rm -rf|sudo|chmod 777|curl.*http" install.sh
```

## 📄 Documentación

- [docs/WINDOWS.md](docs/WINDOWS.md): Guía WSL2 para Windows

## ⚠️ Filosofía 100% clara

✅ Todo lo que instalas es 100% gratis para siempre
✅ Sin tarjetas, sin pruebas, sin sorpresas
✅ Tus datos nunca salen de tu máquina sin tu OK explícito
⚠️ Si una opción NO aparece en el instalador: no es 100% gratis o seguro

## 🔍 SEO

clawdbot, clawdbot-free, multi-agente, LLM local, Ollama, privacidad IA, España, Leonardo Spain

> ✉️ https://github.com/leonardospain/clawdbot-free
