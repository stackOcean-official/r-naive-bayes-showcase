# kisu-bonito

Deployment of a R Naive Bayes classifier using Docker

## How to run

To start the training run:

```
Rscript src/train.R
```

## Docker

### How to build

```
docker build -t kisu-bonito .
```

### How to run

Use this command to run the dockerfile in the background

```
docker run --rm -p 8000:8000 --name r-shiny kisu-bonito
```

To stop the server, use this command

```
docker stop r-shiny
```

To view logs of the container run

```
docker logs r-shiny
```
