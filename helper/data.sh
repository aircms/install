rm -rf /var/www/fs/www/storage;
cp -r data/storage /var/www/fs/www/storage;
chown -R www-data:www-data /var/www/fs/www/storage;

mongorestore --db $dbName data/db