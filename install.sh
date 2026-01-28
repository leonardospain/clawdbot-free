#! /bin/bash
set -e

# ðŸœ  clawdbot-free v2.0 - Agente IA Multi-Paso 2026
# Modificado por Leonardo Spain (EspaÃ¡a)
# 100% gratuito - No tarjetas - No pruebas - No datos recopilados
# Licencia MIT - Codigo abierto - Privacidad total

blue='\033[0;34m'
green='\033[0;32m'
yellow='\033[1;33m'
red='\033[0;31m'
nc='\033[0m'

# ---------------------------------------------------------
# Detectar Plataforma
# --------------------------------------------------------
o=""
arch="$(uname -m)"

case "$os" in
  Linux*)    PLATFORM="linux";;
  Darwin*)  PLATFORM="macos";;
  CYGWIN*
  PLATFORM="windows-wsl";;
  MingW**) PLATFORM="windows-wsl";;
  *)       PLATFORM="unknown";;
esac

# Check ollama
if ! command -v ollama >/dev/null 2>&1; then
  if [ "$PLATFORM" = "windows-wsl" ]; then
    echo "$yellowâ™  Windows + WSL2 detectado. Instalando Ollama...$nc"
  elif [ "$PLATFORM" = "macos" ]; then
    echo "$yellowâ™  macOS detectado. Instalando Ollama...$nc"
  elif [ "$PLATFORM" = "linux" ]; then
    echo "$yellowâ™  Linux detectado. Instalando Ollama...$nc"
  else
    echo "$redâ™¡ Plataforma no suportada. Windows nativo requiere WSL2.$nc"
    echo "$yellowâ™  Guia:  https://github.com/leonardospain/clawdbot-free/blob/main/docs/WINDOWS.md$nc"
    exit 1
  fi
  curl https://ollama.ai/install.sh | bash
fi

clawdir-$HOME/.clawdbot"
mkdir -p "$clawdir"
mkdir -p "$clawdir/workspace"
mkdir -p "$clawdir/templates"

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
    echo "$yellowâ™¡ Flecho arriba/abajo: Navigar | Espacio: Seleccionar/Quitar | Enter: Confirmar $nc"
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
echo "$yellowâ™  clawdbot-free v2.0 â€“ Agente IA Multi-Paso 2026 $nc"
echo "$yellow========================================$nc"
echo

echo "âœ• FilosofÃ­a 100% gratuita: No tarjetas, no pruebas, no datos recopilados" 
echo

# --------------------------------------------------------
# Selector de idioma
# ---------------------------------------------------------
echo "$yellowâœ• Selecciona tu idioma (100% gratuito): $nc"
echo

