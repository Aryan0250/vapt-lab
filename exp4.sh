#!/bin/bash
# ============================================================
#  VAPT EXP 4 — Passive Recon on testphp.vulnweb.com
#  Tools: WHOIS + NSLOOKUP + DIG + theHarvester
# ============================================================
TARGET="testphp.vulnweb.com"

echo "============================================================"
echo "  VAPT EXPERIMENT 4 : PASSIVE RECONNAISSANCE"
echo "  Target : $TARGET"
echo "  (No active scanning or exploitation — OSINT only)"
echo "============================================================"

# Install tools if missing
for pkg in whois dnsutils theharvester; do
    dpkg -s "$pkg" &>/dev/null || { echo "[*] Installing $pkg..."; sudo apt install -y "$pkg" -qq; }
done

echo ""
echo "------------------------------------------------------------"
echo "  [1] WHOIS LOOKUP"
echo "------------------------------------------------------------"
whois vulnweb.com 2>/dev/null | grep -E "Registrar|Creation|Expiry|Status|Name Server|Organisation|Registrant" | head -20

echo ""
echo "------------------------------------------------------------"
echo "  [2] NSLOOKUP"
echo "------------------------------------------------------------"
nslookup "$TARGET"

echo ""
echo "------------------------------------------------------------"
echo "  [3] DIG — A, MX, NS, TXT Records"
echo "------------------------------------------------------------"
echo ">> A Record:"
dig "$TARGET" A +short
echo ">> MX Record:"
dig vulnweb.com MX +short
echo ">> NS Record:"
dig vulnweb.com NS +short
echo ">> TXT Record:"
dig vulnweb.com TXT +short

echo ""
echo "------------------------------------------------------------"
echo "  [4] theHarvester OSINT"
echo "------------------------------------------------------------"
theHarvester -d vulnweb.com -l 50 -b google 2>/dev/null | head -40

echo ""
echo "============================================================"
echo "  ANALYSIS — POTENTIAL SECURITY RISKS:"
echo "  1. Exposed registrant info  -> spear phishing"
echo "  2. Open DNS records         -> infrastructure mapping"
echo "  3. Harvested emails         -> social engineering"
echo "  4. Subdomains               -> expanded attack surface"
echo ""
echo "  RECOMMENDED DEFENSES:"
echo "  - Enable WHOIS privacy / domain redaction"
echo "  - Restrict DNS zone transfers (no public AXFR)"
echo "  - Use DNSSEC to prevent DNS spoofing"
echo "  - Remove unused subdomains promptly"
echo "  - Monitor for exposed email addresses"
echo "============================================================"
