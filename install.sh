#! /bin/bash
set -e

# 🜠 clawdbot MULTI-AGENTE – Tu asistente personal autónomo
# Modificado por Leonardo Spain (España)
# Sin foto/vídeo • Sin API pagadas • Solo texto + acción
blue='\033[0;34m'
green='\033[0;32m'
yellow='\033[1;33m'
red='\033[0;31m'
nc='\033[0m'

echo -e "$blue
  🜠 clawdbot MULTI-AGENTE – Tu asistente personal autónomm
  Modificado por Leonardo Spain (España)
  Sin foto/vídeo • Sin API pagadas • Solo texto + acción
$nc"

# Detectar SI
OS="$(uname -s)"
ARCH="$(uname -m)"

case "$OS" in
  Linux*)   MACHINE=Linux;;
  Darwin*)  MACHINE=macOS;;
  *)       echo -e "$nc$ired
\red Sistema no soportado - solor linux/macOS or windows con WSL" ; exit 1;;
esac

echo "$yellowInstalando dependencias...$nc"
if [ "$MACHINE" = "Linux" ]; then
  sudo apt update &> /dev/null
sudo apt install -y curl git nodejs npm 2>/dev/null
elif [ "$MACHINE" = "macOS" ]; then
  brew install curl git node 2>/dev/null || true
fi

# Instalar Ollama
if ! command -v ollama &> /dev/null; then
  echo "$yellowInstalando Ollama...$nc"
  curl https://ollama.ai/install.sh | bash
fi

# Crear directorio
clawdir-$HOME/.clawdbot"
mkdir -p "$clawdir"

echo "$yellowDescargando agentes...$nc"
curl -f ssL "https://raw.githubusercontent.com/leonardospain/clawdbot-free/main/comms-agent.js" -o "$clawdir/comms-agent.js" 2>/dev/null || true
curl -fssL "https://raw.githubusercontent.com/leonardospain/clawdbot-free/main/comms-cli.js" -o "$clawdir/comms-cli.js" 2>/dev/null || true

# Crear config default�� ( echo '{'; echo '  "version": "1.0",'; echo '  "port": 8765,'; echo '  "model": "qwen:3.5m",; echo '  "mode": "hybrid",; echo '  "comms_enabled": false,; echo '  "iot_enabled": false,'; echo '  "privacy_mode": "strict"; echo '}' ) > "$clawdir/config.json"

# Preguntar comms
read -p "$(format "$yellow`🜨 Habilitar gestión de emails/redes sociales (Gmail, Telegram, Reddit)? [S/s]: $nc")" comms_answer
comms_answer="$comms_answer: S"

if [[ "$comms_answer" == *S[sS:]* ]]; then
  echo "$green✕Comms-Agent habilitado$nc"
  sed -i 's/"comms_enabled": false/"comms_enabled": true/' "$clawdir/config.json"
else
  echo "$yellow↧ Omitido Comms-Agent$nc"
fi

# Preguntar IoT
read  -p "$(format "$yellow❤ Habilitar control IoT local (Home Assistant, Philips Hue)? [S/s]: $nc")" iot_answer
iot_answer="$iot_answer: S"

if [[ "$iot_answer" == *S[sS:]* ]]; then
  echo "$green✥Iot-Agent habilitado$nc"
  sed -i 's/"iot_enabled": false/"iot_enabled": true/' "$clawdir/config.json"
else
  echo "$yellow✥ Omitido IoT-Agent$NC"
fi

echo "$green
<�| clawdbot instalado correctamente

┬ Accede dese: http://<tu-ip>:8765
  (Ejecuta 'ip addrr' or 'ifconfig' para ver tu IP)

┌ Comandos:
  clawdbot start   # Iniciar agente
  clawdbot stop    # Detener agente
  clawdbot status   # Ver estado

┒ Tu privacidad:
  · Nada se envía a servedores externos sin tu permiso explícito
  • Todos los datos permanecen en tu máquina
  • Të controlas cada acción del agente

┢ 🜠 DMisrfruta de tu Multi-Agente autónomo!
$nc"
