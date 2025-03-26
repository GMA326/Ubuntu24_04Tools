#!/bin/bash

# Aktualisiere die Paketlisten
sudo apt update

# Installiere systemd (enthält journalctl)
sudo apt install -y systemd

# Erstelle das Verzeichnis für permanente Logs
sudo mkdir -p /var/log/journal

# Setze die korrekten Berechtigungen
sudo systemd-tmpfiles --create --prefix=/var/log/journal

# Aktiviere die permanente Speicherung in der Konfigurationsdatei
sudo sed -i 's/#Storage=auto/Storage=persistent/' /etc/systemd/journald.conf

# Übertrage vorhandene Logs in das neue Verzeichnis
sudo journalctl --flush

# Starte den journald-Dienst neu
sudo systemctl restart systemd-journald

echo "journalctl wurde installiert und für permanente Speicherung konfiguriert."
