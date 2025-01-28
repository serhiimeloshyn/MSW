load("C:/Users/Владеец/Downloads/Math.RData")
class(Math$Grade)  # Проверяем класс переменной Grade


Math$Grade <- factor(Math$Grade, levels = c("B-", "B", "B+", "A-", "A", "A+"), ordered = TRUE)
class(Math$Grade)

table(Math$Grade)


library(ggplot2)
ggplot(Math, aes(x = Grade)) +
  geom_bar(fill = "steelblue", color = "black") +
  labs(title = "Četnosti Grade", x = "Grade", y = "Počet") +
  theme_minimal()


grade_counts <- table(Math$Grade)
pie(grade_counts, main = "Rozložení Grade", col = rainbow(length(grade_counts)))




ggplot(Math, aes(x = Grade)) +
  geom_density(stat = "count", fill = "blue", alpha = 0.1) +
  labs(title = "Frekvenční křivka Grade", x = "Grade", y = "Frekvence") +
  theme_minimal()





table(Math$Grade)
cumsum(table(Math$Grade))
prop.table(table(Math$Grade))
cumsum(prop.table(table(Math$Grade)))


2 okruh # Подключаем пакет для порядковой регрессии
library(MASS)

# Модель порядковой логистической регрессии
model <- polr(Grade ~ GPAadj + PlcmtScore + Rank + SATM + ACTM, data = Math, method = "logistic")

# Вывод результатов модели
summary(model)

# Вывод коэффициентов в экспоненциальной форме (одds ratios)
exp(coef(model))


library(ggplot2)

# Создаем предсказанные значения
Math$predicted_grade <- predict(model, newdata = Math, type = "class")

# Визуализация фактических и предсказанных значений
ggplot(Math, aes(x = Grade, fill = predicted_grade)) +
  geom_bar(position = "dodge") +
  labs(title = "Predicted vs Actual Grade", x = "Actual Grade", y = "Count") +
  theme_minimal()







