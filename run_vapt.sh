#!/bin/bash
# ============================================================
#  VAPT LAB — MASTER LAUNCHER
#  Usage: bash run_vapt.sh <experiment_number>
#  Example: bash run_vapt.sh 1
# ============================================================

BASE_URL="https://raw.githubusercontent.com/Aryan0250/vapt-lab/main"

SCRIPTS=(
    ""
    "exp1.sh"
    "exp2.sh"
    "exp3.sh"
    "exp4.sh"
    "exp5.sh"
    "exp6.sh"
    "exp7.sh"
    "exp8.sh"
    "exp9.sh"
    "exp10.sh"
    "exp11.sh"
    "exp12.sh"
)

NAMES=(
    ""
    "WHOIS"
    "DIG (DNS Lookup)"
    "theHarvester (OSINT)"
    "Passive Recon on testphp.vulnweb.com"
    "Google Dorking"
    "Nmap (Network Scanning)"
    "Angry IP Scanner"
    "FTK Imager (Disk Imaging)"
    "Autopsy (Forensic Analysis)"
    "Crunch (Wordlist Generator)"
    "Wireshark (HTTP vs HTTPS)"
    "Trojan Creation (Metasploit)"
)

if [ -z "$1" ]; then
    echo "============================================================"
    echo "  VAPT LAB — EXPERIMENT MENU"
    echo "============================================================"
    for i in $(seq 1 12); do
        echo "  $i.  ${NAMES[$i]}"
    done
    echo "============================================================"
    echo "  Usage: bash run_vapt.sh <number>"
    echo "  Example: bash run_vapt.sh 6"
    echo "============================================================"
    exit 0
fi

EXP="$1"
SCRIPT="${SCRIPTS[$EXP]}"

if [ -z "$SCRIPT" ]; then
    echo "[!] Invalid experiment number. Choose 1-12."
    exit 1
fi

echo "[*] Running Experiment $EXP : ${NAMES[$EXP]}"
echo "[*] Fetching: $BASE_URL/$SCRIPT"
echo ""

# Try local first, then GitHub
if [ -f "./$SCRIPT" ]; then
    bash "./$SCRIPT"
elif command -v curl &>/dev/null; then
    curl -fsSL "$BASE_URL/$SCRIPT" | bash
elif command -v wget &>/dev/null; then
    wget -qO- "$BASE_URL/$SCRIPT" | bash
else
    echo "[!] Neither curl nor wget found. Cannot fetch script."
    exit 1
fi
