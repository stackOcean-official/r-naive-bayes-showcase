set = read.csv("./data/aws_dataset_de_train.csv")
unique = unique(set$product_category)
unique                
subset = set[set$product_category == 'shoes',]
subset = subset[ ,c("review_body", "product_category")]
subset[ ,c("topic")] <- NA
write.csv(subset,"./data/aws_dataset_de_train_subset.csv", row.names = seq.int(nrow(subset)))
