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
Příklad s lineární závislostí:
# Выбираем переменные
x <- Math$SATM   # замените на нужную переменную
y <- Math$PSATM  # замените на нужную переменную

# Вычисление коэффициента корреляции
cor(x, y)

# Построение графика рассеяния
plot(x, y, main = "Scatter plot mezi SATM a PSATM", xlab = "SATM", ylab = "PSATM", pch = 19)
(Как интерпретировать результат?
Коэффициент > 0.7 → сильная положительная корреляция
Коэффициент между 0.3 и 0.7 → средняя положительная корреляция
Коэффициент < 0.3 → слабая или отсутствующая корреляция
Отрицательный коэффициент → чем выше одна переменная, тем ниже другая (обратная зависимость).) это для Příklad s lineární závislostí:

№Pro sinusoidu:

x <- Math$PlcmtScore  # Независимая переменная
y <- sin(Math$SATM)   # Преобразуем SATM в синусоидальную форму

# Вычисляем корреляцию
correlation <- cor(x, y)
print(paste("Korelace mezi PlcmtScore a sin(SATM):", correlation))

# Рисуем график рассеяния
plot(x, y, main = "Scatter plot mezi PlcmtScore a sin(SATM)", xlab = "PlcmtScore", ylab = "sin(SATM)", pch = 19)
(nalýza výsledků:
Tvar závislosti

Z grafu je vidět, že body jsou rozloženy chaoticky, ale hodnoty sin(SATM) se pohybují v rozsahu [-1,1].
To je typické pro nelineární (sinusovou) závislost.
Korelace (cor(PlcmtScore, sin(SATM)))

Pravděpodobně je korelační koeficient blízký nule.
To znamená, že neexistuje lineární vztah mezi proměnnými, ale může existovat nelineární souvislost.) это для Pro sinusoidu обьяснение


№Nelineární závislost:
x <- Math$PlcmtScore  # Независимая переменная
y_quad <- x^2         # Квадратичное преобразование

# Вычисляем корреляцию
correlation <- cor(y_quad, Math$CourseSuccess)
print(paste("Korelace mezi PlcmtScore^2 a CourseSuccess:", correlation))

# Рисуем график зависимости
plot(x, y_quad, type = "l", col = "red", main = "Kvadratická závislost", xlab = "PlcmtScore", ylab = "PlcmtScore^2")

(Если correlation маленький, но на графике заметна изогнутая кривая, то связь есть, но она не линейная.)



Kontingenční tabulka (pro kategorické proměnné)
table(Math$Gender, Math$Grade)
prop.table(table(Math$Gender, Math$Grade))
mosaicplot(table(Math$Gender, Math$Grade), col = c("red", "blue"), main = "Mosaic Plot: Gender vs. Course Success")

Testování korelace
# Вычисляем ковариацию между PlcmtScore и SATM
cov(Math$PlcmtScore, Math$SATM)
# Вычисляем корреляцию между теми же переменными
cor(Math$PlcmtScore, Math$SATM)  Вычислив ковариацию, вы увидите, как PlcmtScore и SATM изменяются вместе.




cor.test(Math$PlcmtScore, Math$SATM)  # Проверьте корреляцию между двумя переменными

📌 Что означают результаты?

p-value < 0.05 → корреляция значимая, переменные действительно связаны.
p-value > 0.05 → корреляция незначимая, переменные скорее всего независимы.
Корреляция > 0.7 или < -0.7 → сильная связь.
Корреляция между 0.3 и 0.7 → средняя связь.
Корреляция < 0.3 → слабая связь.

cor.test(Math$PlcmtScore, Math$SATM, method = "spearman")
📌 Этот тест подходит, если переменные меняются в одном направлении, но не обязательно линейно.


корелачни 3 переменные

data_subset <- Math[, c("PlcmtScore", "SATM", "CourseSuccess")]

correlation_matrix <- cor(data_subset)

print(correlation_matrix)
📌 Интерпретация:
Значения от -1 до 1 показывают силу и направление связи между переменными.
Если коэффициент > 0.7 → сильная положительная связь.
Если коэффициент < -0.7 → сильная отрицательная связь.
Если коэффициент близок к 0 → переменные не связаны.


тепловая карта корреляций
library(corrplot)
corrplot(correlation_matrix, method = "color", addCoef.col = "black", tl.col = "black", tl.srt = 45)




cov(Math$PlcmtScore, Math$SATM)
Ковариация измеряет, как две переменные изменяются вместе.
Результат может быть:

Положительным (cov > 0)
→ Если одна переменная увеличивается, вторая также увеличивается.
→ Это указывает на положительную связь между PlcmtScore и SATM.

Отрицательным (cov < 0)
→ Если одна переменная увеличивается, вторая уменьшается.
→ Это указывает на обратную связь (когда PlcmtScore растёт, SATM падает, и наоборот).

Близким к нулю (cov ≈ 0)
→ Это означает, что между переменными нет линейной связи.

cov(Math$PlcmtScore, Math$SATM) покажет направление связи между переменными.


💡 Что лучше использовать?
✅ Используйте cor(), если хотите понять силу и направление связи между переменными.                                                           
⚠️ Используйте cov() только в редких случаях, если вам важно абсолютное изменение величин, но не их относительная зависимость.

📌 Вывод:

cov() полезна, если вас интересует не стандартизованная совместная изменчивость.
cor() лучше, если вас интересует масштабируемая и сравнимая мера связи между переменными.
Если вы сомневаетесь — используйте cor(), так как она более наглядна. 😊
💡 Co je lepší použít?
✅ Použijte cor(), pokud chcete pochopit sílu a směr vztahu mezi proměnnými.
⚠️ Použijte cov() pouze ve vzácných případech, pokud vás zajímá absolutní změna veličin, ale ne jejich relativní závislost.

📌 Závěr:

cov() je užitečné, pokud vás zajímá nestandardizovaná společná variabilita.
cor() je lepší, pokud vás zajímá škálovatelná a srovnatelná míra vztahu mezi proměnnými.
Pokud si nejste jistí, použijte cor(), protože je přehlednější a snadněji interpretovatelná. 😊

