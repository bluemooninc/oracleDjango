# Oracle django

This repository build a django and oracle container by docker-compose

## you need

- docker for Mac / Windows
- how to use for docker basis
- how to use for ORACLE basis

## How to start

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

## Oracle container information

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

## Start django project

login to django container

```commandline
docker exec -it django-container bash
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

 https://orablogs-jp.blogspot.com/2017/09/cxoracle-rpms-have-landed-on-oracle.html

set like below in settings.py

```buildoutcfg
DATABASES = {
    'ENGINE': 'django.db.backends.oracle',
    'NAME' : 'oracle-container:1521/xe',
    'USER': 'system',
    'PASSWORD': 'oracle',
}
```
## How to edit your code

"oracleDjango/django/src" folder of the host side is share folder to "/root/src" of django container.
You can edit host and container both.

## 1st migration to your db

Add 'south' in INSTALLED_APPS array in settings.py
This definition is setup for django south migration module.

```buildoutcfg
# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'south',
]
```

After that you can use migration command

```buildoutcfg
python manage.py migrate
```

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
