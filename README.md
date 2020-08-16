# dokku-imageflow

Run imageflow_server as a Dokku app

# Development

```sh
$ docker build -t dokku-imageflow:latest .
$ export IMAGE_PATH={{path to images}}
$ docker run --rm -t -i -p3000:3000 -v imageflow_data:/home/imageflow/data -v $IMAGE_PATH:/home/imageflow/images dokku-imageflow:latest
```

# Dokku Setup

Prepare your local config:

```sh
$ alias dokku='ssh -t dokku@$DOKKU_HOST 2>/dev/null'
$ export DOKKU_HOST={{your Dokku host}}
$ export DOKKU_APP={{the name for your new Dokku app}}
$ export IMAGE_PATH={{remote path to images}}
$ export DOMAIN_NAME={{the DNS-registered domain name to serve images from}}
```

Create and deploy the app:

```sh
$ dokku apps:create $DOKKU_APP
$ dokku docker-options:add $DOKKU_APP deploy "-p3000:3000 -v imageflow_data:/home/imageflow/data -v $IMAGE_PATH:/home/imageflow/images"
$ git push dokku
```

Get a Let's Encrypt certificate:

```sh
$ dokku certs:generate $DOKKU_APP $DOMAIN_NAME
$ dokku proxy:ports-add $DOKKU_APP http:80:3000 https:443:3000
$ dokku config:set --no-restart $DOKKU_APP DOKKU_LETSENCRYPT_EMAIL=admin@$DOMAIN_NAME
```

Double check ports: should be 80->3000 443->3000

```sh
$ dokku proxy:ports $DOKKU_APP
-----> Port mappings for ...
    -----> scheme  host port  container port
    http           80         3000
    https          443        3000
```

Make sure everything works via Let's Encrypt's staging server:

```sh
$ dokku config:set --no-restart $DOKKU_APP DOKKU_LETSENCRYPT_SERVER=staging
$ dokku letsencrypt $DOKKU_APP
```

Get the actual certificate:

```sh
$ dokku config:unset --no-restart $DOKKU_APP DOKKU_LETSENCRYPT_SERVER
$ dokku letsencrypt $DOKKU_APP
```
