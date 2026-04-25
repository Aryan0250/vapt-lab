#!/bin/bash
# ============================================================
#  VAPT EXP 5 — Google Dorking
#  (Opens dork queries in browser / prints them clearly)
# ============================================================
TARGET="${1:-testphp.vulnweb.com}"

echo "============================================================"
echo "  VAPT EXPERIMENT 5 : GOOGLE DORKING"
echo "  Target : $TARGET"
echo "============================================================"
echo ""
echo "  Google Dorking uses advanced search operators to find"
echo "  sensitive information exposed on a target website."
echo ""
echo "------------------------------------------------------------"
echo "  DORK QUERIES TO USE IN BROWSER"
echo "------------------------------------------------------------"
echo ""
echo "  [1] Index all pages of target:"
echo "      site:$TARGET"
echo ""
echo "  [2] Find Word documents:"
echo "      site:$TARGET ext:doc"
echo ""
echo "  [3] Find PDF files:"
echo "      site:$TARGET ext:pdf"
echo ""
echo "  [4] Find SQL files (database dumps):"
echo "      site:$TARGET ext:sql"
echo ""
echo "  [5] Find Excel files:"
echo "      site:$TARGET ext:xls"
echo ""
echo "  [6] Find admin/login pages:"
echo "      site:$TARGET inurl:admin"
echo "      site:$TARGET inurl:login"
echo ""
echo "  [7] Find config/env files:"
echo "      site:$TARGET ext:env"
echo "      site:$TARGET ext:cfg"
echo ""
echo "  [8] Find error messages (info disclosure):"
echo "      site:$TARGET \"warning: mysql\""
echo "      site:$TARGET \"Fatal error\""
echo ""
echo "  [9] Find exposed directories:"
echo "      site:$TARGET intitle:\"index of\""
echo ""
echo "------------------------------------------------------------"
echo "  OPENING BASIC DORK IN BROWSER..."
echo "------------------------------------------------------------"

DORK_URL="https://www.google.com/search?q=site%3A${TARGET}"

# Try common browsers
if command -v xdg-open &>/dev/null; then
    xdg-open "$DORK_URL" 2>/dev/null &
elif command -v firefox &>/dev/null; then
    firefox "$DORK_URL" &
elif command -v chromium &>/dev/null; then
    chromium "$DORK_URL" &
else
    echo "  [!] No browser found. Copy the URL below and paste in browser:"
    echo ""
    echo "  $DORK_URL"
fi

echo ""
echo "============================================================"
echo "  KEY THINGS TO OBSERVE:"
echo "  1. Indexed pages and exposed files"
echo "  2. Admin/login panels accessible publicly"
echo "  3. Config files, backups, SQL dumps"
echo "  4. Error messages leaking server/DB info"
echo "  5. Open directory listings"
echo "============================================================"
echo "  SECURITY RISKS:"
echo "  - Exposed DB dumps -> data theft"
echo "  - Admin panels without auth -> full compromise"
echo "  - Error messages -> tech stack fingerprinting"
echo "  DEFENSE: robots.txt, remove sensitive files,"
echo "  disable directory listing, custom error pages."
echo "============================================================"
