setwd("~/Documents/dev/business/topic_modelling_resending")

library(quanteda)
library(topicmodels)
library(corpus)

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



