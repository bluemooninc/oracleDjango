# Oracle django

本リポジトリでは docker-compose を使用して oracle-container と django-container を立ち上げてサンプルを動作させること可能となっています。

## 必要な物

- docker for Mac / Windows
- docker 利用に関する簡単な知識
- ORACLE 利用に関する簡単な知識

## Oracle container information

Oracle のコンテナは、 Docker-hub にある以下URLのイメージをPULLして利用します。

https://hub.docker.com/r/sath89/oracle-12c/ 


docker-compose up を実行すれば、コンテナが起動します。以下設定で ORACLE が利用できるようになっています。

```commandline
hostname: localhost
port: 1521
sid: xe
service name: xe
username: system
password: oracle
```

## Start django project

では、django のコンテナに入ってプロジェクトを進めてみます。

```commandline
docker exec -it django-container bash
```

### Creating an Environment 

generate django sample code. 

```
$ cd ~/src

## generate project
$ django-admin.py startproject mysite

## start local server 
$ cd mysite
$ python manage.py runserver 0.0.0.0:8000
```

## oracle settings
 
 https://orablogs-jp.blogspot.com/2017/09/cxoracle-rpms-have-landed-on-oracle.html
 
プロジェクト内のsettings.pyを修正します。具体的には

DATABASES = {
    'ENGINE': 'django.db.backends.oracle',
    'NAME' : '[ホスト名]:[ポート番号]/[サービス名]',
    'USER': '[ユーザー名]',
    'PASSWORD': '[パスワード]',
    #'HOST' : 'localhost',
    #,'PORT' : 1521,
}