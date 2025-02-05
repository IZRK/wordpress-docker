echo "Updating /etc/hosts..."
echo "127.0.0.1 $(hostname) localhost localhost.localdomain" >> /etc/hosts
echo "Restarting sendmail..."
service sendmail restart
