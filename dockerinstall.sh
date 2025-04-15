#!/bin/bash

set -e

echo "Let's intall docker!"

# 1. Paketquellen aktualisieren und benötigte Pakete installieren
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# 2. Docker GPG-Key hinzufügen
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# 3. Docker-Repository hinzufügen
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 4. Paketquellen erneut aktualisieren
sudo apt update

# 5. Docker und empfohlene Komponenten installieren
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 6. Docker-Dienst aktivieren und starten
sudo systemctl enable --now docker

# 7. (Optional) Aktuellen Benutzer zur Docker-Gruppe hinzufügen
sudo usermod -aG docker $USER

echo "Docker-Installation abgeschlossen."
echo "Bitte ab- und wieder anmelden, damit die Gruppenänderung wirksam wird."
echo "Teste die Installation mit: docker run hello-world"

sudo docker ps


