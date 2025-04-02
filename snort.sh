#!/bin/bash
# Snort Installations- und Konfigurationsskript für Ubuntu 24.04
# Quelle: Offizielle Dokumentation & Community-Beiträge [1][2][6][7]

# Systemaktualisierung
sudo apt update && sudo apt upgrade -y

# Abhängigkeiten installieren
sudo apt install -y snort libpcap-dev build-essential

# Netzwerkinformationen ermitteln
INTERFACE=$(ip -o -4 route show default | awk '{print $5}')
HOME_NET=$(ip -o -4 addr show $INTERFACE | awk '{print $4}' | cut -d'/' -f1)

# Grundkonfiguration anpassen
sudo sed -i "s|ipvar HOME_NET any|ipvar HOME_NET $HOME_NET/32|" /etc/snort/snort.conf
sudo sed -i "s|ipvar EXTERNAL_NET any|ipvar EXTERNAL_NET !\$HOME_NET|" /etc/snort/snort.conf

# Regelwerk aktivieren
sudo sed -i 's|^# include \$RULE_PATH|include \$RULE_PATH|' /etc/snort/snort.conf

# Log-Verzeichnis erstellen
sudo mkdir -p /var/log/snort
sudo chown -R snort:snort /var/log/snort

# Systemd-Service einrichten
cat <<EOF | sudo tee /etc/systemd/system/snort.service
[Unit]
Description=Snort Intrusion Detection System
After=network.target

[Service]
Type=simple
ExecStart=/usr/sbin/snort -q -A console -c /etc/snort/snort.conf -i $INTERFACE
User=snort
Group=snort
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# Konfiguration testen
sudo snort -T -c /etc/snort/snort.conf

# Service aktivieren
sudo systemctl daemon-reload
sudo systemctl enable --now snort.service

echo -e "\nInstallation abgeschlossen!"
echo "Interface: $INTERFACE"
echo "HOME_NET: $HOME_NET"
echo "Logs: /var/log/snort"
echo "Konfiguration: /etc/snort/snort.conf"
