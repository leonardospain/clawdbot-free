# 📡 clawdbot Comms-Agent

Gestor de comunicaciones con **tu permiso explícito** en cada acción. Solo APIs gratuitas.

## ✅ Servicios soportados (gratuitos 2026)

| Servicio | API | Límite | Estado |
|----------|-----|--------|--------|
| Gmail | Gmail API v1 | 15k llamadas/día | ✅ Viable |
| Reddit | Reddit API OAuth | 60 llamadas/min | ✅ Viable |
| Telegram | Bot API | Ilimitado | ✅ Ideal |
| Outlook | Microsoft Graph | 10k llamadas/día | ✅ Viable |
| Mastodon | ActivityPub | Sin límites | ✅ Viable |
| Instagram | ❌ API pública eliminada | — | No viable |
| Facebook | ❌ Requiere aprobación Meta | — | No viable |

## 🔐 Principio fundamental

> **clawdbot NUNCA actúa sin tu permiso explícito.**

Ejemplo:
```
🔔 Nuevo email de seguros@company.es
   Asunto: Renovación póliza 2026

   ¿Acción?
   [1] Leer completo
   [2] Responder: \"Gracias, revisaré pronto\"
   [3] Ignorar

Tu elección: ▢
```

## ⚙️ Instalación

```bash
# Habilitar Gmail (requiere configurar OAuth2 después)
clawdbot-comms enable gmail

# Habilitar Telegram (requiere token de @BotFather)
clawdbot-comms enable telegram

# Habilitar Reddit DMs
clawdbot-comms enable reddit

# Escanear todos los servicios habilitados
clawdbot-comms scan
```

## 🔑 Configuración manual requerida

### Gmail
1. Ve a https://console.cloud.google.com/
2. Crea proyecto → Habilita \"Gmail API\"
3. Crea credenciales OAuth2 (tipo \"Aplicación de escritorio\")
4. Descarga `credentials.json` → guárdalo en `~/.clawdbot/tokens/gmail-credentials.json`
5. Primera ejecución abre navegador para autorizar → token guardado en `~/.clawdbot/tokens/gmail.token`

### Telegram
1. Habla con @BotFather en Telegram
2. Crea bot → obtén token
3. Edita `~/.clawdbot/comms.json`:
```json
\"telegram\": {
  \"enabled\": true,
  \"bot_token\": \"TU_TOKEN_AQUI\",
  \"chat_id\": \"TU_CHAT_ID\"
}
```

## ⚠️ Privacidad

- Tokens almacenados **solo en tu máquina** (`~/.clawdbot/tokens/`)
- Contenido procesado **offline** con tu LLM local
- **Nunca** se envían emails/mensajes a servidores externos sin tu OK
- Puedes desactivar todo con: `clawdbot-comms disable`

## 💡 Flujo realista

```
[clawdbot]
1. Escanea Gmail → detecta email nuevo
2. Procesa offline con tu LLM → genera resumen
3. Te avisa: \"Nuevo email de X. ¿Leer/responder/ignorar?\"
4. Tú eliges → clawdbot ejecuta SOLO esa acción
```

## ❌ Lo que NO hace clawdbot

- ❌ Leer Instagram/Facebook (APIs bloqueadas por Meta)
- ❌ Responder sin tu permiso
- ❌ Enviar datos a servidores externos
- ❌ Usar APIs pagadas

## 🌐 Keywords SEO

clawdbot, clawdbot-free, multi-agente, agente autónomo, Gmail API gratuito, Telegram Bot API, Reddit API, Mastodon, privacidad AI, automatización email, sin APIs pagadas, Leonardo Spain, España, código abierto
