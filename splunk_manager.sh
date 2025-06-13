#!/bin/bash

banner() {
  clear
  if ! command -v figlet &> /dev/null || ! command -v lolcat &> /dev/null; then
    echo "[!] figlet and lolcat are required. Installing them..."
    apt-get update && apt-get install -y figlet lolcat
  fi
  clear

  figlet "SPLUNK TOOLKIT" -c | lolcat

}
banner

# ==================== Config ====================
SPLUNK_DEB_URL="https://download.splunk.com/products/splunk/releases/9.4.2/linux/splunk-9.4.2-e9664af3d956-linux-amd64.deb"
UF_DEB_URL="https://download.splunk.com/products/universalforwarder/releases/9.4.2/linux/splunkforwarder-9.4.2-e9664af3d956-linux-amd64.deb"

SPLUNK_USER="splunk"
SPLUNK_HOME="/opt/splunk"
UF_HOME="/opt/splunkforwarder"

SPLUNK_PORT=8089    # Splunk enterprise splunkd port
UF_PORT=8090        # Universal Forwarder splunkd port
SPLUNK_WEB=8000     # Splunk web UI port
FORWARD_PORT=9997   # Forwarding port

# ================================================

if [[ $EUID -ne 0 ]]; then
  echo "[!] This script must be run as root (sudo)." >&2
  exit 1
fi

create_splunk_user() {
  if ! id "$SPLUNK_USER" &>/dev/null; then
    echo "[+] Creating system user '$SPLUNK_USER'..."
    useradd -m -s /bin/bash "$SPLUNK_USER"
  fi
}

pause() {
  read -p "Press enter to continue..."
}

check_port() {
  ss -tuln | grep ":$1" >/dev/null 2>&1
}

install_splunk() {
  echo "[+] Installing Splunk Enterprise..."
  create_splunk_user

  read -s -p "Enter a password for Splunk admin (used for UF too): " ENT_PASS
  echo

  wget -q --show-progress "$SPLUNK_DEB_URL" -O /tmp/splunk.deb || { echo "[!] Failed to download Splunk Enterprise."; exit 1; }
  dpkg -i /tmp/splunk.deb || { echo "[!] Failed to install Splunk Enterprise."; exit 1; }
  chown -R "$SPLUNK_USER":"$SPLUNK_USER" "$SPLUNK_HOME"

  sudo -u "$SPLUNK_USER" "$SPLUNK_HOME/bin/splunk" start --accept-license --answer-yes --no-prompt --seed-passwd changeme
  sudo -u "$SPLUNK_USER" "$SPLUNK_HOME/bin/splunk" edit user admin -password "$ENT_PASS" -role admin -auth admin:changeme
  sudo -u "$SPLUNK_USER" "$SPLUNK_HOME/bin/splunk" set splunkd-port "$SPLUNK_PORT" -auth admin:"$ENT_PASS"
  sudo -u "$SPLUNK_USER" "$SPLUNK_HOME/bin/splunk" enable listen "$FORWARD_PORT" -auth admin:"$ENT_PASS"
  sudo -u "$SPLUNK_USER" "$SPLUNK_HOME/bin/splunk" restart
  echo "[✓] Splunk Enterprise installed on port $SPLUNK_PORT."
}

install_uf() {
  echo "[+] Installing Universal Forwarder..."
  create_splunk_user

  wget -q --show-progress "$UF_DEB_URL" -O /tmp/uf.deb || { echo "[!] Failed to download UF."; exit 1; }
  dpkg -i /tmp/uf.deb || { echo "[!] Failed to install UF."; exit 1; }
  chown -R "$SPLUNK_USER":"$SPLUNK_USER" "$UF_HOME"

  sudo -u "$SPLUNK_USER" "$UF_HOME/bin/splunk" start --accept-license --answer-yes --no-prompt --seed-passwd changeme
  sudo -u "$SPLUNK_USER" "$UF_HOME/bin/splunk" set splunkd-port "$UF_PORT" -auth admin:changeme
  sudo -u "$SPLUNK_USER" "$UF_HOME/bin/splunk" edit user admin -password "$ENT_PASS" -role admin -auth admin:changeme
  sudo -u "$SPLUNK_USER" "$UF_HOME/bin/splunk" add forward-server 127.0.0.1:$FORWARD_PORT -auth admin:"$ENT_PASS"
  sudo -u "$SPLUNK_USER" "$UF_HOME/bin/splunk" restart
  echo "[✓] Universal Forwarder installed on port $UF_PORT."
}

resolve_ports() {
  echo "[+] Resolving port conflicts..."
  sudo -u "$SPLUNK_USER" "$SPLUNK_HOME/bin/splunk" set splunkd-port "$SPLUNK_PORT" -auth admin:"$ENT_PASS"
  sudo -u "$SPLUNK_USER" "$UF_HOME/bin/splunk" set splunkd-port "$UF_PORT" -auth admin:"$ENT_PASS"
  sudo -u "$SPLUNK_USER" "$SPLUNK_HOME/bin/splunk" restart
  sudo -u "$SPLUNK_USER" "$UF_HOME/bin/splunk" restart
  echo "[✓] Port conflicts resolved: Splunk=$SPLUNK_PORT, UF=$UF_PORT"
}

verify_splunk() {
  echo "[+] Verifying Splunk..."
  if check_port $SPLUNK_PORT; then
    echo "[✓] Splunk is running on port $SPLUNK_PORT"
  else
    echo "[!] Splunk not running on $SPLUNK_PORT"
  fi
}

verify_uf() {
  echo "[+] Verifying Universal Forwarder..."
  if check_port $UF_PORT; then
    echo "[✓] UF is running on port $UF_PORT"
  else
    echo "[!] UF not running on $UF_PORT"
  fi
}

uninstall_splunk() {
  echo "[!] Uninstalling Splunk Enterprise..."
  "$SPLUNK_HOME/bin/splunk" stop
  rm -rf "$SPLUNK_HOME"
  echo "[✓] Splunk Enterprise removed."
}

uninstall_uf() {
  echo "[!] Uninstalling Universal Forwarder..."
  "$UF_HOME/bin/splunk" stop
  rm -rf "$UF_HOME"
  echo "[✓] Universal Forwarder removed."
}

while true; do
  echo "1. Install Splunk Enterprise"
  echo "2. Install Universal Forwarder"
  echo "3. Resolve Port Conflict (8089/8090)"
  echo "4. Verify Splunk Installation"
  echo "5. Verify UF Installation"
  echo "6. Uninstall Splunk Enterprise"
  echo "7. Uninstall Universal Forwarder"
  echo "8. Exit"
  read -p "Select an option [1-8]: " CHOICE

  case $CHOICE in
    1) install_splunk ;;
    2) install_uf ;;
    3) resolve_ports ;;
    4) verify_splunk ;;
    5) verify_uf ;;
    6) uninstall_splunk ;;
    7) uninstall_uf ;;
    8) echo "Goodbye!"; exit 0 ;;
    *) echo "[!] Invalid option." ;;
  esac

done
