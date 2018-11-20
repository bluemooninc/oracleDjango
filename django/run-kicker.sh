#!/bin/bash

# Execute sshd
/etc/init.d/sshd start

##############################
# Install Django and cx Oracle
##############################
pip install cx_Oracle==6.0.3
pip install django==1.6

exec /sbin/init