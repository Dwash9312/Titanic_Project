#Model Training
set.seed(42)
train_index <- createDataPartition(train$Survived, p = 0.8, list = FALSE)
train_data <- train[train_index, ]
test_data <- train[-train_index, ]
model <- rpart(Survived ~ Pclass + Sex + Age + Fare + FamilySize, data = train_data, method = "class")
rpart.plot(model)