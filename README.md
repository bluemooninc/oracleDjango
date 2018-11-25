# Oracle django

This repository build a django and oracle container by docker-compose

## you need

- docker for Mac / Windows
- how to use for docker basis
- how to use for ORACLE basis

## How to start,strop rebuild docker container

start docker container

```buildoutcfg
git clone https://github.com/bluemooninc/oracleDjango.git
cd oracleDjango
docker-compose up
```

stop docker container

```buildoutcfg
docker-compose down
```

rebuild docker container

```buildoutcfg
## list for docker images you will find oracledjango_django repository
docker images
## delete docker image id such like this
docker rmi c0ab5f236f9a
## start docker container again
```

### Oracle container information

this repository is pulling below url oracle image

https://hub.docker.com/r/sath89/oracle-12c/

connect information for oracle

```commandline
hostname: localhost
port: 1521
sid: xe
service name: xe
username: system
password: oracle
```

## Start your django project

login to django container

```commandline
docker exec -it django-container bash
```

Make sure ORACLE connection by sqlplus

```buildoutcfg
sqlplus system/oracle@oracle-container:1521/xe

```

Create user on Oracle

```
CREATE USER develop identified by develop default tablespace USERS temporary tablespace temp profile default;
GRANT CONNECT, RESOURCE TO develop;
GRANT UNLIMITED TABLESPACE TO develop;
```

### Creating sample application

generate django sample code. and lunch server.

```
$ cd ~/src

## generate project
$ django-admin.py startproject mysite

## start local server
$ cd mysite
$ python manage.py runserver 0.0.0.0:8000
```

Check by Browser at "http://localhost"

## oracle settings for django

Edit settings.py and set your created user like below. 

```buildoutcfg
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.oracle',
        'NAME': 'oracle-container:1521/xe',
        'USER': 'develop',
        'PASSWORD': 'develop',
    }
}
```

Create database table for django

```buildoutcfg
## inspect
python manage.py inspactdb
## create django system tables
python manage.py syncdb

```

Install and check by SQLDevelopper Tool

Connection Name: local
username: system
password: oracle
hostname: 127.0.0.1
port: 1521
sid: xe

You will find tables in tree menu

```buildoutcfg
Other Users
  DEVELOP
    Tables
      DJANGO_SESSION
```

## How to edit your code

"oracleDjango/django/src" folder of the host side is share folder to "/root/src" of django container.
You can edit host and container both.

## About migration

Django1.6 does not work well about manage.py migrate.
We should coding model first like this

https://co3k.org/blog/35

---

## oracle-container Password for SYS & SYSTEM:

Connect to Oracle Application Express web management console with following settings:

http://localhost:8080/apex
---
```
workspace: INTERNAL
user: ADMIN
password: 0Racle$
```

add _ for new password to convenient.

Apex upgrade up to v 5.*

docker run -it --rm --volumes-from ${DB_CONTAINER_NAME} --link ${DB_CONTAINER_NAME}:oracle-database -e PASS=YourSYSPASS sath89/apex install
Details could be found here: https://github.com/MaksymBilenko/docker-oracle-apex

Connect to Oracle Enterprise Management console with following settings:

http://localhost:8080/em
---
```buildoutcfg
user: sys
password: oracle
connect as sysdba: true
```
By Default web management console is enabled. To disable add env variable:

docker run -d -e WEB_CONSOLE=false -p 1521:1521 -v /my/oracle/data:/u01/app/oracle sath89/oracle-12c
#You can Enable/Disable it on any time
Start with additional init scripts or dumps:

docker run -d -p 1521:1521 -v /my/oracle/data:/u01/app/oracle -v /my/oracle/init/SCRIPTSorSQL:/docker-entrypoint-initdb.d sath89/oracle-12c
By default Import from docker-entrypoint-initdb.d is enabled only if you are initializing database (1st run).

To customize dump import use IMPDP_OPTIONS env variable like -e IMPDP_OPTIONS="REMAP_TABLESPACE=FOO:BAR"
To run import at any case add -e IMPORT_FROM_VOLUME=true

In case of using DMP imports dump file should be named like ${IMPORT_SCHEME_NAME}.dmp

User credentials for imports are ${IMPORT_SCHEME_NAME}/${IMPORT_SCHEME_NAME}
