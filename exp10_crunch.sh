#!/bin/bash
# ============================================================
#  VAPT EXP 10 — CRUNCH (Wordlist Generator)
# ============================================================
echo "============================================================"
echo "  VAPT EXPERIMENT 10 : CRUNCH"
echo "  (Custom Wordlist / Password List Generation)"
echo "============================================================"

# Install Crunch if missing
if ! command -v crunch &>/dev/null; then
    echo "[*] Installing crunch..."
    sudo apt update -qq && sudo apt install -y crunch
fi

echo ""
echo "------------------------------------------------------------"
echo "  CRUNCH SYNTAX:"
echo "  crunch <min_length> <max_length> [charset] [options]"
echo "------------------------------------------------------------"
echo ""
echo "  [1] Basic wordlist — all 4-char lowercase combos"
echo "      Command: crunch 4 4 abcdefghijklmnopqrstuvwxyz -o wordlist1.txt"
echo "------------------------------------------------------------"
crunch 4 4 abcdefghijklmnopqrstuvwxyz -o /tmp/wordlist1.txt 2>/dev/null
echo "      Generated: /tmp/wordlist1.txt"
wc -l /tmp/wordlist1.txt
echo "      Preview (first 5 lines):"
head -5 /tmp/wordlist1.txt

echo ""
echo "------------------------------------------------------------"
echo "  [2] Numeric wordlist — 6-digit PINs"
echo "      Command: crunch 6 6 0123456789 -o pins.txt"
echo "------------------------------------------------------------"
crunch 6 6 0123456789 -o /tmp/pins.txt 2>/dev/null
echo "      Generated: /tmp/pins.txt"
wc -l /tmp/pins.txt
echo "      Preview:"
head -5 /tmp/pins.txt

echo ""
echo "------------------------------------------------------------"
echo "  [3] Pattern-based wordlist with -t flag"
echo "      Pattern: ABC@@@  (ABC fixed + 3 lowercase chars)"
echo "      Command: crunch 6 6 -t ABC@@@ -o pattern_list.txt"
echo "------------------------------------------------------------"
crunch 6 6 -t ABC@@@ -o /tmp/pattern_list.txt 2>/dev/null
echo "      Generated: /tmp/pattern_list.txt"
wc -l /tmp/pattern_list.txt
echo "      Preview:"
head -5 /tmp/pattern_list.txt

echo ""
echo "------------------------------------------------------------"
echo "  [4] Mixed charset — min 6 max 8 chars"
echo "      Charset: abc123 (as per cheat sheet example)"
echo "      Command: crunch 6 8 abc123 -o mixed.txt"
echo "------------------------------------------------------------"
crunch 6 8 abc123 -o /tmp/mixed.txt 2>/dev/null
echo "      Generated: /tmp/mixed.txt"
wc -l /tmp/mixed.txt
echo "      Preview:"
head -5 /tmp/mixed.txt

echo ""
echo "------------------------------------------------------------"
echo "  CRUNCH PATTERN PLACEHOLDERS:"
echo "  @  = lowercase letters"
echo "  ,  = uppercase letters"
echo "  %  = numbers"
echo "  ^  = symbols"
echo "  Example: crunch 8 8 -t Pass%@@^"
echo "------------------------------------------------------------"

echo ""
echo "============================================================"
echo "  KEY THINGS TO OBSERVE:"
echo "  1. Word count generated per charset/length combo"
echo "  2. Pattern-based lists are more targeted"
echo "  3. File size grows exponentially with length"
echo "  4. Output file can be used with Hydra/Hashcat"
echo "============================================================"
echo "  USE CASE: Generated lists used in brute-force attacks"
echo "  against login pages, WiFi passwords, ZIP files etc."
echo "  DEFENSE: Strong passwords (12+ chars), account lockout,"
echo "  MFA / 2FA, rate limiting on login endpoints."
echo "============================================================"
