#!/bin/bash
# ============================================================
#  VAPT EXP 1 — WHOIS
# ============================================================
TARGET="${1:-google.com}"

echo "============================================================"
echo "  VAPT EXPERIMENT 1 : WHOIS"
echo "  Target : $TARGET"
echo "============================================================"

# Install if missing
if ! command -v whois &>/dev/null; then
    echo "[*] Installing whois..."
    sudo apt update -qq && sudo apt install -y whois
fi

echo ""
echo "------------------------------------------------------------"
echo "  RUNNING: whois $TARGET"
echo "------------------------------------------------------------"
whois "$TARGET"

echo ""
echo "============================================================"
echo "  KEY THINGS TO OBSERVE IN OUTPUT:"
echo "  1. Registrar Information"
echo "  2. Domain Creation & Expiry Dates"
echo "  3. Domain Status (active, clientTransferProhibited...)"
echo "  4. Name Servers"
echo "  5. Registrant Organization"
echo "============================================================"
echo "  SECURITY RISKS: Exposed contact info can aid spear"
echo "  phishing. Name servers reveal DNS infrastructure."
echo "  DEFENSE: Use domain privacy / WHOIS redaction."
echo "============================================================"
