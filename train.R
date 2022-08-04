
require(quanteda)
require(quanteda.textmodels)
require(caret)
library(readr)

data = read.csv("data/aws_dataset_de_train_subset.csv", sep=";")

set.seed(73)

# rename column so that we have a text number 
names(data)[names(data) == "review_body"] = "text"
corpus_resending = corpus(data)

# tokenize texts
toks = tokens(corpus_resending, remove_punct = TRUE, remove_number = TRUE) %>% 
  tokens_remove(pattern = stopwords("de")) %>% 
  tokens_wordstem()
dfmt = dfm(toks)
 
# get training set
dfmat_training = dfmt

# train classifier 
model_nb = textmodel_nb(dfmat_training, dfmat_training$topic)

# save model
saveRDS(model_nb, "model/model.rds")
write.csv(featnames(dfmat_training),"./data/featurenames.csv", row.names = FALSE)


