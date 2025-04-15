# Betriebssystem ubuntu 24.04
docker install
portainer install 
fail2ban install 
rkhunter install


fail2ban cli sudo fail2ban-client status
             sudo fail2ban-client status sshd 
             sudo grep 'Ban' /var/log/fail2ban.log
