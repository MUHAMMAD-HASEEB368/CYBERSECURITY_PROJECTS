#!/usr/bin/env bash

# ---- COLORS ----
GREEN='\033[0;32m'
BLUE='\033[1;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# ---- HEADER ----
echo -e "${BLUE}=========================================${NC}"
echo -e "${GREEN}   ICDFA Advanced Reconnaissance Tool    ${NC}"
echo -e "${BLUE}=========================================${NC}"
echo "Use only against authorised lab targets."
echo

# ---- TARGET INPUT ----
read -rp "Enter authorised target IP address or domain: " target

# ---- VALIDATIONS ----
if [[ -z "$target" ]]; then
    echo -e "${RED}Error: no target was entered.${NC}"
    exit 1
fi

# Check for spaces or leading dashes (to prevent flag injection like -iL)
if [[ "$target" =~ [[:space:]] || "$target" == -* ]]; then
    echo -e "${RED}Error: target must not contain spaces or start with a dash (-).${NC}"
    exit 1
fi

# Create a directory to save results
OUT_DIR="recon_results_${target}"
mkdir -p "$OUT_DIR"
echo -e "${GREEN}[*] Scan results will be saved in directory: $OUT_DIR ${NC}"

# ---- TOOL CHECK FUNCTION ----
check_tool() {
    if ! command -v "$1" >/dev/null 2>&1; then
        echo -e "${RED}Error: required tool '$1' is not installed or not in PATH.${NC}"
        exit 1
    fi
}

# ---- MENU LOOP ----
# while loop add kiya gaya hai taake menu baar baar show ho
while true; do
    echo
    echo -e "${BLUE}Select a reconnaissance tool:${NC}"
    echo "1) WhatWeb (Web Technologies)"
    echo "2) Nmap (Service & Script Scan)"
    echo "3) DIRB (Directory Bruteforce)"
    echo "4) Exit"
    read -rp "Enter your choice [1-4]: " choice

    case "$choice" in
        1)
            check_tool whatweb
            echo -e "${GREEN}[+] Running WhatWeb against $target...${NC}"
            # 'tee' command output ko terminal par bhi dikhati hai aur file mein bhi save karti hai
            whatweb "http://$target" | tee "${OUT_DIR}/whatweb_scan.txt"
            ;;
        2)
            check_tool nmap
            echo -e "${GREEN}[+] Running Nmap service detection against $target...${NC}"
            # -T4 stable hai, -sC default scripts chalata hai jo zyada useful info dete hain
            nmap -sV -sC -T4 "$target" | tee "${OUT_DIR}/nmap_scan.txt"
            ;;
        3)
            check_tool dirb
            echo -e "${GREEN}[+] Running DIRB against $target...${NC}"
            dirb "http://$target" -r | tee "${OUT_DIR}/dirb_scan.txt"
            ;;
        4)
            echo -e "${GREEN}Exiting. All completed scans are saved in '${OUT_DIR}/'.${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Error: invalid menu choice. Please try again.${NC}"
            ;;
    esac
done
