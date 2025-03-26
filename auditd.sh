#!/bin/bash

# Aktualisiere die Paketliste
sudo apt update

# Installiere auditd
sudo apt install -y auditd

# Aktiviere und starte den auditd-Dienst
sudo systemctl enable auditd
sudo systemctl start auditd

# Konfiguriere auditd
sudo tee /etc/audit/auditd.conf > /dev/null <<EOT
log_file = /var/log/audit/audit.log
log_format = RAW
log_group = root
priority_boost = 4
flush = INCREMENTAL
freq = 50
num_logs = 5
max_log_file = 8
max_log_file_action = ROTATE
space_left = 75
space_left_action = SYSLOG
admin_space_left = 50
admin_space_left_action = SUSPEND
disk_full_action = SUSPEND
disk_error_action = SUSPEND
EOT

# Füge eine Beispiel-Audit-Regel hinzu
echo "-w /etc/passwd -p wa -k passwd_changes" | sudo tee -a /etc/audit/rules.d/audit.rules

# Lade die Audit-Regeln neu
sudo auditctl -R /etc/audit/rules.d/audit.rules

echo "auditd wurde erfolgreich installiert und konfiguriert."
