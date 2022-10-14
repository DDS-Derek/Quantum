#!/bin/bash

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
LANG=en_US.UTF-8


if [ $Quantum_app="install" ];then

    apt update -y
    apt-get update -y 
    apt install -y cron
    apt install perl

    perl -v

    if [ ! -f /quantum/bin/sendEmail ];then
        wget http://caspian.dotconf.net/menu/Software/SendEmail/sendEmail-v1.56.tar.gz -P /quantum/tmp
        tar -xzvf /quantum/tmp/sendEmail-v1.56.tar.gz -C /quantum/tmp
        cp -a /quantum/tmp/sendEmail-v1.56/sendEmail /quantum/bin
        chmod +x /quantum/bin/sendEmail
    fi

fi

if [ $Quantum_app="update" ];then

fi