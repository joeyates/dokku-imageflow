# Development

```sh
$ docker build -t dokku-imageflow:latest .
$ export IMAGE_PATH={{path to images}}
$ docker run --rm -t -i -p3000:3000 -v imageflow_data:/home/imageflow/data -v $IMAGE_PATH:/home/imageflow/images dokku-imageflow:latest
```
