У ТЕБЯ ТАКОЙ ЖЕ ХАРАКТЕРИСТИКИ КАТЕГОРИТСКА ПЕРЕМЕННАЯ НО У МЕНЯ ЕЙ ВООБЩЕ НЕ ВИДИТ 

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







2 okruh ВОТ ВТОРОЕ ЗАДАНИЕ ПОПРОБУЙ ПОМЕНЯТЬ ПЕРЕМЕННЫЕ ДАННЫЕ КОНЧЕНЫЕ У МЕНЯ ИХ НЕ ВИДИТ ВООБЩЕ ПК

# Создаем бинарную переменную: больше 50% женщин или нет
Zkouska$women <- ifelse(Zkouska$women > 50, 1, 0)

# Выбираем две группы профессий
prof_group <- subset(Zkouska, type == "prof")
bc_group <- subset(Zkouska, type == "bc")

# Размер выборок
n1 <- nrow(prof_group)  # Количество профессий в "prof"
n2 <- nrow(bc_group)    # Количество профессий в "bc"

# Количество профессий с высокой долей женщин
x1 <- sum(prof_group$women_high, na.rm = TRUE)
x2 <- sum(bc_group$women_high, na.rm = TRUE)

# Вычисляем подели
p1 <- x1 / n1
p2 <- x2 / n2

cat("Podíl profesí s vysokým zastoupením žen (prof):", p1, "\n")
cat("Podíl profesí s vysokým zastoupením žen (bc):", p2, "\n")

# Разница поделей
diff_p <- p1 - p2
cat("Rozdíl podílů mezi skupinami:", diff_p, "\n")

# Доверительный интервал для разницы поделей
alpha <- 0.05
z <- qnorm(1 - alpha/2)
SE1 <- sqrt((p1 * (1 - p1)) / n1)
SE2 <- sqrt((p2 * (1 - p2)) / n2)
SE_diff <- sqrt(SE1^2 + SE2^2)

CI_lower <- diff_p - z * SE_diff
CI_upper <- diff_p + z * SE_diff

cat("Intervalový odhad rozdílu podílů (95% CI): [", CI_lower, ",", CI_upper, "]\n")

# 📊 Визуализация
library(ggplot2)
data <- data.frame(
  Skupina = c("Profese - prof", "Profese - bc"),
  Podíl = c(p1, p2)
)

ggplot(data, aes(x = Skupina, y = Podíl, fill = Skupina)) +
  geom_bar(stat = "identity", color = "black") +
  labs(title = "Podíl profesí s vysokým zastoupením žen",
       x = "Typ profese", y = "Podíl") +
  theme_minimal()



