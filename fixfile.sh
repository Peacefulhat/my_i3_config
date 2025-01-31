#!/bin/zsh
# file file permission if copy file from other dir.

#fix directory permissions
sudo chown -R peacefulhat:peacefulhat $1 
chmod -R 755 $1
# fix file permission
find $1 -type f -exec chmod 644 {} \;

