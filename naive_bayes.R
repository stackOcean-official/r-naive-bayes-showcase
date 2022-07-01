#joni: setwd("~/Documents/dev/business/bonito")

require(quanteda)
require(quanteda.textmodels)
require(caret)
library(readr)

data = read.csv("data/labelled_data.csv")


set.seed(73)

# rename column so that we have a text number 
names(data)[names(data) == "review_body"] = "text"
corpus_resending = corpus(data)


# tokenize texts
toks = tokens(corpus_resending, remove_punct = TRUE, remove_number = TRUE) %>% 
  tokens_remove(pattern = stopwords("de")) %>% 
  tokens_wordstem()
dfmt = dfm(toks)
dfmt
toks

# get training set
dfmat_training = dfmt[1:20,]

# get test set (documents not in id_train)
dfmat_test = dfmt[21:nrow(dfmt),]

dfmat_test

# train classifier 
model_nb = textmodel_nb(dfmat_training, dfmat_training$topic)
summary(model_nb)

# check result accuracy
dfmat_matched = dfm_match(dfmat_test, features = featnames(dfmat_training))

actual_class = dfmat_matched$topic
predicted_class = predict(model_nb, newdata = dfmat_matched)
tab_class = table(actual_class, predicted_class)
tab_class

confusionMatrix(tab_class, mode = "everything")
