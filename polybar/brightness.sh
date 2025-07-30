#!/usr/bin/env bash

brightness=$(brightnessctl get)
max_brightness=$(brightnessctl max)

percentage=$(echo "scale=0; ($brightness*100)/$max_brightness" | bc)

# Format output based on brightness
output=" : ${percentage}%"

echo "$output"

