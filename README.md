# 🦞 Clawdbot MULTI-AGENTE

Tu asistente personal autónomo — 100% gratuito, sin APIs pagadas, sin foto/vídeo.

> Modificado por Leonardo Spain (España)  
> Repositorio público libre para todos

---

## 🔑 ¿Qué es?

Un sistema de **multi-agentes especializados** que:
- 🧠 **Coordinador**: decide qué agente usar según tu tarea
- 🔍 **Investigador**: busca datos actuales (hoteles, vuelos, emergencias)
- 📊 **Analista**: razonamiento profundo y comparaciones lógicas
- ⚡ **Ejecutor**: sugiere acciones proactivas ("¿reservo este hotel?")
- 🧠 **Memoria**: recuerda tus preferencias a largo plazo (90 días)

**Sin foto/vídeo** — solo texto inteligente y acción.

---

## ✅ Características

| Característica | Detalle |
|----------------|---------|
| **100% gratuito** | Sin suscripciones, sin APIs pagadas |
| **Offline/Híbrido** | Base offline + búsquedas online solo cuando es necesario |
| **Privacidad** | Tus datos nunca salen de tu máquina |
| **Multi-idioma** | Español por defecto (configurable) |
| **Acceso flexible** | LAN local o Tailscale (opcional) |
| **7 modelos LLM** | Desde ultra-mini (400MB) hasta estándar (4.7GB) |

---

## ⚙️ Requisitos previos

```
# Ubuntu/Debian
sudo apt install nodejs npm git curl -y

# macOS (con Homebrew)
brew install node git curl
```

> Node.js 18+ requerido. Ollama se instala automáticamente si no existe.

---

## 🚀 Instalación

```
curl -fsSL https://raw.githubusercontent.com/leonardospain/clawdbot-free/main/install.sh | bash
```

O descarga manualmente:

```
git clone https://github.com/leonardospain/clawdbot-free.git
cd clawdbot-free
chmod +x install.sh
./install.sh
```

El instalador te guiará paso a paso:
1. Elige tu modelo LLM (7 opciones gratuitas)
2. Selecciona modo: offline puro o híbrido inteligente
3. Puerto HTTP (por defecto: 8765)
4. IP detectada automáticamente (puedes cambiarla si quieres)
5. Acceso: LAN local o Tailscale (opcional)

---

## ▶️ Uso

### Iniciar el Multi-Agente
```
clawdbot start
```

### Acceder desde navegador
El instalador muestra tu URL directa:
```
http://<tu-ip>:8765
```
Ejemplo: `http://192.168.18.50:8765`

### Detener el Multi-Agente
```
clawdbot stop
```

---

## 🧹 Desinstalación

```
curl -fsSL https://raw.githubusercontent.com/leonardospain/clawdbot-free/main/uninstall.sh | bash
```

O manualmente:
```
chmod +x uninstall.sh
./uninstall.sh
```

> ⚠️ Pide confirmación explícita antes de eliminar nada. Tus archivos personales están a salvo.

---

## 🌐 Modo Híbrido Inteligente

El agente decide **automáticamente** cuándo necesita internet:
- ✅ **Busca online** para: precios actuales, hoteles/vuelos, emergencias, eventos 2025-2026
- ❌ **Nunca busca online** para: preguntas generales, razonamiento lógico, tareas offline

Búsquedas sin API keys — solo DuckDuckGo y Brave Search.

---

## 📦 Modelos LLM gratuitos disponibles

| Modelo | Tamaño | Recomendado para |
|--------|--------|------------------|
| Qwen3 0.6B | ~400MB | Raspberry Pi, máquinas muy limitadas |
| Qwen3 1.7B | ~1GB | Rendimiento rápido en PCs antiguos |
| Qwen3 4B | ~2.3GB | Equilibrio calidad/velocidad (recomendado) |
| Qwen3 8B | ~4.7GB | Máxima calidad en PCs modernos |
| Mistral 7B | ~4.1GB | Excelente razonamiento lógico |
| Phi-3.5-mini | ~2.1GB | Ultra-ligero (Microsoft) |
| Llama3.2 3B | ~2GB | Alternativa Meta |

---

## ⚠️ Aviso legal

- 100% software libre y gratuito
- Sin recopilación de datos personales
- Sin APIs pagadas ni suscripciones ocultas
- Sin procesamiento de imágenes/vídeo
- Código abierto y auditables

---

## 🇪🇸 Soporte

Problemas o sugerencias: abre un *Issue* en este repositorio.

> Modificado por Leonardo Spain (España)  
> ✉️ Repositorio: https://github.com/leonardospain/clawdbot-free
