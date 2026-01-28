# 🦞 clawdbot — Multi-Agente Autónomo Gratuito

**clawdbot** es tu asistente personal de código abierto con sistema multi-agente especializado. 100% gratuito, sin APIs pagadas, sin foto/vídeo. Repositorio oficial: **clawdbot-free**.

> Modificado por Leonardo Spain (España)  
> clawdbot: tu agente autónomo offline/híbrido para tareas inteligentes

---

## 🔑 ¿Qué es clawdbot?

**clawdbot** es un sistema de **multi-agentes especializados** que funciona 100% en tu máquina:
- 🧠 **Coordinador**: decide qué agente usar según tu tarea
- 🔍 **Investigador**: busca datos actuales (hoteles, vuelos, emergencias)
- 📊 **Analista**: razonamiento profundo y comparaciones lógicas
- ⚡ **Ejecutor**: sugiere acciones proactivas ("¿reservo este hotel?")
- 🧠 **Memoria**: recuerda tus preferencias a largo plazo (90 días)

**clawdbot** no procesa fotos ni vídeos — solo texto inteligente y acción autónoma.

---

## ✅ Características de clawdbot

| Característica | Detalle |
|----------------|---------|
| **100% gratuito** | Sin suscripciones, sin APIs pagadas — clawdbot es libre |
| **Offline/Híbrido** | clawdbot funciona offline + búsquedas online solo cuando es necesario |
| **Privacidad** | Tus datos nunca salen de tu máquina — clawdbot respeta tu privacidad |
| **Multi-idioma** | clawdbot en español por defecto (configurable) |
| **Acceso flexible** | clawdbot accesible vía LAN local o Tailscale (opcional) |
| **7 modelos LLM** | clawdbot compatible con Qwen, Mistral, Phi, Llama3 (todos gratuitos) |

---

## ⚙️ Requisitos para clawdbot

```
# Ubuntu/Debian
sudo apt install nodejs npm git curl -y

# macOS (con Homebrew)
brew install node git curl
```

> Node.js 18+ requerido. clawdbot instala Ollama automáticamente si no existe.

---

## 🚀 Instalar clawdbot

```
curl -fsSL https://raw.githubusercontent.com/leonardospain/clawdbot-free/main/install.sh | bash
```

O manualmente:

```
git clone https://github.com/leonardospain/clawdbot-free.git
cd clawdbot-free
chmod +x install.sh
./install.sh
```

El instalador de **clawdbot** te guía paso a paso:
1. Elige tu modelo LLM para clawdbot (7 opciones gratuitas)
2. Selecciona modo: offline puro o híbrido inteligente
3. Puerto HTTP (por defecto: 8765)
4. IP detectada automáticamente por clawdbot
5. Acceso: LAN local o Tailscale (opcional)

---

## ▶️ Usar clawdbot

### Iniciar clawdbot
```
clawdbot start
```

### Acceder a clawdbot
```
http://<tu-ip>:8765
```
Ejemplo: `http://192.168.18.50:8765`

### Detener clawdbot
```
clawdbot stop
```

---

## 🧹 Desinstalar clawdbot

```
curl -fsSL https://raw.githubusercontent.com/leonardospain/clawdbot-free/main/uninstall.sh | bash
```

> clawdbot pide confirmación explícita antes de eliminar nada. Tus archivos personales están a salvo.

---

## 🌐 Modo Híbrido Inteligente de clawdbot

**clawdbot** decide automáticamente cuándo necesita internet:
- ✅ **Busca online** para: precios actuales, hoteles/vuelos, emergencias, eventos 2025-2026
- ❌ **Nunca busca online** para: preguntas generales, razonamiento lógico, tareas offline

Búsquedas sin API keys — solo DuckDuckGo y Brave Search.

---

## 📦 Modelos LLM compatibles con clawdbot

