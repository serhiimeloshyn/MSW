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
