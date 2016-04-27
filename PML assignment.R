#importing data
training <- read.csv("pml-training.csv")
testing <- read.csv("pml-testing.csv")

#creating partition for training and validation of models
inTrain <- createDataPartition(y=training$classe, p=0.6, list=FALSE)
training1 <- training[inTrain, ]
testing1 <- training[-inTrain, ]

#while trying to predict testing data we found that NA values in data prevents most models from
#corectly predicting right answers.
#So, taking to a mind that our goal is to find right answers on test data,
#we have to select only columns with complete data in testing sequence.
colselect <- complete.cases(t(testing))
training2 <- training2[,colselect]

#now we got only 60 columns, which have complete observations in testing sequence
#also, we have to clear the first 7 columns from dataset,which doesn't contain motion data
#these are "X"  "user_name" "raw_timestamp_part_1" "raw_timestamp_part_2"
# "cvtd_timestamp"       "new_window"           "num_window"
training2 <- training2[,-1]
training2 <- training2[,-1]
training2 <- training2[,-1]
training2 <- training2[,-1]
training2 <- training2[,-1]
training2 <- training2[,-1]
training2 <- training2[,-1]

#now we are ready to train model
model1 <- train(classe ~ ., data=training2, method="rf", n.trees=100)

#checking model on training-testing dataset
summary(predict(model1,testing1)==testing1$classe)

#in my case I got 7779 true values against 67 false values. Accuracy = 99%.

#predicting test cases
predict(model1,testing)
# got a result :  [1] B A B A A E D B A A B C B A E E A B B B
# Levels: A B C D E
# now we are ready to submit this result to final quiz