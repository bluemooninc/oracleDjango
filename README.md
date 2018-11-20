# Oracle django

This repository build a django and oracle container by docker-compose

## you need

- docker for Mac / Windows
- how to use for docker basis
- how to use for ORACLE basis

## How to start

start docker container

```buildoutcfg
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
