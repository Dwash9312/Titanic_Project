#Set the Enviorment 
setwd("C:/Users/Dwash/Documents/Titanic_Project")
#Install Needed Packages
install.packages(c("tidyverse", "ggplot2", "dplyr", "caret", "rpart", "rpart.plot", "randomForest", "corrplot", "e1071", "readr"))
# Load the packages
library(tidyverse) #for data manipulation
library(ggplot2) #for visualizations
library(dplyr) 
library(caret) #for machine learning models
library(rpart) #for decision tree models
library(rpart.plot) #for decision tree models
library(randomForest) #for random forest models
library(corrplot) #for correlation analysis
library(e1071)
library(readr) #reading csv files
# Load the data sets
train <- read_csv("data/train.csv")
test <- read_csv("data/test.csv")
# Data Exploration & Cleaning
#Check Data Structure
str(train) # View data types
summary(train) # View basic summary statistics of datra
# Find missing values:
colSums(is.na(train))
# Replace missing values:
train$Age[is.na(train$Age)] <- median(train$Age, na.rm = TRUE)
train$Embarked[is.na(train$Embarked)] <- "S"
# Remove Unnecessary Columns
train <- train %>% select(-Cabin, -Name, -Ticket)
# Convert Categorical Variables
train$Sex <- as.factor(train$Sex)
train$Embarked <- as.factor(train$Embarked)
train$Survived <- as.factor(train$Survived)
# Exploratory Data Analysis (EDA)
#Visualizing Survival by Gender
ggplot(train, aes(x = Survived, fill = Sex)) +
  geom_bar() +
  labs(title = "Survival by Gender")
# Correlation Analysis
numeric_vars <- train %>% select(where(is.numeric))
corrplot(cor(numeric_vars, use = "complete.obs"), method = "circle")
# Feature Engineering
# Creating a Family Size variable.
train$FamilySize <- train$SibSp + train$Parch + 1
test$FamilySize <- test$SibSp + test$Parch + 1
#Summary of new Feature
summary(train$FamilySize)
#Model Training
set.seed(42)
train_index <- createDataPartition(train$Survived, p = 0.8, list = FALSE)
train_data <- train[train_index, ]
test_data <- train[-train_index, ]
model <- rpart(Survived ~ Pclass + Sex + Age + Fare + FamilySize, data = train_data, method = "class")
rpart.plot(model)
# Evaluation of the Model
pred <- predict(model, test_data, type = "class")
confusionMatrix(pred, test_data$Survived)
# Make Predictions on Test Data
final_pred <- predict(model, test, type = "class")
submission <- data.frame(PassengerId = test$PassengerId, Survived = final_pred)
write_csv(submission, "outputs/submission.csv")
