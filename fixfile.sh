#!/bin/zsh
# file file permission if copy file from other dir.

#fix directory permissions
sudo chwon -R peacefulhat:peacefulhat ~/MyArch 
chmod -R 755 ~/MyArch 
# fix file permission
find ~/MyArch -type f -exec chmod 644 {} \;

