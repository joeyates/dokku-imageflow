# dokku-imageflow

Run imageflow_server as a Dokku app

# Dokku Setup

Prepare your local config:

```sh
$ alias dokku='ssh -t dokku@$DOKKU_HOST 2>/dev/null'
```

Create .envrc.private with your settings

```sh
$ git remote add dokku dokku@$DOKKU_HOST:$DOKKU_APP
```

Ensure that the path $REMOTE_IMAGE_PATH exists on the server.

Create and deploy the app:

```sh
$ dokku apps:create $DOKKU_APP
$ dokku docker-options:add $DOKKU_APP deploy "-v imageflow_data:/home/imageflow/data -v $REMOTE_IMAGE_PATH:/home/imageflow/images"
$ git push dokku
```

If necessary, install the letsencrypt plugin:

```sh
$ dokku-root plugin:install https://github.com/dokku/dokku-letsencrypt.git
```

Ensure that $APP_DOMAIN resolves to point to $DOKKU_HOST

Get a Let's Encrypt certificate:

```sh
$ dokku certs:generate $DOKKU_APP $APP_DOMAIN
$ dokku proxy:ports-set $DOKKU_APP "http:80:3000 https:443:3000"
$ dokku config:set --no-restart $DOKKU_APP DOKKU_LETSENCRYPT_EMAIL=admin@$APP_TLD
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

# Usage

Params:
https://imageresizing.net/docs/basics

Docs:
https://docs.imageflow.io/introduction.html

# Development

```sh
$ docker build -t dokku-imageflow:latest .
$ export LOCAL_IMAGE_PATH={{path to images}}
$ docker run --rm -t -i -p3000:3000 -v imageflow_data:/home/imageflow/data -v $LOCAL_IMAGE_PATH:/home/imageflow/images dokku-imageflow:latest
```
