#/bin/bash!
free > ~/backups/freemem/freemem.txt
du > ~/backups/diskuse/diskuse.txt
lsof /dev/null > ~/backups/openlist/openlist.txt
df > ~/backups/freedisk/freedisk.txt

