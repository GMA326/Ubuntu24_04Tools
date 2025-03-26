#!/bin/bash

# Aktualisiere die Paketliste
sudo apt update

# Installiere AppArmor und zugehörige Pakete
sudo apt install -y apparmor apparmor-utils apparmor-profiles apparmor-profiles-extra

# Aktiviere und starte AppArmor
sudo systemctl enable apparmor
sudo systemctl start apparmor

# Überprüfe den Status von AppArmor
sudo apparmor_status

# Sichere die vorhandenen AppArmor-Profile
sudo cp -R /etc/apparmor.d /etc/apparmor.d.bak

# Lade die AppArmor-Profile neu
sudo systemctl reload apparmor

echo "AppArmor wurde erfolgreich installiert und konfiguriert."
