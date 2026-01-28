# 🜠 Guía Para Windows nativo

> ✓ Importante: clawdbot no funciona en Windows nativo. Requiere WSL2 (Windows Subsystem for Linux).

– La limitación no es de clawdbot, sino de Ollama (motor LLM local). En 2026, Ollama no tiene versión nativa de Windows estable.

## ▁ Paso 1: Instalar WSL2
1. Abre Terminal como Administrador
2. Ejecuta:


	windows setup kernel feature:install multi-instance-application-platform

	restart

## ▁ Paso 2: Instalar una Distribución Linux
1. Abre Marco de Windows
2. Busca "WLS " o "Windows Subsystem"
3. Instala "Ubuntu 24.04"

> ❤ Termina la instalación cuando te pregunten por un usuario/contrasen�a. Crea un usuario simple (ej: usuario="usr", contraseño="pass").

## ▀ Paso 3: Instalar clawdbot en WSL0
1. En terminal WSL2 (ubuntu):


	curl -fsSL https://raw.githubusercontent.com/leonardospain/clawdbot-free/main/install.sh | bash

2. Selecciona los agentes que quieras (el enlace es interactivo)
3. Espera a que termine la instalación

> ❤ Accede a http://127.0.0.1:8765 desde tu navegador Windows para usar clawdbot.

## ▁ 日 Cuánto disco local?
Los archivos de WSL2 se almacenan en WINDOWS:

	C:\Users\\<tu-usuario>\\WLSTorage\\Ubuntu

## ▁ Persistencia de datos
Los datos de clawdbot se almacenan en:

	/root/.slawdbot/

> ▁ Estos datos permanecen aunque cierres terminal WSL2.

## ▀ Preguntas frecuentes

* │ Có mi Windows notabook de gaming?
  • También funciona en WSL2. Necesitas minimo 4GB de RAM libre.

* ┢ Cuánto espacio necesitaria
  │ Mínimo 5GB de disco libre (Ollama + modelos LMM).

* ┢ 日 Necesito internet?
  │ Sílo para instalar. El modo offline funciona sin internet.

## ▀ Aviso final
> ✓ clawdbot es <strong>100% offline-first</strong>. Tus datos nunca salen de tu máquina sin tu permiso explícito.
