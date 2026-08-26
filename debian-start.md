#!/bin/bash

# Farben
BLUE="\e[36m"
CYAN="\e[36m"
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

echo " "
echo -e "${BLUE}  ____             _            "
echo -e "${BLUE} |  _ \  ___   ___| | _____ _ __"
echo -e "${BLUE} | | | |/ _ \ / __| |/ / _ \ '__|"
echo -e "${BLUE} | |_| | (_) | (__|   <  __/ |   "
echo -e "${BLUE} |____/ \___/ \___|_|\_\___|_|   "
echo " "

echo -e "${CYAN}────────────────────────────────────────────${RESET}"
echo -e "  ${GREEN}Debian 13 • $(hostname) • $(date '+%Y-%m-%d %H:%M')${RESET}"
echo -e "${CYAN}────────────────────────────────────────────${RESET}"

# Systemdaten
echo -e "  ${YELLOW}Uptime:${RESET} $(uptime -p)"
echo -e "  ${YELLOW}Memory:${RESET} $(free -h | awk 'NR==2 {print $3 " - " $2}')"
echo -e "  ${YELLOW}Disk (/):${RESET} $(df -h / | awk 'NR==2 {print $3 " - " $2}')"
echo -e "  ${YELLOW}IP:${RESET} $(hostname -I)"

# Nicht laufende systemd-Services
FAILED=$(systemctl --failed --no-legend | wc -l)
if [ "$FAILED" -gt 0 ]; then
    echo -e "  ${RED}Failed Services:${RESET}"
    systemctl --failed --no-legend | awk '{print "    - "$1}'
fi

# Docker Status
if command -v docker >/dev/null 2>&1; then
    echo -e "  ${YELLOW}Docker:${RESET} $(docker ps -q | wc -l) running containers"
fi

echo -e "${CYAN}────────────────────────────────────────────${RESET}"
echo " "

