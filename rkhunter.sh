#!/bin/bash

# Aktualisiere die Paketliste
sudo apt update

# Installiere Rkhunter
sudo apt install -y rkhunter

# Konfiguriere Rkhunter
sudo sed -i 's/UPDATE_MIRRORS=0/UPDATE_MIRRORS=1/' /etc/rkhunter.conf
sudo sed -i 's/MIRRORS_MODE=1/MIRRORS_MODE=0/' /etc/rkhunter.conf
sudo sed -i 's/WEB_CMD=\/bin\/false/WEB_CMD=""/' /etc/rkhunter.conf

# Aktualisiere die Rkhunter-Datenbank
sudo rkhunter --update

# Führe einen ersten Scan durch
sudo rkhunter --check --skip-keypress

# Erstelle einen täglichen Cron-Job für Rkhunter
echo "0 3 * * * /usr/bin/rkhunter --cronjob --update --quiet" | sudo tee -a /etc/crontab > /dev/null

echo "Rkhunter wurde erfolgreich installiert und konfiguriert."
