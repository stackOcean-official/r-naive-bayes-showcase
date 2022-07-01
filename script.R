setwd("~/Documents/dev/business/topic_modelling_resending")

library(quanteda)
library(topicmodels)
library(corpus)
library(seededlda)

#text = c("I resent my stuff because the size was incorrect", "The computer was incompatible", "The size was too small", "The size was too large", "The device was incompatible with my computer")
#text = c("Das T-Shirt passte nicht weil die Größe zu klein war.", "Die Größe stimmte nicht. ", "Die Größe war zu klein.", "Das Gerät kam nicht in der richtigen Größe.", "Der Computer hatte einen Schaden.", "Es gab einen Schaden am Schrank.", "Die Scholle hatte geistige Schäden..")

text = read.csv("./data/aws_dataset_de_test.csv")

corpus_resending = corpus(text$review_body)
corpus_resending

corp = corpus_reshape(corpus_resending, to = "paragraphs")
dfm = dfm(corp, remove_punct=T, remove=stopwords("german"))
print(corp)

dtm = convert(dfm, to = "topicmodels") 
set.seed(35)
#m = LDA(dtm, method = "Gibbs", k = 2,  control = list(alpha = 0.1))
m = LDA(dtm, method = "Gibbs", k = 10)
m
summary(m)
terms(m, 6)

################ Seeded LDA ################
text = read.csv("./data/aws_dataset_de_test.csv")

corpus_resending = corpus(text$review_body)
ndoc(corpus_resending)

toks_aws <- tokens(corpus_resending, remove_punct = TRUE, remove_numbers = TRUE, remove_symbols = TRUE) %>% 
  tokens_remove(pattern = stopwords("de", source = "marimo")) %>% 
  tokens_keep(pattern = "^[\\p{script=Latn}]+$", valuetype = "regex")

# tokens_replace(toks_aws, pattern = lexicon::hash_lemmas$token, replacement = lexicon::hash_lemmas$lemma)

#dfmat_aws <- dfm(toks_aws) %>% 
# dfm_trim(min_termfreq = 0.8, termfreq_type = "quantile",
#          max_docfreq = 0.1, docfreq_type = "prop")
dfmat_aws <- dfm(toks_aws)

print(toks_aws)

# load dictionary containing seed words
dict_topic <- dictionary(file = "./dictionary/topics.yml")
print(dict_topic)

set.seed(35)
tmod_slda <- textmodel_seededlda(dfmat_aws, dictionary = dict_topic)
terms(tmod_slda, 20)
