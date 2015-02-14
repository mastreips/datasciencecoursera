library(caret)
library(RANN)
library(dplyr)
setwd("~/Google Drive/Coursera/Machine Learning/Project")
set.seed(383838)

#parallel processing
library(doMC)
registerDoMC(cores = 4)

#import data
training <- read.csv("pml-training.csv", header=TRUE, 
                     na.strings=c("", " ","#DIV/0!")) #not sure about stringasfactors
testing <- read.csv("pml-testing.csv", header=TRUE, na.strings=c("", " ", "#DIV/0!"))

#Remove Unnessary fields and fields with all NAs
new_names <- sapply(testing[,1:160], mean)
na_fields <- as.data.frame(new_names, row.names=NULL)
na_fields$names <- rownames(na_fields)
fields <- filter(na_fields, new_names != "NA")
new_fields <- as.vector(fields[,2])
new_fields_sm <- new_fields[5:56]

new_testing <- testing[new_fields_sm]
new_training <- training[new_fields_sm]

#new transformation
new_testing <- as.data.frame(lapply(new_testing, as.numeric))
new_training <- as.data.frame(lapply(new_training, as.numeric))

table(is.na(new_training)) #no values are NA

#add back classe to training
new_training$classe <- training$classe

# partition data
inTrain <- createDataPartition(y=new_training$classe, p=0.75, list=FALSE)
train <- new_training[inTrain,]
test <- new_training[-inTrain,]

#crossValidation 
train_control <- trainControl(method="cv", number=3) 

# train the model 
model <- train(classe~., data=train, trControl=train_control, method="rf")  

#predict from model 
predict <- predict(model,train)
confusionMatrix(predict, train$classe)

predict2 <- predict(model, test)
confusionMatrix(predict2, test$classe)

#plotting importance of variables
varImpObj <- varImp(model)
plot(varImpObj)

#error rate
missClass = function(values, prediction) {
        sum(prediction != values)/length(values)
}
errRate = missClass(test$classe, predict2) #same as 1-accuracy

#submission code
pml_write_files = function(x){
        n = length(x)
        for(i in 1:n){
                filename = paste0("problem_id_",i,".txt")
                write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
        }
}

x <- new_testing
answers <- predict(model, newdata=x)
answers

pml_write_files(answers)
