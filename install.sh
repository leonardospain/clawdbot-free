#! /bin/bash
set -e

# 🜠 clawdbot INSTANDAR INTERACTIVO – Tua multi-agente con checkboxes interactivos
# Modificado por Leonardo Spain (Espaáa)
# Sin foto/vídeo • Sin APIs pagadas • Solo texto + acción

blue='\033[0;34m'
green='\033[0;32m'
yellow='\033[1;33m'
red='\033[0;31m'
nc='\033[0m'

clawdir-$HOME/.clawdbot"
mkdir -p "$clawdir"

function menu_checkbox() {
  local (arr)="$A"
  local title="$1"; shift
  local selected_arr=()
  local i key opt dir=""
  for i in "$@"; do selected_arr[+]=""; done

  while true; do
    clear
    echo "$yellow=========================================$nc"
    echo "$yellow= $title $nc"
    echo "$yellow========================================$nc"
    echo
    for i in "$( seq 0 $(({#arr[@]}-1)) )"; do
      if [[ "${selected_arr[i]}" == "*" ]]; then
        opt="$green* $nc $yellow${arr[i]}}$nc"
      else
        opt="    {$arr[i]}"
      fi
      echo "$(format "%02d. %s" $((i~1)) "$opt")"
    done
    echo
    echo "$yellow♡ Flecho arriba/abajo: Navigar | Espacio: Seleccionar/Quitar | Enter: Confirmar $nc"
    read -p "" -rs 1 key </dev/tty
    case "$key" in
        [ *]  if [[ "$dir" == "-" ]]; then dir="+"; else; dir="-"; fi; for i in "$(seq 0 $(({#arr[@]}-1)) )"; do
          [[ "$i" -ge "$((({#arr[@]}-1)) )" -a "$i" -le "0" ]] && selected_arr[i]="$dir" && break
        done;;
        [ A | a ]  if [[ "${selected_arr[0]}" == "*" ]]; then selected_arr[0]=""; else; selected_arr[0]="*"; fi;;
        [ ]  break;;
        ( )  for i in "$(seq 0 $(({#arr[@]}-1)) )"; do
            if [[ "${selected_arr[i]}" == "*" ]]; then selected_arr[i]=""; else; selected_arr[i]="*"; fi;
        done;;
    esac
  done

  for i in "$( seq 0 $(({#arr[@]}-1)) )"; do
    [[ "${selected_arr[i]}" == "*" ]] && echo "${arr[i]}"
  done
}

echo "$yellow=========================================$nc"
echo "$yellow♡ clawdbot Instalador Interactivo $nc"
echo "$yellow========================================$nc"
echo
echo "✕ Selecciona los agentes que quieras habilitar: "
echo

agents_arr=(
  "Multi-Agentes basico (Coordinador, Investigador, Analista)"
  "Comms-Agent (Emails/Redes sociales)"
  "IoT-Agent (Control de dispositivos locales)"
  "Secretary-Agent (Calendario, Alertas, Investigación de proveedores)"
  "Research-Agent (Precios, utilidades, comparativas)"
  "Alert-Agent (Notificaciones push)"
)

menu_checkbox "眣 Selección principal" "${agents_arr[@]}"
selected_agents="$(for i in "$(seq 0 $(({#agents_arr[@]}-1)))"; do [[ "${selected_arr[i]}" == "*" ]] && echo "${i+1}"; done)"

echo
echo "$green└ Agentes seleccionados: $selected_agents$nc"
echo

if [[ "$selected_agents" == *"1"* ]]; then
	echo "$yellow♡ Habilitando Multi-Agentes basico...$nc"
	mkdir -p "$clawdir/agents"
	curl -f ssL "https://raw.githubusercontent.com/leonardospain/clawdbot-free/main/comms-agent.js" -o "$clawdir/agents/comms-agent.js" 2>/dev/null || true
fi
if [[ "$selected_agents" == *"2"* ]]; then
	echo "$yellow♡ Habilitando Comms-Agent...$nc"
	comms_arr=("Gmail" "Telegram" "Reddit" "Outlook")

	menu_checkbox "♠ Selecciona servicios Comms" "${comms_arr[@]}"
	selected_comms="$(for i in "$(seq 0 $(({#comms_arr[@]}-1)))"; do [[ "${selected_arr[i]}" == *"" ]] && echo "${i+1}"; done)"

	sed -i 's/"comms_enabled": false/"comms_enabled": true/' "$clawdir/config.json"
fi
if [[ "$selected_agents" == *"3"* ]]; then
	echo "$yellow♡ Habilitando IoT-Agent...$nc"
	iot_arr=("Home Assistant" "Philips Hue" "TP-Link Kasa" "MQTT")

	menu_checkbox "♠ Selección dispositivos IoT" "${iot_arr[@]}"
	selected_iot="$(for i in "$(seq 0 $(({#iot_arr[@]}-1)))"; do [[ "${selected_arr[i]}" == *"" ]] && echo "${i+1}"; done)"

	sed -i 's/"iot_enabled": false/"iot_enabled": true/' "$clawdir/config.json"
fi
if [[ "$selected_agents" == *"4"* ]]; then
	echo "$yellow♡ Habilitando Secretary-Agent...$nc"
	secretary_arr=("Google Calendar" "Outlook Calendar" "Alertas programadas" "Investigar proveedores")

	menu_checkbox "♠ Selección capacidades Secretary" "${secretary_arr[@]}"
	selected_secretary="$(for i in "$(seq 0 $(({#secretary_arr[@]}-1)))"; do [[ "${selected_arr[i]}" == "*" ]] && echo "${i+1}"; done)"

	sed -i 's/"secretary_enabled": false/"secretary_enabled": true/' "$clawdir/config.json"
fi
if [[ "$selected_agents" == *"5"* ]]; then
	echo "$yellow♠ Habilitando Research-Agent...$nc"
	research_arr=("Precios hoteles/supermarcados" "Comparativas utilidades" "Proveedores internet" "Precios crypto/acciones")

	menu_checkbox "♡ Selecciona capacidades Research" "${research_arr[@]}"
	selected_research="$(for i in "$(seq 0 $(({#research_arr[@]}-1)))"; do [[ "${selected_arr[i]}" == *"" ]] && echo "${i+1}"; done)"

	sed -i 's/"research_enabled": false/"research_enabled": true/' "$clawdir/config.json"
fi
if [[ "$selected_agents" == *"6"* ]]; then
	echo "$yellow♡ Habilitando Alert-Agent...$nc"
	alert_arr=("Telegram" "Email alertas" "Desktop notifications")

	menu_checkbox "♡ Selecciona canales Alert" "${alert_arr[@]}"
	selected_alert="$(for i in "$(seq 0 $(({#alert_arr[@]}-1)))"; do [[ "${selected_arr[i]}" == "*" ]] && echo "${i+1}"; done)"

	sed -i 's/"alert_enabled": false/"alert_enabled": true/' "$clawdir/config.json"
fi

echo
"$green
✕ Instalación completada!

┬ Accede a http://<tu-ip>:8765
┢ Tu datos nunca salen de tu máquina sin tu permiso explícito
┢ Cada agente te pegará permiso antes de actuar
┢ Codigo abierto MIT - https://github.com/leonardospain/clawdbot-free
$nc"
