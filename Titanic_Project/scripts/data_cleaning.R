# Titanic Project - Data Cleaning

# Load Libraries
library(tidyverse)    
library(ggplot2)      
library(dplyr)        
library(caret)        
library(rpart)        
library(rpart.plot)   
library(randomForest) 
library(corrplot)     
library(e1071)        
library(readr)        

# Load Dataset
train <- read_csv("data/train.csv")
test <- read_csv("data/test.csv")

# Data Cleaning
train$Age[is.na(train$Age)] <- median(train$Age, na.rm = TRUE)
train$Embarked[is.na(train$Embarked)] <- "S"
train <- train %>% select(-Cabin, -Name, -Ticket)
train$Sex <- as.factor(train$Sex)
train$Embarked <- as.factor(train$Embarked)
train$Survived <- as.factor(train$Survived)
