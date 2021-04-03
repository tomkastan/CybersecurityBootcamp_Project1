#!/bin/bash
echo "system info $(date)"
echo $(uname -a)
echo $HOSTNAME
echo $(cat /etc/resolv.conf | tail -1)
echo -e "\n\n test \n"

