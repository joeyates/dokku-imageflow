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
```

Ensure that `$APP_DOMAIN` resolves to point to `$DOKKU_HOST`

```sh
$ dokku domains:set $DOKKU_APP $APP_DOMAIN
$ dokku config:set --no-restart $DOKKU_APP DOKKU_LETSENCRYPT_EMAIL=$DOMAIN_EMAIL
$ dokku letsencrypt:enable $DOKKU_APP
```

```sh
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
