#!/bin/bash

# Aktualisiere die Paketliste
sudo apt update

# Installiere Fail2ban
sudo apt install fail2ban -y

# Erstelle eine Kopie der Standardkonfigurationsdatei
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

# Konfiguriere Fail2ban
cat << EOF | sudo tee /etc/fail2ban/jail.local
[DEFAULT]
bantime = 600
findtime = 600
maxretry = 3

[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 5
EOF

# Starte Fail2ban neu
sudo systemctl restart fail2ban

# Aktiviere Fail2ban beim Systemstart
sudo systemctl enable fail2ban

# Überprüfe den Status von Fail2ban
sudo systemctl status fail2ban

echo "Fail2ban wurde erfolgreich installiert und konfiguriert."
