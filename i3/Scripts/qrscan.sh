#!/bin/bash
RESULT=$(maim -qs | convert - +repage -threshold 50% -morphology open square:1 - | zbarimg -q --raw - 2>/dev/null)

if [[ -z "$RESULT" ]]; then
    notify-send "QR Scan" "Nenhum QR Code encontrado." -i dialog-warning
    exit 1
fi

echo -n "$RESULT" | xclip -selection clipboard
notify-send "QR Code" "$RESULT" -i dialog-information
