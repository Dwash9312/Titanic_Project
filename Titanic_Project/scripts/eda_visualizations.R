#Visualizing Survival by Gender
ggplot(train, aes(x = Survived, fill = Sex)) +
  geom_bar() +
  labs(title = "Survival by Gender")
# Correlation Analysis
numeric_vars <- train %>% select(where(is.numeric))
corrplot(cor(numeric_vars, use = "complete.obs"), method = "circle")