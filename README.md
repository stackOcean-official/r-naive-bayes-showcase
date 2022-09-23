# kisu-bonito

Running and deploying a Naive Bayes classifier for text data using R and Docker. You can use this NLP classifier to understand natural language sentences and assign a label to them.
There is no built-in way in R to do this task, so we created a classifier for it ourselves.

This example is for a German language use case, but it can be used for any language with simple modifications.

## run using example data:

### If you just want to run the model locally:
Use an editor like RStudio and make sure that you set your working directory. Then run the following commands within R Studio to install the required packages:
```
install.packages("quanteda")
install.packages("quanteda.textmodels")
install.packages("caret")
install.packages("readr")
```
Run the "predict.R" script. 

### If you would like to run model in docker: 

#### Make sure that a current version of docker is installed on your machine. If you do not have docker installed, check this link: https://docs.docker.com/engine/install/ 

How to build
Use this command to build your docker container. Note that this can take several minutes up to an hour to build because some required packages may need to be installed from source. 

```
docker build -t kisu-bonito .
```

How to run

Use this command to run the dockerfile in the background. Note that if you localhost 8000 port is already in use, you need to choose another port.

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

If you do not work with German text data, you need to change the language when removing stop words in the "train.R" script (also marked as "TODO"" in the script). The languages that are supported by Quanteda can be seen here: https://tutorials.quanteda.io/multilingual/english-german/

### Run the model with your custom data in docker: 

#### Make sure that a current version of docker is installed on your machine. If you do not have docker installed, check this link: https://docs.docker.com/engine/install/ 

To start the training run:
Note that this step is not needed if you use our example data since the resulting model is included in the folder "model".

```
Rscript src/train.R
```

How to build
Use this command to build your docker container. Note that this can take several minutes up to an hour to build because some required packages may need to be installed from source. 

```
docker build -t kisu-bonito .
```

How to run

Use this command to run the dockerfile in the background. Note that if you localhost 8000 port is already in use, you need to choose another port.

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

### Run the model with your custom data in RStudio: 

If you have not done when running the script with example data, run the following commands within R Studio to install the required packages:
```
install.packages("quanteda")
install.packages("quanteda.textmodels")
install.packages("caret")
install.packages("readr")
```

Make sure your custom data is in the right format and that the name and file path of the data set are correctly set. Then run the script "train.R" which will retrain the model and overwrite the current model in the model folder. 

Then run the script "predict.R". 