| Modelo | Tamaño | Recomendado para |
|--------|--------|------------------|
| Qwen3 0.6B | ~400MB | Raspberry Pi, máquinas muy limitadas |
| Qwen3 1.7B | ~1GB | Rendimiento rápido en PCs antiguos |
| Qwen3 4B | ~2.3GB | Equilibrio calidad/velocidad (recomendado para clawdbot) |
| Qwen3 8B | ~4.7GB | Máxima calidad en PCs modernos |
| Mistral 7B | ~4.1GB | Excelente razonamiento lógico |
| Phi-3.5-mini | ~2.1GB | Ultra-ligero (Microsoft) |
| Llama3.2 3B | ~2GB | Alternativa Meta |

---

## 🎯 5 Ejemplos de Uso con clawdbot

### Ejemplo 1: Buscar hotel
```
Tú: "Necesito hotel en Madrid para mañana, máximo 80€"

clawdbot (Investigador + Analista):
"Buscando hoteles...
✓ Hotel A: 75€ (4.2★) - 1km centro
✓ Hotel B: 79€ (4.5★) - 3km centro ← RECOMENDADO

clawdbot (Ejecutor):
¿Reservo el Hotel B o busco más opciones?"
```

### Ejemplo 2: Emergencia médica
```
Tú: "Me duele el pecho, ¿qué hago?"

clawdbot (Investigador):
"⚠️ Esto requiere atención médica inmediata.
Hospitales cercanos:
• Hospital La Paz: 917277000 (urgencias 24h)
• Hospital Gregorio Marañón: 914268000

clawdbot:
Llama al 112 ahora mismo. ¿Necesitas que busque rutas?"
```

### Ejemplo 3: Comparar precios
```
Tú: "¿Vale la pena comprar iPhone 16 ahora o esperar?"

clawdbot (Investigador + Analista):
"Buscando precios actuales y rumores...
• iPhone 15 Pro: 1.199€ (disponible)
• iPhone 16 esperado: septiembre 2025
• Análisis: Espera si puedes. El 15 Pro tiene 95% de las funciones del 16.

clawdbot (Ejecutor):
¿Quieres que busque ofertas del 15 Pro hoy?"
```

### Ejemplo 4: Recordar preferencias
```
Tú: "Siempre busco hoteles con piscina"

clawdbot (Memoria):
"✅ Guardado: Prefieres hoteles con piscina.
Próxima búsqueda incluirá este filtro."

[3 días después]
Tú: "Hotel en Valencia para el fin de semana"

clawdbot (Memoria + Investigador):
"Buscando hoteles con piscina en Valencia...
✓ Hotel Las Arenas: 89€ (4.6★) - piscina exterior"
```

### Ejemplo 5: Tarea offline (sin internet)
```
Tú: "Explícame la teoría de la relatividad"

clawdbot (Analista - offline):
"La relatividad de Einstein tiene dos partes:
1. Especial (1905): espacio y tiempo son relativos
2. General (1915): gravedad = curvatura del espacio-tiempo

Ejemplo simple: Si viajas a la velocidad de la luz,
el tiempo pasa más lento para ti que para alguien en la Tierra."
```

---

## ⚠️ Aviso legal de clawdbot

- clawdbot es 100% software libre y gratuito
- clawdbot no recopila datos personales
- clawdbot no usa APIs pagadas ni suscripciones ocultas
- clawdbot no procesa imágenes/vídeo
- clawdbot es código abierto y auditables

---

## 🔍 Keywords para búsqueda (clawdbot)

clawdbot, clawdbot-free, multi-agente, agente autónomo, LLM local, offline AI, Qwen, Mistral, privacidad AI, asistente personal, sin APIs pagadas, España, Leonardo Spain

---

## 🇪🇸 Soporte clawdbot

Problemas o sugerencias: abre un *Issue* en este repositorio.

> clawdbot modificado por Leonardo Spain (España)  
> ✉️ Repositorio oficial clawdbot: https://github.com/leonardospain/clawdbot-free
