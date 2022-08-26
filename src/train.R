library(quanteda)
library(quanteda.textmodels)
library(caret)
library(readr)


# TODO: change to your filename
data = read.csv("data/aws_dataset_de_train_subset.csv", sep=";")

# build corpus object 
corpus_resending = corpus(data)

# tokenize texts
# TODO: Change "de" to the language of your training data
toks = tokens(corpus_resending, remove_punct = TRUE, remove_number = TRUE) %>% 
  tokens_remove(pattern = stopwords("de")) %>% 
  tokens_wordstem()
 
# get training set in dfm format 
dfmat_training = dfm(toks)

# train classifier 
model_nb = textmodel_nb(dfmat_training, dfmat_training$topic)

# save model
saveRDS(model_nb, "model/model.rds")
write.csv(featnames(dfmat_training),"./data/featurenames.csv", row.names = FALSE)
