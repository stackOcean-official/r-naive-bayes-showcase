require(quanteda)
require(quanteda.textmodels)
require(caret)

# generate 1500 numbers without replacement
set.seed(73)
id_train <- sample(1:2000, 1500, replace = FALSE)
head(id_train, 10)

# create docvar with ID
data$id <- 1:ndoc(data)

# tokenize texts
toks <- tokens(data, remove_punct = TRUE, remove_number = TRUE) %>% 
  tokens_remove(pattern = stopwords("de")) %>% 
  tokens_wordstem()
dfmt <- dfm(toks)

# get training set
dfmat_training <- dfm_subset(dfmt, id %in% id_train)

# get test set (documents not in id_train)
dfmat_test <- dfm_subset(dfmt, !id %in% id_train)

# train classifier 
tmod_nb <- textmodel_nb(dfmat_training, dfmat_training$label)
summary(tmod_nb)