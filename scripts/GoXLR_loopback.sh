#!/bin/bash

# Wait up to 30 seconds for GoXLR Mini to be detected
for i in {1..30}; do
    if lsusb | grep -q "GoXLRMini"; then
        echo "GoXLR Mini detected"
        break
    fi
    sleep 1
done

# If it's still not detected, exit
if ! lsusb | grep -q "GoXLRMini"; then
    echo "GoXLR Mini not detected after waiting"
    exit 1
fi

# Wait up to 30 seconds for PulseAudio or PipeWire to list the source/sink
for i in {1..30}; do
    Source=$(pactl list short sources | while read -r line; do
        name=$(echo "$line" | awk '{print $2}')
        index=$(echo "$line" | awk '{print $1}')
        desc=$(pactl list sources | awk -v idx="Source #$index" -v RS="" '$0 ~ idx {print}' | grep -i "Description" | cut -d: -f2-)
        if echo "$desc" | grep -qi "GoXLRMini Broadcast Stream Mix"; then
            echo "$name"
            break
        fi
    done)

    Sink=$(pactl list short sinks | grep -i "rog\|fusion" | awk '{print $2}')

    if [[ -n "$Source" && -n "$Sink" ]]; then
        echo "Found both Source and Sink"
        break
    fi

    sleep 1
done

# Exit if we couldn't find both
if [[ -z "$Source" || -z "$Sink" ]]; then
    echo "Could not find audio source or sink"
    exit 1
fi

# Load loopback module
pactl load-module module-loopback source="$Source" sink="$Sink"