IfISO_ARR=("EspaÃ±ol (ESi" "Engles (EN)" "Rumano (RO)")
menu_checkbox "âœ£ SelecciÃ³n de idioma" "${IfISO_ARR[@]}"
selected_files="$(for i in "$(seq 0 $(({#IfISO_ARR[@]}-1)))"; do [[ "${selected_arr[i]}" == "*" ]] && echo "${i+1}"; done)"
if [[ "$selected_files" == *"1"* ]]; then FILO="es";
elif [[ "$selected_files" == *"2"* ]]; then FILO="en";
elif [[ "$selected_files" == *"3"*" ]]; then FILO="ro";
else file="en";
fi

echo
echo "$greenâ”” Idioma seleccionado: $FILE nacional $nc"
echo


# ---------------------------------------------------------
# Selector de dominio
# --------------------------------------------------------
echo "$yellowâœ• Selecciona tu especializaciÃ³n (Agente Multi-Paso): $n"
echo

DOMAINS_ARR=("Viajes (Hoteles/sUvelos/Itinerarios)" "Negocios (Gastos/Proveedores/EfiÃ³ciencia)" "Inmobiliario (Propiedades/Clientes/Visitas)" "Legal (Documentos/Contratos)" "MÃ©dico (Emergencias/Recordatorios)" "Utilities (Luá½…Ì½Õ„¤ˆ€‰A•ÉÍ½¹…°€¡…±•¹‘…É¥¼½µ…¥±Ì¤ˆ€‰•¹Ñ”=Á•É…Ñ¥Ù¼€¡Q…É•…Ì5Õ±Ñ¤µA…Í¼¤ˆ¤()µ•¹Õ}¡•­‰½à€‹ŠrŒM•±•§Í¸‘”‘½µ¥¹¥¼ˆ€ˆ‘í=5%9M}IImuôˆ)Í•±•Ñ•‘}‘½µ…¥¹Ìôˆ¡™½È¤¥¸€ˆ¡Í•Ä€À€ ¡ì=5%9M}IImuô´Ä¤¤¤ˆì‘¼ml€ˆ‘íÍ•±•Ñ•‘}…ÉÉm¥uôˆ€ôô€ˆ¨ˆut€˜˜•¡¼€ˆ‘í¤¬Åôˆì‘½¹”¤ˆ()¥˜ml€ˆ‘Í•±•Ñ•‘}‘½µ…¥¹Ìˆ€ôô€¨ˆàˆ¨utìÑ¡•¸(€•¡¼€ˆ‘É••»ŠRP½µ¥¹¥¼Í•±•¥½¹…‘¼è•¹Ñ”=Á•É…Ñ¥Ù¼€´5½‘¼•¹Ñ”5Õ±Ñ¤µA…Í¼€‘¹Œˆ(€µ­‘¥È€µÀ€ˆ‘±…Ý‘¥È½Ñ•µÁ±…Ñ•Ì½…•¹Ðˆ(€…Ð€ø€ˆ‘±…Ý‘¥È½Ñ•µÁ±…Ñ•Ì½…•¹Ð½Í•½}…¹…±åÍ¥Ì¹ÑáÐˆ€ðð€=)=‰©•Ñ¥Ù¼è¹…±¥é…ÈÕ¸Í¥Ñ¥¼Ý•ˆ‘”M<()A…Í½Ìè(Ä¸•Í…É…È!Q50‘•°Í¥Ñ¥¼(È¸¹…±¥é…È•ÍÑÉÕÑÕÉ„€¡5•Ñ„Ñ…Ì°!•…‘¥¹Ì°±ÐÑ•áÐ¤(Ì¸	ÕÍ…Èµ•©½É•ÌÁË…Ñ¥…ÌM<€ÈÀÈØ(Ð¸½µÁ…É…ÈÍ¥Ñ¥¼½¸µ•©½É•ÌÁË…Ñ¥…Ì(Ô¸•¹•É…È¥¹™½Éµ”•¸5…É­‘½Ý¸()I•ÍÕ±Ñ…‘¼™¥¹…°è(´ÉÉ½É•ÌËµ‘¥½Ìèm1%MQt(´ÉÉ½É•Ìµ•‘¥½Ìèm1%MQt(´I•½µ•¹‘…¥½¹•Ìèm1%MQt)=œ)™¤()•¡¼(((Œ€´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´(ŒM•±•Ñ½È‘”µ•¹Í…©•Ëµ…Ì€¡A%ÌÉ…ÑÕ¥Ñ…Ì¤(Œ€´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´)•¡¼€ˆ‘å•±±½ßŠr%¹Ñ•É…§Í¸‘”µ•¹Í…©•Ëµ…Ì€¡A%Ì€ÄÀÀ”É…ÑÕ¥Ñ…Ì¤€‘¹Œˆ)•¡¼()5MM9I}IHô ‰Q•±•É…´ˆ€‰¥Í½Éˆ€‰5…ÑÉ¥àˆ¤)µ•¹Õ}¡•­‰½à€‹ŠrŒM•±•¥½¹„‘”µ•¹Í…©•Ë¥…Ìˆ€ˆ‘í5MM9I}IImuôˆ)Í•±•Ñ•‘}µ•ÍÍ•¹•ÉÌôˆ¡™½È¤¥¸€ˆ¡Í•Ä€À€ ¡ì5MM9I}IImuô´Ä¤¤¤ˆì‘¼ml€ˆ‘íÍ•±•Ñ•‘}…ÉÉm¥uôˆ€ôô€ˆ¨ˆut€˜˜•¡¼€ˆ‘í¤¬Åôˆì‘½¹”¤ˆ()•¡¼(((Œ€´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´(ŒM•±•Ñ½È‘”…Á…¥‘…‘•Ì(Œ€´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´)•¡¼€ˆ‘å•±±½ßŠr…Á…¥‘…‘•Ì‘”…•¹Ñ•Ì€ ÄÀÀ”É…ÑÕ¥Ñ…Ì¤è€‘¸ˆ)•¡¼()9QM}IHô (€€‰5Õ±Ñ¤µ•¹Ñ•Ì‹…Í¥¼€¡½½É‘¥¹…‘½È°%¹Ù•ÍÑ¥…‘½È°¹…±¥ÍÑ„¤ˆ(€€‰½µµÌµ•¹Ð€¡µ…¥±Ì½I•‘•ÌÍ½¥…±•Ì¤ˆ(€€‰%½Pµ•¹Ð€¡½¹ÑÉ½°‘”‘¥ÍÁ½Í¥Ñ¥Ù½Ì±½…±•Ì¤ˆ(€€‰M•É•Ñ…Éäµ•¹Ð€¡…±•¹‘…É¥¼°±•ÉÑ…Ì¤ˆ(€€‰I•Í•…É µ•¹Ð€¡AÉ•¥½Ì°½µÁ…É…Ñ¥Ù…Ì¤ˆ(€€‰±•ÉÐµ•¹Ð€¡9½Ñ¥™¥…¥½¹•ÌÁÕÍ ¤ˆ(€€‰A±…¹¹•Èµ•¹Ð€¡5½‘¼•¹Ñ”5Õ±Ñ¤µA…Í¼½¸ÑÔÁ•Éµ¥Í¼¤ˆ(¤)µ•¹Õ}¡•­‰½à€‹ŠrŒM•±•¥½¹„‘”…Á…¥‘…‘•Ìˆ€ˆ‘í9QM}IImuôˆ)Í•±•Ñ•‘}…•¹ÑÌôˆ¡™½È¤¥¸€ˆ¡Í•Ä€À€ ¡ì9QM}IImuô´Ä¤¤¤ˆì‘¼ml€ˆ‘íÍ•±•Ñ•‘}…ÉÉm¥uôˆ€ôô€ˆ¨ˆUt€˜˜•¡¼€ˆ‘í¤¬Åôˆì‘½¹”¤ˆ()¥˜ml€ˆ‘Í•±•Ñ•‘}…•¹ÑÌˆ€ôô€¨ˆØˆ¨utìÑ¡•¸(€•¡¼€ˆ‘É••»
q°A±…¹¹•Èµ•¹Ð¡…‰¥±¥Ñ…‘¼€´•¹Ñ”5Õ±Ñ¤µA…Í¼½¸Á•Éµ¥Í¼•áÁ³µ¥Ñ¼€‘¹Œˆ(€µ­‘¥È€µÀ€ˆ‘±…Ý‘¥È½…•¹ÑÌˆ(€…Ð€ø€ˆ‘±…Ý‘¥È½…•¹ÑÌ½Á±…¹¹•Èµ…•¹Ð¹©Ìˆ€ðð€=)½¹ÍÐ™Ì€ôÉ•ÅÕ¥É” ‰™Ìˆ¤¹ÁÉ½µ¥Í•Ìì)½¹ÍÐÁ…Ñ €ôÉ•ÅÕ¥É” ‰Á…Ñ ˆ¤ì()±…ÍÌA±…¹¹•É•¹Ðì(€½¹ÍÑÉÕÑ½È ¤ì(€€€Ñ¡¥Ì¹Ý½É­ÍÁ…”€ôÁ…Ñ ¹©½¥¸¡ÁÉ½•ÍÌ¹•¹Ø¹!=5°€ˆ¹±…Ý‘‰½Ðˆ°€‰Ý½É­ÍÁ…”ˆ¤ì(€ô((€…Íå¹ŒÁ±…¸¡½‰©•Ñ¥Ù”¤ì(€€€½¹ÍÐÁ±…¸€ô€)=‰©•Ñ¥Ù¼è€‘í½‰©•Ñ¥Ù•ô()•¹•É…ÈÁ±…¸‘”…¥½¹•ÌµÕ±Ñ¤µÁ…Í¼½¸Á•Éµ¥Í¼•áÁ³µ¥Ñ¼è(´A…Í¼€Äèm%=9|Åt(´A…Í¼€Èèm%=9|Ét(´A…Í¼€Ìèm%=9|Ít(´A…Í¼¸èm%=9}¹t()I•ÍÕ±Ñ…‘¼™¥¹…°èmIMU1Q=}%91t)€ì(€€€É•ÑÕÉ¸Á±…¸ì(€ô((€…Íå¹Œ•á•ÕÑ•MÑ•À¡ÍÑ•À°½¹™¥Éµ…±±‰…¬¤ì(€€€½¹ÍÐ½¹™¥Éµ•€ô…Ý…¥Ð½¹™¥Éµ…±±‰…¬¡ÍÑ•À¤ì(€€€¥˜€ …½¹™¥Éµ•¤ì(€€€€€½¹Í½±”¹±½œ ˆ‘íÉ•‘÷ŠrA…Í¼…‰½ÉÑ…‘¼Á½È•°•ÍÑ…‰±•¥µ¥•¹Ñ¼€´¹¥¹Õ¹„…§Í¸•©•ÕÑ…‘„ˆ¤ì(€€€€€É•ÑÕÉ¸™…±Í”ì(€€€ô(€€€É•ÑÕÉ¸ÑÉÕ”ì(€ô)ô()µ½‘Õ±”¹•áÁ½ÉÑÌ€ôA±…¹¹•É•¹Ðì)=œ)™¤()•¡¼)•¡¼€ˆ‘É••¸4+ŠrT%¹ÍÑ…±…§Í¸½µÁ±•Ñ…‘„„€‘¸ˆ)•¡¼()•¡¼€ˆ‘É••»ŠrT•‘”„¡ÑÑÀè¼¼ñÑÔµ¥ÀøèàÜØÔ€¡%¹Ñ•É™…èÝ•ˆ¤€‘¹Œˆ)•¡¼€ˆ‘å•±±½ßŠrT=È½¹•Ñ„„±…Ý‘‰½ÐÙ¥„€¨ÑÔµ•¹Í…©•Ëµ„Í•±•¥½¹…‘„€¨€‘¸ˆ)•¡¼()•¡¼€ˆ‘å•±±½ßŠR˜ÍÑ„¥¹ÍÑ…±…§Í¸•Ì€ÄÀÀ”É…ÑÕ¥Ñ„Á…É„Í¥•µÁÉ”¸ˆ)•¡¼€ˆ‘É•âœ¥M¤Õ¹„½Á§Í¸9<…Á…É•”•¸•ÍÑ”µ•»èèˆ)•¡¼€ˆ€€€9¼•ÍÓ„€ÄÀÀ”É…ÑÕ¥Ñ„¼Í•ÕÉ„¸ˆ)•¡¼€ˆ€€€9½ÌÉ•¡ÕÍ…µ½ÌÁ½ÈÁÉ¥¹¥Á¥¼ƒ¥Ñ¥¼¸‘¹Œˆ)•¡¼()•¡¼€ˆ‘É••¹9¼É•½Á¥±…µ½Ì‘…Ñ½Ì¸9¼½½­¥•Ì¸QÕÌ‘…Ñ½Ì•¸ÑÔ·…ÅÕ¥¹„¸)½‘¥¼…‰¥•ÉÑ¼5%P€´¡ÑÑÁÌè¼½¥Ñ¡Õˆ¹½´½±•½¹…É‘½ÍÁ…¥¸½±…Ý‘‰½Ðµ™É•”‘¹Œˆ