green ()
{
  GREEN="\033[0;32m";
  NC="\033[0m";
  echo "$GREEN$1$NC";
}

dbName=$1;
domain=$2;
environment=$3;
email=$4;
rootLogin=$5;
rootPassword=$6;
tinyKey=$7;
gitHubOrganization=$8;
#autoUpdate=$8;

echo "Welcome to AirCms installer"

if [ ${#dbName} = 0 ]; then
  echo "Enter db name:";
  read dbName;
fi;

if [ ${#domain} = 0 ]; then
  echo "Enter main domain name:";
  read domain;
fi;

if [ ${#environment} = 0 ]; then
  echo "Enter environment 'live' or 'dev':";
  read environment;
fi;

if [ ${#email} = 0 ]; then
  echo "Enter email address (used by Lets Encrypt for urgent renewal and security notices):";
  read email;
fi;

if [ ${#rootLogin} = 0 ]; then
  echo "Enter super-user login:";
  read rootLogin;
fi;

if [ ${#rootPassword} = 0 ]; then
  echo "Enter super-user password:";
  read rootPassword;
fi;

if [ ${#tinyKey} = 0 ]; then
  echo "Enter TinyMce key:";
  read tinyKey;
fi;

#if [ ${#autoUpdate} = 0 ]; then
#  echo "Would you like to enable core automatic updates? ('yes' or 'no')";
#  read autoUpdate;
#fi;

echo "-----------------------------------------------------------";
echo "Will be created:";
echo - $(green "$domain");
echo - $(green "fs.$domain");
echo - $(green "admin.$domain");
echo "-----------------------------------------------------------";
echo "Database name:    $(green $dbName)";
echo "-----------------------------------------------------------";
echo "Environment:      $(green $environment)";
echo "-----------------------------------------------------------";
echo "Email address:    $(green $email)";
echo "-----------------------------------------------------------";
echo "Root login:       $(green $rootLogin)";
echo "Root password:    $(green $rootPassword)";
echo "-----------------------------------------------------------";
echo "TinyMce key:      $(green $tinyKey)";
#echo "-----------------------------------------------------------";
#echo "Automatic update: $(green $autoUpdate)";
echo "-----------------------------------------------------------";
echo "Press [ENTER] to confirm or CTRL+C to cancel";
read _confirm;
echo "-----------------------------------------------------------";
echo "Great, Lets start!";
echo "-----------------------------------------------------------";