#!/bin/bash

# Farben
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\e[36m'
NC='\033[0m' # No Color

echo -e "${BLUE}──────────────────────────────────────────────────────"
echo -e "${BLUE}─                                                    ─"
echo -e "${BLUE}─               N E X T C L O U D                    ─"
echo -e "${BLUE}─                                                    ─"
echo -e "${BLUE}──────────────────────────────────────────────────────"

#echo -e "${BLUE} _   _           _       _                 _"
#echo -e "${BLUE}| \ | | ___  ___| |_ ___| | ___  _   _  __| |"
#echo -e "${BLUE}|  \| |/ _ \/ __| __/ __| |/ _ \| | | |/ _` |"
#echo -e "${BLUE}| |\  |  __/\__ \ || (__| | (_) | |_| | (_| |"
#echo -e "${BLUE}|_| \_|\___||___/\__\___|_|\___/ \__,_|\__,_|"
echo -e "${NC}"

echo -e "${CYAN}──────────────────────────────────────────────────────${NC}"
echo -e "  ${GREEN} $(lsb_release -d | cut -f2-) • $(hostname) • $(date '+%Y-%m-%d %H:%M')${RESET}"
echo -e "${CYAN}──────────────────────────────────────────────────────${NC}"

# Systemdaten
echo -e "   ${YELLOW}Uptime   :${NC}  $(uptime -p)"
echo -e "   ${YELLOW}Memory   :${NC}  $(free -h | awk 'NR==2 {print $3 " - " $2}')"
echo -e "   ${YELLOW}Disk (/) :${NC}  $(df -h / | awk 'NR==2 {print $3 " - " $2}')"
echo -e "   ${YELLOW}IP       :${NC}  $(hostname -I)"

# Nicht laufende systemd-Services
FAILED=$(systemctl --failed --no-legend | wc -l)
if [ "$FAILED" -gt 0 ]; then
    echo -e "  ${RED}Failed Services:${NC}"
    systemctl --failed --no-legend | awk '{print "    - "$1}'
fi

echo -e "${CYAN}──────────────────────────────────────────────────────${NC}"
echo " "
