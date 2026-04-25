#!/bin/bash
# ============================================================
#  VAPT EXP 7 — Angry IP Scanner
# ============================================================
echo "============================================================"
echo "  VAPT EXPERIMENT 7 : ANGRY IP SCANNER"
echo "============================================================"
echo ""
echo "  Angry IP Scanner is a GUI tool. Follow the steps below."
echo ""

# Check / install Angry IP Scanner
if ! command -v ipscan &>/dev/null; then
    echo "[*] Angry IP Scanner not found. Attempting install..."
    # Try .deb install from official source
    DEB_URL="https://github.com/angryip/ipscan/releases/download/3.9.1/ipscan_3.9.1_amd64.deb"
    wget -q -O /tmp/ipscan.deb "$DEB_URL" && sudo dpkg -i /tmp/ipscan.deb
    sudo apt-get install -f -y -qq
fi

echo ""
echo "------------------------------------------------------------"
echo "  STEP-BY-STEP PROCEDURE (GUI):"
echo "------------------------------------------------------------"
echo ""
echo "  STEP 1 : Launch Angry IP Scanner"
echo "           Run: ipscan  (or search in Applications)"
echo ""
echo "  STEP 2 : Enter target IP range"
echo "           Example: 192.168.1.1  to  192.168.1.254"
echo "           (Use your lab network range)"
echo ""
echo "  STEP 3 : Select scan methods"
echo "           Tick: ICMP (Ping)  and  TCP Ports"
echo ""
echo "  STEP 4 : Choose ports to scan"
echo "           Suggested ports:"
echo "           21  (FTP)"
echo "           22  (SSH)"
echo "           80  (HTTP)"
echo "           443 (HTTPS)"
echo "           3389 (RDP)"
echo ""
echo "  STEP 5 : Click START button"
echo ""
echo "  STEP 6 : Observe results for each host:"
echo "           - IP address"
echo "           - Hostname"
echo "           - MAC address"
echo "           - Open ports"
echo "           - Response/ping time"
echo ""
echo "  STEP 7 : Export results"
echo "           File → Save → Choose format: CSV / TXT / XML"
echo ""
echo "------------------------------------------------------------"
echo "  LAUNCHING ANGRY IP SCANNER NOW..."
echo "------------------------------------------------------------"
if command -v ipscan &>/dev/null; then
    ipscan &
else
    echo "  [!] Could not launch. Open manually from Applications."
fi

echo ""
echo "============================================================"
echo "  KEY THINGS TO OBSERVE:"
echo "  1. Which IPs are alive (green = alive)"
echo "  2. Open ports per host"
echo "  3. Hostnames resolved"
echo "  4. MAC addresses (useful for identifying devices)"
echo "============================================================"
echo "  SECURITY RISKS: Exposed services on open ports."
echo "  Alive hosts mapped = network topology revealed."
echo "  DEFENSE: Disable ICMP, use network segmentation,"
echo "  close unused ports, deploy a firewall."
echo "============================================================"
