#!/bin/sh

ssh-keygen

echo "-----------------------------------------------------------";
echo "Copy the following key to GitHub SSH keys:";
cat ~/.ssh/id_ed25519.pub;
echo "Press [ENTER] to confirm or CTRL+C to cancel";
read _confirm;
echo "-----------------------------------------------------------";

