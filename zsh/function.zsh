#!/bin/bash

# Define ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[34m'
GOLD='\033[38;5;178m'
CYAN='\033[36m'
PURPLE='\\033[0;35m'
RESET='\033[0m' # Reset color

# Usage: color_echo <color> <text>
function coltxt() {
    local color="$1"
    local text="$2"
    echo -e "\n ${color}${text}${RESET}"
}

function fdate() {
    date +%d%m%Y-%H%M
}