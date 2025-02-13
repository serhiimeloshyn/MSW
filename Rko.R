Math$Grade <- factor(Math$Grade, levels = c("B-", "B", "B+", "A-", "A", "A+"), ordered = TRUE)#Преобразует переменную Grade в упорядоченный фактор (ordered factor). Převádí proměnnou Grade na seřazený faktor (ordered factor).
class(Math$Grade)#Проверяем класс переменной Grade
table(Math$Grade) #Создает таблицу частот (сколько раз встречается каждая оценка). Vytvoří frekvenční tabulku, která ukazuje, kolikrát se každá známka vyskytuje.
cumsum(table(Math$Grade))#Каждое значение — это сумма текущей категории и всех предыдущих. Každá hodnota je součet aktuální kategorie a všech předchozích.
prop.table(table(Math$Grade))#Результат показывает, какую часть от всех данных составляет каждая оценка. Vypočítá relativní četnosti (procentuální zastoupení).
cumsum(prop.table(table(Math$Grade)))#Вычисляет кумулятивную сумму относительных частот. Vypočítá kumulativní součet relativních četností.

cbind(
  "bezne abs. cetnosti" = table(Math$Grade),
  "kumulativni abs. cetnosti" = cumsum(table(Math$Grade)),
  "bezne rel. cetnosti" = round(prop.table(table(Math$Grade)), 4),
  "kumulativni rel. cetnosti" = cumsum(round(prop.table(table(Math$Grade)), 4))
)
# Эта таблица объединит все вычисленные значения в одном месте.

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

barplot(table(Math$Grade), col="purple", main="Sloupcový graf pro proměnnou Grade", ylab="Počty")







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

в том что ниже я не уверен 
Math$predicted_grade <- predict(model, newdata = Math, type = "class")

# Создание числовых значений для категориального Grade
Math$grade_numeric <- as.numeric(Math$Grade)
Math$predicted_numeric <- as.numeric(Math$predicted_grade)

# Вычисление остатков (разница между фактическим и предсказанным)
Math$residuals <- Math$grade_numeric - Math$predicted_numeric

# Вывод первых значений остатков
head(Math$residuals)

library(ggplot2)

ggplot(Math, aes(x = predicted_numeric, y = residuals)) +
  geom_point(color = "blue") +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  labs(title = "Rezidua pro predikované Grade", x = "Predikované hodnoty", y = "Rezidua (chyby)") +
  theme_minimal()

https://docs.google.com/document/d/1tRNBcJ7EVEuZmXkVf3hLXjie8AHWZ177tJYBKy0zles/edit?tab=t.0#heading=h.15q3e55xuq5f

https://docs.google.com/document/d/1XQCyFJW5FKkd17fKEFhv7FK9P2ZoebiXOkbTZzPk4Qs/edit?usp=sharing
