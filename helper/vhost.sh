#!/bin/sh

generateBasicVhost()
{
  local _domain=$1;
  local _email=$2;

  if [ ! -f "/etc/letsencrypt/live/$_domain/fullchain.pem" ]; then

    local vhost=$(cat vhosts/default.conf);
    vhost=$(echo "$vhost" | sed "s/{domain}/${_domain}/");
    echo "$vhost" > /etc/apache2/sites-enabled/$_domain.conf;

    sudo service apache2 restart;
    sudo certbot certonly -d "$_domain" -m "$_email" --agree-tos --apache -n;

    unlink "/etc/apache2/sites-enabled/$_domain.conf";
  fi;
}

generateFsVhost()
{
  local _domain=$1;
  local _email=$2;
  local _airEnvironment=$3;
  local _airFsKey=$4;

  generateBasicVhost "fs.$_domain" $_email;

  local vhost=$(cat vhosts/fs.conf);

  vhost=$(echo "$vhost" | sed "s/{domain}/${_domain}/");
  vhost=$(echo "$vhost" | sed "s/{environment}/${_airEnvironment}/");
  vhost=$(echo "$vhost" | sed "s/{fsKey}/${_airFsKey}/");

  printf '%s\n' "$vhost" > /etc/apache2/sites-enabled/fs.conf;
}

generateAdminVhost()
{
  local _domain=$1;
  local _email=$2;
  local _airEnvironment=$3;
  local _airFsKey=$4;
  local _airDbName=$5;
  local _airRootLogin=$6;
  local _airRootPassword=$7;
  local _airTinyKey=$8;

  generateBasicVhost "admin.$_domain" $_email;

  local vhost=$(cat vhosts/admin.conf);

  vhost=$(echo "$vhost" | sed "s/{domain}/${_domain}/");
  vhost=$(echo "$vhost" | sed "s/{environment}/${_airEnvironment}/");
  vhost=$(echo "$vhost" | sed "s/{fsKey}/${_airFsKey}/");
  vhost=$(echo "$vhost" | sed "s/{dbName}/${_airDbName}/");
  vhost=$(echo "$vhost" | sed "s/{rootLogin}/${_airRootLogin}/");
  vhost=$(echo "$vhost" | sed "s/{rootPassword}/${_airRootPassword}/");
  vhost=$(echo "$vhost" | sed "s/{tinyKey}/${_airTinyKey}/");

   printf '%s\n' "$vhost" > /etc/apache2/sites-enabled/admin.conf;
}

generateUiVhost()
{
  local _domain=$1;
  local _email=$2;
  local _airEnvironment=$3;
  local _airFsKey=$4;
  local _airDbName=$5;

  generateBasicVhost $_domain $_email;

  local vhost=$(cat vhosts/ui.conf);

  vhost=$(echo "$vhost" | sed "s/{domain}/${_domain}/");
  vhost=$(echo "$vhost" | sed "s/{environment}/${_airEnvironment}/");
  vhost=$(echo "$vhost" | sed "s/{fsKey}/${_airFsKey}/");
  vhost=$(echo "$vhost" | sed "s/{dbName}/${_airDbName}/");

  printf '%s\n' "$vhost" > /etc/apache2/sites-enabled/ui.conf;
}

generateWwwVhost()
{
  local _domain=$1;
  local _email=$2;

  generateBasicVhost "www.$_domain" $_email;

  local vhost=$(cat vhosts/www.conf);
  vhost=$(echo "$vhost" | sed "s/{domain}/${_domain}/");

  printf '%s\n' "$vhost" > /etc/apache2/sites-enabled/www.conf;
}

generateOtherVhost()
{
  local _domain=$1;

  local vhost=$(cat vhosts/other.conf);
  vhost=$(echo "$vhost" | sed "s/{domain}/${_domain}/");

  printf '%s\n' "$vhost" > /etc/apache2/sites-enabled/www.conf;
}

fsKey=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13; echo);

unlink /etc/apache2/sites-enabled/000-default.conf;

generateFsVhost $domain $email $environment $fsKey;

generateAdminVhost $domain $email $environment $fsKey $dbName $rootLogin $rootPassword $tinyKey;
generateUiVhost $domain $email $environment $fsKey $dbName;
generateWwwVhost $domain $email;
generateOtherVhost $domain;

sudo service apache2 restart;