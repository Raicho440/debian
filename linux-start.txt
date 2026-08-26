Statisch

sudo nano /etc/motd

Dynamisch 
Im Ordner /etc/update-motd.d/ werden alle Dateien in alphabetischer Reihenfolge angezeigt

sudo nano /etc/update-motd.d/09-info
sudo nano /etc/update-motd.d/10-systeminfo
…

Beispiel

#!/bin/bash
echo " "
echo "────────────────────────────────────────────"
echo "  Debian 13 • $(hostname) • $(date '+%Y-%m-%d %H:%M')"
echo "────────────────────────────────────────────"
echo "  Uptime: $(uptime -p)"
echo "  Kernel: $(uname -r)"
echo "  Memory: $(free -h | awk '/Mem:/ {print $3 \"/\" $2}')"
echo "  Disk: $(df -h / | awk 'NR==2 {print $3 \"/\" $2}')"
echo "  IP: $(hostname -I)"
echo "────────────────────────────────────────────"
echo " "

Beachte die Sprache des OS, bei deutscher Installation:
free -h | awk '/Speicher:/ {print $3 " - " $2}'
free -h | awk 'NR==2 {print $3 " - " $2}'
df -h / | awk 'NR==2 {print $3 " - " $2}'

Beispiel2 mit Farben
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

**************************************
Ubuntu
************************************

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
