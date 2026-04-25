#!/bin/bash
# ============================================================
#  VAPT EXP 6 — NMAP (Network Scanning)
# ============================================================
TARGET="${1:-testphp.vulnweb.com}"

echo "============================================================"
echo "  VAPT EXPERIMENT 6 : NMAP"
echo "  Target : $TARGET"
echo "  NOTE: Run as root (sudo) for best results"
echo "============================================================"

# Install nmap if missing
if ! command -v nmap &>/dev/null; then
    echo "[*] Installing nmap..."
    sudo apt update -qq && sudo apt install -y nmap
fi

# Resolve IP first
echo ""
echo "------------------------------------------------------------"
echo "  [0] RESOLVING TARGET IP via PING"
echo "------------------------------------------------------------"
ping -c 2 "$TARGET"
TARGET_IP=$(dig +short "$TARGET" | head -1)
echo "  Resolved IP: $TARGET_IP"

echo ""
echo "------------------------------------------------------------"
echo "  [1] PING SCAN — Discover active hosts"
echo "  Command: nmap -sn $TARGET"
echo "------------------------------------------------------------"
nmap -sn "$TARGET"

echo ""
echo "------------------------------------------------------------"
echo "  [2] TCP CONNECT SCAN — Full TCP handshake"
echo "  Command: nmap -sT $TARGET"
echo "------------------------------------------------------------"
nmap -sT "$TARGET"

echo ""
echo "------------------------------------------------------------"
echo "  [3] STEALTH SYN SCAN — Half-open, no handshake"
echo "  Command: sudo nmap -sS $TARGET"
echo "------------------------------------------------------------"
sudo nmap -sS "$TARGET"

echo ""
echo "------------------------------------------------------------"
echo "  [4] SERVICE VERSION DETECTION"
echo "  Command: nmap -sV $TARGET"
echo "------------------------------------------------------------"
nmap -sV "$TARGET"

echo ""
echo "------------------------------------------------------------"
echo "  [5] OS DETECTION"
echo "  Command: sudo nmap -O $TARGET"
echo "------------------------------------------------------------"
sudo nmap -O "$TARGET" 2>/dev/null

echo ""
echo "------------------------------------------------------------"
echo "  [6] UDP SCAN (top ports)"
echo "  Command: sudo nmap -sU --top-ports 20 $TARGET"
echo "------------------------------------------------------------"
sudo nmap -sU --top-ports 20 "$TARGET"

echo ""
echo "============================================================"
echo "  KEY THINGS TO OBSERVE:"
echo "  1. Open TCP/UDP ports and their services"
echo "  2. Software versions running on each port"
echo "  3. Operating system fingerprint"
echo "  4. Filtered vs Closed vs Open port states"
echo "============================================================"
echo "  SECURITY RISKS: Open ports = attack surface."
echo "  Old software versions = known CVEs exploitable."
echo "  DEFENSE: Close unused ports, update services,"
echo "  use firewall rules, enable IDS/IPS."
echo "============================================================"
