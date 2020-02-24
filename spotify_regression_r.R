install.packages("tidyverse")
install.packages("glmnet")
install.packages("car")

library(tidyverse)
library(glmnet)
library(car)

#load data in
features <- read.csv('C:/Users/Liesl/Desktop/Resumes/Untitled Folder/song_features_encoded.csv')

#TEST THROUGH FULL VARIABLE SET
#subset into features and target var. note if you choose a new artist you may have to change column ## based on how many time sig values you have
x <- as.matrix(features[,-c(1,15)]) #include all variables (except row# and target)
y <- features[,15] #target

#finding optimal value of lambda
cv.lasso <- cv.glmnet(x, y, alpha = 1, family = "binomial")
cv.lasso$lambda.min
cv.lasso$lambda.1se

#view coefficients of variables
coef(cv.lasso,cv.lasso$lambda.min)
coef(cv.lasso,cv.lasso$lambda.1se)
#RESULT: both min and 1se keep: acousticness, duration_ms, energy, liveness, loudness, tempo, time signatures

#keep only the vars that the lasso kept, remove second ts as it is redundant info (what is 0 in ts3 is 1 in ts4)
x.lasso <- as.matrix(features[,c(2,4,5,8,9,11,13)])
#get new lambdas
cv.lasso.new <- cv.glmnet(x.lasso, y, alpha = 1, family = "binomial")
coef(cv.lasso.new,cv.lasso.new$lambda.min)

#model from chosen vars, use lambda.min to get lambda for most accurate model
lasso.model <- glmnet(x, y, alpha = 1, family = "binomial",
                      lambda = cv.lasso$lambda.min)

# view accuracy of model on current data
probabilities <- lasso.model %>% predict(newx = x)
predicted.classes <- ifelse(probabilities > 0.5, 1, 0)

#check accuracy
observed.classes <- features$album
mean(predicted.classes == observed.classes)