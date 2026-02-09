#!/usr/bin/env bash
# lock-kiosk.sh - Bloqueio otimizado com supressão total de popups

URL_LEFT="https://threatmap.checkpoint.com/"
URL_RIGHT="https://livethreatmap.radware.com/"
LOCK_PID_FILE="/tmp/screenlock.pid"

# Efeito de flash visual
visual_flash() {
    local monitors=($(xrandr --listmonitors | sed 1d | awk '{print $NF}' | sed 's/^[+*]//'))
    for flash in {1..2}; do
        for monitor in "${monitors[@]}"; do
            xrandr --output "$monitor" --brightness 0.3 2>/dev/null
        done
        sleep 0.08
        for monitor in "${monitors[@]}"; do
            xrandr --output "$monitor" --brightness 1.0 2>/dev/null
        done
        sleep 0.08
    done
}

cleanup_lock() {
    rm -f "$LOCK_PID_FILE"
    pkill -f "chromium.*kiosk" 2>/dev/null || true
    pkill xtrlock 2>/dev/null || true
    i3-msg "mode \"default\"" >/dev/null 2>&1

    # Restaura brilho ao sair
    local monitors=($(xrandr --listmonitors | sed 1d | awk '{print $NF}' | sed 's/^[+*]//'))
    for monitor in "${monitors[@]}"; do
        xrandr --output "$monitor" --brightness 1.0 2>/dev/null
    done

    echo "Sistema desbloqueado!"
    exit 0
}

trap cleanup_lock EXIT INT TERM

# Verifica se já está bloqueado
[ -f "$LOCK_PID_FILE" ] && kill -0 "$(cat "$LOCK_PID_FILE")" 2>/dev/null && {
    echo "Bloqueio já ativo!"
    exit 1
}

echo "=== INICIANDO BLOQUEIO ==="

# Verifica monitores e dependências
mapfile -t MONITORS < <(xrandr --listmonitors | sed 1d)
[ "${#MONITORS[@]}" -lt 2 ] && {
    echo "Precisa de 2+ monitores!"
    exit 1
}

for cmd in chromium jq xtrlock; do
    command -v "$cmd" >/dev/null || {
        echo "$cmd não encontrado!"
        exit 1
    }
done

# Extrai outputs
OUTPUT1=$(echo "${MONITORS[0]}" | awk '{print $NF}' | sed 's/^[+*]//')
OUTPUT2=$(echo "${MONITORS[1]}" | awk '{print $NF}' | sed 's/^[+*]//')

echo "Detectando workspaces por monitor..."

# Função para testar workspace em qual output aparece
test_workspace() {
    local ws="$1"
    i3-msg "workspace $ws" >/dev/null 2>&1
    sleep 0.5
    i3-msg -t get_workspaces | jq -r ".[] | select(.name==\"$ws\") | .output"
}

# Testa vários workspaces para encontrar um para cada monitor
WS_MON1="" WS_MON2=""

for ws in {1..20}; do
    output=$(test_workspace "$ws")

    if [ "$output" = "$OUTPUT1" ] && [ -z "$WS_MON1" ]; then
        WS_MON1="$ws"
    elif [ "$output" = "$OUTPUT2" ] && [ -z "$WS_MON2" ]; then
        WS_MON2="$ws"
    fi

    # Para quando encontrar ambos
    [ -n "$WS_MON1" ] && [ -n "$WS_MON2" ] && break
done

# Fallback se não encontrou workspace para monitor 2
if [ -z "$WS_MON2" ]; then
    echo "Forçando workspace no monitor 2..."
    i3-msg "workspace 99; move workspace to output $OUTPUT2" >/dev/null 2>&1
    WS_MON2="99"
fi

echo "Monitor 1 ($OUTPUT1): Workspace $WS_MON1"
echo "Monitor 2 ($OUTPUT2): Workspace $WS_MON2"

echo $$ >"$LOCK_PID_FILE"

# Aplica efeito de flash antes de abrir navegadores
visual_flash

# Função para abrir Chromium
open_chromium() {
    local workspace="$1" url="$2" name="$3"

    i3-msg "workspace $workspace" >/dev/null 2>&1
    sleep 0.5

    chromium --kiosk --app="$url" \
        --disable-infobars \
        --disable-session-crashed-bubble \
        --disable-restore-session-state \
        --disable-features=Translate &
    local pid=$!
    sleep 3

    i3-msg "fullscreen enable" >/dev/null 2>&1
    echo "✓ Chromium $name carregando $url (PID: $pid)"
}

echo "Abrindo navegadores..."
open_chromium "$WS_MON1" "$URL_LEFT" "Monitor1"
open_chromium "$WS_MON2" "$URL_RIGHT" "Monitor2"

i3-msg "workspace $WS_MON1" >/dev/null 2>&1

echo ""
echo "🔒 BLOQUEIO ATIVO 🔒"
echo "Alternar: Super+$WS_MON1 / Super+$WS_MON2"
echo ""

xtrlock 2>/dev/null || {
    echo "Pressione Ctrl+C para desbloquear"
    while [ -f "$LOCK_PID_FILE" ]; do sleep 5; done
}
