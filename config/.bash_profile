# Source interactive bash settings
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Only run loopback setup if GoXLR Mini is connected
if lsusb | grep -q "GoXLRMini"; then
    # Find the GoXLR Mini Broadcast Stream Mix source
    Source=$(pactl list short sources | while read -r line; do
        name=$(echo "$line" | awk '{print $2}')
        index=$(echo "$line" | awk '{print $1}')
        desc=$(pactl list sources | awk -v idx="Source #$index" -v RS="" '$0 ~ idx {print}' | grep -i "Description" | cut -d: -f2-)
        if echo "$desc" | grep -qi "GoXLRMini Broadcast Stream Mix"; then
            echo "$name"
            break
        fi
    done)

    # Find the ASUS ROG Strix Fusion output sink
    Sink=$(pactl list short sinks | grep -i "rog\|fusion" | awk '{print $2}')

    # Load loopback if both source and sink were found
    if [[ -n "$Source" && -n "$Sink" ]]; then
        pactl load-module module-loopback source="$Source" sink="$Sink"
    fi
fi

# Start X on TTY1
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    startx
fi
