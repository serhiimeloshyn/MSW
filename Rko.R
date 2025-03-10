У МЕНЯ НЕ ВИДИТ ДАННЫЕ ВОТ РЕШЕНИЕ НО ТЫ СМОТРИ ПО СУЩЕСТВУ В КАЖДОМ ПРИКАЗЕ ЕСТЬ  useNA = "ifany") ЭТО ЧТОБЫ НЕВИДЕТЬ NA ЗНАЧЕННИЯ НЕ ЗНАЮ НА СКОЛЬКО РАБОТАЕТ

# Преобразуем Type в упорядоченный фактор (без NA как уровня)
Zkouska$Type <- factor(Zkouska$Type, levels = c("prof", "bc", "wc"), ordered = TRUE)

# Проверяем класс переменной Type
class(Zkouska$Type)

# Создание таблицы частот (учитываем NA)
table(Zkouska$Type, useNA = "ifany") # Přidá NA jako kategorii

# Кумулятивная абсолютная частота
cumsum(table(Zkouska$Type, useNA = "ifany"))

# Относительные частоты (процентное распределение)
prop.table(table(Zkouska$Type, useNA = "ifany"))

# Кумулятивные относительные частоты
cumsum(prop.table(table(Zkouska$Type, useNA = "ifany")))

# Объединение всех вычисленных значений в одну таблицу
freq_table <- cbind(
  "bezne abs. cetnosti" = table(Zkouska$Type, useNA = "ifany"),
  "kumulativni abs. cetnosti" = cumsum(table(Zkouska$Type, useNA = "ifany")),
  "bezne rel. cetnosti" = round(prop.table(table(Zkouska$Type, useNA = "ifany")), 4),
  "kumulativni rel. cetnosti" = cumsum(round(prop.table(table(Zkouska$Type, useNA = "ifany")), 4))
)

# Вывод таблицы
print(freq_table)

# 📊 Гистограмма (столбчатый график) с ggplot2
library(ggplot2)
ggplot(Zkouska, aes(x = Type)) +
  geom_bar(fill = "steelblue", color = "black") +
  labs(title = "Četnosti Type", x = "Type", y = "Počet") +
  theme_minimal()

# 📊 Круговая диаграмма
type_counts <- table(Zkouska$Type, useNA = "ifany")
pie(type_counts, main = "Rozložení Type", col = rainbow(length(type_counts)))

# ❗ Удалено `geom_density()`, так как Type — категориальная переменная!

# 📊 Столбчатая диаграмма (barplot)
barplot(table(Zkouska$Type, useNA = "ifany"), col = "purple", 
        main = "Sloupcový graf pro proměnnou Type", 
        ylab = "Počty")







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



