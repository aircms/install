# General
sed -i "s/#\$nrconf{kernelhints} = -1;/\$nrconf{kernelhints} = -1;/g" /etc/needrestart/needrestart.conf;
sed -i "s/#\$nrconf{restart} = 'i';/\$nrconf{restart} = 'a';/g" /etc/needrestart/needrestart.conf;
sudo apt update -y && sudo apt upgrade -y;

# Apache
sudo apt install apache2 -y;
sudo systemctl start apache2;
sudo systemctl enable apache2;
sudo a2enmod headers;
sudo a2enmod expires;
sudo a2enmod rewrite;
sudo a2enmod ssl;
rm -rf /var/www/html;
systemctl restart apache2;

# Php
sudo apt install software-properties-common -y;
sudo add-apt-repository ppa:ondrej/php -y;
sudo apt install php -y;
sudo apt install libapache2-mod-php -y;
sudo apt install php-cli -y;
sudo apt install php-common -y;
sudo apt install php-mongodb -y;
sudo apt install php-imap -y;
sudo apt install php-mbstring -y;
sudo apt install php-gd -y;
sudo apt install php-curl -y;
sudo apt install php-xml -y;
sudo apt install php-cli unzip composer -y;
sudo apt install imagemagick -y;
sudo apt install php-imagick -y;
sudo apt install ffmpeg -y;

# Mongo
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -;
curl -fsSL https://pgp.mongodb.com/server-7.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor --yes;
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list;
sudo apt update -y;
sudo apt install mongodb-org -y;
sudo systemctl restart mongod.service;
sudo systemctl enable mongod.service;

# LetsEncrypt
sudo apt update -y;
sudo apt install certbot python3-certbot-apache -y;