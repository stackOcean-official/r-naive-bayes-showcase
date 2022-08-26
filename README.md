### kisu-bonito

Running and deploying a Naive Bayes classifier for text data using R and Docker

## How to run

## run using example data:

If you just want to run the model locally, run the "predict.R" script in an editor like RStudio. 

But before you run the script, run the following commands within R Studio to install the packages:
```
install.packages("quanteda")
install.packages("quanteda.textmodels")
install.packages("caret")
install.packages("readr")
```

If you would like to run model in docker: 

# How to build

```
docker build -t kisu-bonito .
```

# How to run

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

## run using your custom data:

Your custom training data needs to have the same structure as the example data: One row with an index for each observation, one row named "text" which includes each observation of your text data and one row that contains the label you set for each observation. 

If you do not work with German text data, you need to change the language when removing stop words in the "train.R" script. The languages that are supported by Quanteda can be seen here: https://tutorials.quanteda.io/multilingual/english-german/

# Run the model with your custom data in docker: 

To start the training run:

```
Rscript src/train.R
```

Docker:

How to build:

```
docker build -t kisu-bonito .
```

To run the dockerfile in the background:

```
docker run --rm -p 8000:8000 --name r-shiny kisu-bonito
```

To stop the server:

```
docker stop r-shiny
```

To view logs of the container:

```
docker logs r-shiny
```

# Run the model with your custom data in RStudio: 

Make sure your custom data is in the right format. Then run the script "train.R" which will retrain the model and save it in the model folder. 
