#!/bin/sh

rootDirectory=$(realpath $(dirname $0));

mkdir /var/www/shop;
cd /var/www/shop;

git clone https://github.com/aircms/shop.git .;

export COMPOSER_ALLOW_SUPERUSER=1;
composer update;
composer run-script assets;

mkdir /var/www/fs;
cd /var/www/fs;

git clone https://github.com/aircms/fs.git .;
export COMPOSER_ALLOW_SUPERUSER=1;

composer update;
composer run-script assets;
composer run-script storage;

cd $rootDirectory;
