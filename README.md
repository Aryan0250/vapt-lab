# VAPT Lab Scripts 🔐

12 automated bash scripts for VAPT (Vulnerability Assessment & Penetration Testing) lab experiments. Each script installs required tools and walks through the full experiment.

---

## 📁 Files

| File | Experiment |
|------|-----------|
| `exp1.sh` | WHOIS Lookup |
| `exp2.sh` | DIG (DNS Queries) |
| `exp3.sh` | theHarvester OSINT |
| `exp4.sh` | Passive Recon on testphp.vulnweb.com |
| `exp5.sh` | Google Dorking |
| `exp6.sh` | Nmap Network Scanning |
| `exp7.sh` | Angry IP Scanner |
| `exp8.sh` | FTK Imager (Disk Imaging) |
| `exp9.sh` | Autopsy (Forensic Analysis) |
| `exp10.sh` | Crunch Wordlist Generator |
| `exp11.sh` | Wireshark HTTP vs HTTPS |
| `exp12.sh` | Trojan Creation (Metasploit) |
| `run_vapt.sh` | Master launcher (runs any exp by number) |

---

## 🚀 How to Use on College Terminal

### Option A — Run directly from GitHub (needs internet)
```bash
curl -fsSL https://raw.githubusercontent.com/Aryan0250/vapt-lab/main/exp1.sh | bash
```
Replace `exp1.sh` with whichever experiment you need.

### Option B — Clone repo first (LAN or internet), then run locally
```bash
git clone https://github.com/Aryan0205/vapt-lab.git
cd vapt-lab
chmod +x *.sh
bash exp1_whois.sh        # Run experiment 1
bash run_vapt.sh          # Show menu of all experiments
bash run_vapt.sh 6        # Run experiment 6 (Nmap)
```

### Option C — One-liner with master launcher
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Aryan0250/vapt-lab/main/run_vapt.sh) 6
```

---

## 🏫 For College LAN (No Internet)

If the college PC has LAN but no internet, you can:

1. Put the cloned folder on a USB drive
2. Copy it to the college PC desktop
3. Open terminal in that folder
4. Run: `bash run_vapt.sh` to see the menu

Or set up a local HTTP server from your laptop on the same LAN:
```bash
# On your laptop (in the vapt-lab folder):
python3 -m http.server 8080

# On college PC terminal:
curl http://YOUR_LAPTOP_IP:8080/exp6.sh | bash
```

---

## ⚠️ Disclaimer
These scripts are for **educational purposes in a controlled lab environment only**. Do not use against systems you do not own or have explicit written permission to test.
