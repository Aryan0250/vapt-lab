#!/bin/bash
# ============================================================
#  VAPT EXP 2 — DIG (DNS Information Gathering)
# ============================================================
TARGET="${1:-google.com}"

echo "============================================================"
echo "  VAPT EXPERIMENT 2 : DIG"
echo "  Target : $TARGET"
echo "============================================================"

# Install if missing
if ! command -v dig &>/dev/null; then
    echo "[*] Installing dnsutils..."
    sudo apt update -qq && sudo apt install -y dnsutils
fi

echo ""
echo "------------------------------------------------------------"
echo "  [1] DEFAULT DIG QUERY"
echo "------------------------------------------------------------"
dig "$TARGET"

echo ""
echo "------------------------------------------------------------"
echo "  [2] A RECORD (IP Address)"
echo "------------------------------------------------------------"
dig "$TARGET" A +short

echo ""
echo "------------------------------------------------------------"
echo "  [3] MX RECORDS (Mail Servers)"
echo "------------------------------------------------------------"
dig "$TARGET" MX +short

echo ""
echo "------------------------------------------------------------"
echo "  [4] NS RECORDS (Name Servers)"
echo "------------------------------------------------------------"
dig "$TARGET" NS +short

echo ""
echo "------------------------------------------------------------"
echo "  [5] TXT RECORDS (SPF / DKIM etc.)"
echo "------------------------------------------------------------"
dig "$TARGET" TXT +short

echo ""
echo "============================================================"
echo "  KEY THINGS TO OBSERVE:"
echo "  1. IP address(es) mapped to domain  [A record]"
echo "  2. Mail server hostnames            [MX record]"
echo "  3. Authoritative name servers       [NS record]"
echo "  4. SPF / DKIM / verification data   [TXT record]"
echo "  5. TTL values for each record"
echo "============================================================"
echo "  SECURITY RISKS: Mail servers exposed -> spam/spoofing"
echo "  attacks. IP exposure aids targeted port scanning."
echo "  DEFENSE: Minimal DNS exposure, use DNSSEC."
echo "============================================================"
