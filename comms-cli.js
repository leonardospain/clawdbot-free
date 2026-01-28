#!/usr/bin/env node

// 📡 clawdbot Comms-CLI
// Comandos: enable/disable/status/scan

const CommsAgent = require(\"./comms-agent.js\");
const fs = require(\"fs\").promises;
const path = require(\"path\");

async function initConfig() {
  const configDir = path.join(process.env.HOME, \".clawdbot\");
  const configPath = path.join(configDir, \"comms.json\");
  
  try {
    await fs.access(configPath);
    return;
  } catch (e) {
    await fs.mkdir(configDir, { recursive: true });
    const defaultConfig = {
      \"enabled\": true,
      \"services\": {
        \"gmail\": { \"enabled\": false, \"requires_confirmation\": true },
        \"reddit\": { \"enabled\": false, \"requires_confirmation\": true },
        \"telegram\": { \"enabled\": false, \"requires_confirmation\": true },
        \"outlook\": { \"enabled\": false, \"requires_confirmation\": true },
        \"mastodon\": { \"enabled\": false, \"requires_confirmation\": true }
      },
      \"privacy_mode\": \"strict\"
    };
    await fs.writeFile(configPath, JSON.stringify(defaultConfig, null, 2));
    console.log(\"✅ Configuración inicial creada en ~/.clawdbot/comms.json\");
  }
}

async function enableService(service) {
  await initConfig();
  const configPath = path.join(process.env.HOME, \".clawdbot\", \"comms.json\");
  const config = JSON.parse(await fs.readFile(configPath, \"utf8\"));
  
  if (config.services[service]) {
    config.services[service].enabled = true;
    await fs.writeFile(configPath, JSON.stringify(config, null, 2));
    console.log(`✅ ${service} habilitado. Configura credenciales en ~/.clawdbot/comms.json`);
    console.log(`⚠️  clawdbot NUNCA actúa sin tu permiso explícito.`);
  } else {
    console.log(`❌ Servicio  no soportado. Opciones: gmail, reddit, telegram, outlook, mastodon`);
  }
}

async function main() {
  const cmd = process.argv[2];
  const arg = process.argv[3];

  if (cmd === \"enable\" && arg) {
    await enableService(arg);
  } else if (cmd === \"scan\") {
    const agent = new CommsAgent();
    await agent.scanAll();
  } else {
    console.log(\"📡 clawdbot Comms-Agent\");
    console.log(\"Uso:\");
    console.log(\"  clawdbot-comms enable gmail      # Habilita Gmail (configura OAuth2 después)\");
    console.log(\"  clawdbot-comms enable telegram   # Habilita Telegram (añade token después)\");
    console.log(\"  clawdbot-comms enable reddit     # Habilita Reddit DMs\");
    console.log(\"  clawdbot-comms scan              # Escanea todos los servicios habilitados\");
    console.log(\"\");
    console.log(\"⚠️  APIs gratuitas solamente. Tu permiso explícito requerido para cada acción.\");
  }
}

main().catch(console.error);
