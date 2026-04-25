#!/bin/bash
# ============================================================
#  VAPT EXP 3 — theHarvester (OSINT)
# ============================================================
TARGET="${1:-testphp.vulnweb.com}"
LIMIT="${2:-100}"

echo "============================================================"
echo "  VAPT EXPERIMENT 3 : theHarvester"
echo "  Target : $TARGET  |  Limit : $LIMIT results"
echo "============================================================"

# Install if missing
if ! command -v theHarvester &>/dev/null; then
    echo "[*] Installing theHarvester..."
    sudo apt update -qq && sudo apt install -y theharvester
fi

echo ""
echo "------------------------------------------------------------"
echo "  [1] SEARCH VIA GOOGLE"
echo "------------------------------------------------------------"
theHarvester -d "$TARGET" -l "$LIMIT" -b google

echo ""
echo "------------------------------------------------------------"
echo "  [2] SEARCH VIA BING"
echo "------------------------------------------------------------"
theHarvester -d "$TARGET" -l "$LIMIT" -b bing

echo ""
echo "------------------------------------------------------------"
echo "  [3] SEARCH VIA DNSDUMPSTER"
echo "------------------------------------------------------------"
theHarvester -d "$TARGET" -l "$LIMIT" -b dnsdumpster

echo ""
echo "============================================================"
echo "  KEY THINGS TO OBSERVE:"
echo "  1. Email addresses linked to the domain"
echo "  2. Subdomains discovered"
echo "  3. Hostnames and IP addresses"
echo "  4. Employee / usernames found"
echo "============================================================"
echo "  SECURITY RISKS: Emails -> phishing targets."
echo "  Subdomains -> attack surface expansion."
echo "  DEFENSE: Limit public email exposure, monitor subdomains."
echo "============================================================"
