#!/bin/bash

# Execute sshd
/etc/init.d/sshd start

##############################
# Install Django and cx Oracle
##############################
pip install cx_Oracle==5.3
pip install django==1.6
pip install south
pip install gevent==1.1
pip freeze

exec /sbin/init