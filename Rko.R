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




Histogram a jeho citlivost na volbu offsetu a šířky okna
Co je histogram?
Histogram je grafické znázornění frekvenčního rozdělení dat. Ukazuje, jak často se jednotlivé hodnoty nebo intervaly hodnot vyskytují v souboru dat. Je užitečný pro analýzu tvaru rozdělení, identifikaci odlehlých hodnot a vizualizaci hustoty dat.

Důležité parametry histogramu
Šířka binu (šířka okna)

Určuje, jak velké intervaly budou použity k seskupení dat.
Malá šířka binu znamená detailnější, ale často „hlučné“ rozdělení.
Velká šířka binu vede k hladšímu, ale méně detailnímu zobrazení.
Neexistuje univerzální správná šířka binu – je nutné ji optimalizovat dle dat.
Offset (posunutí počátečního bodu binů)

Definuje, kde začne první bin histogramu.
Malé změny offsetu mohou ovlivnit interpretaci histogramu, zejména pokud data obsahují opakující se vzory.
Nesprávný offset může zkreslit rozdělení dat a vést k nesprávným závěrům.
Vliv volby šířky binu a offsetu
Příliš úzké biny → histogram obsahuje příliš mnoho sloupců, což může vést k nesprávné interpretaci šumu v datech.
Příliš široké biny → histogram ztrácí detaily a může skrýt důležité vzory v datech.
Špatný offset → může způsobit zdánlivé posuny v rozdělení, což může vést k nesprávné interpretaci tvaru dat.
Jak správně volit šířku binu a offset?
Použít standardní metody pro volbu optimální šířky binu (např. Sturgesovo pravidlo, Scottovo pravidlo nebo Freedman-Diaconisovo pravidlo).
Experimentovat s různými hodnotami šířky binu a offsetu a vizuálně porovnávat výsledky.
Pokud data mají periodickou strukturu, dbát na správné nastavení offsetu, aby histogram nepůsobil zkresleně.
Histogram je silný nástroj pro analýzu dat, ale jeho interpretace závisí na správné volbě parametrů. Proto je vždy důležité testovat různé kombinace šířky binu a offsetu, aby byla získána co nejvěrnější vizualizace rozložení dat.

Další klíčové aspekty histogramu
1️⃣ Počet binů a metody jejich určení
Výběr optimálního počtu binů (šířky binu) není triviální a existují různé metody pro jeho určení:

Sturgesovo pravidlo:
𝑘
=
1
+
log
⁡
2
(
𝑛
)
k=1+log 
2
​
 (n)
kde 
𝑘
k je počet binů a 
𝑛
n je počet pozorování. Tato metoda je jednoduchá, ale nemusí být vhodná pro velké soubory dat.
Scottovo pravidlo:
ℎ
=
3.5
⋅
𝜎
𝑛
1
/
3
h= 
n 
1/3
 
3.5⋅σ
​
 
kde 
ℎ
h je optimální šířka binu, 
𝜎
σ je směrodatná odchylka a 
𝑛
n je počet pozorování. Funguje dobře pro normálně rozdělená data.
Freedman-Diaconisovo pravidlo:
ℎ
=
2
⋅
𝐼
𝑄
𝑅
𝑛
1
/
3
h= 
n 
1/3
 
2⋅IQR
​
 
kde 
𝐼
𝑄
𝑅
IQR je interkvartilové rozpětí. Tato metoda je vhodná pro data s odlehlými hodnotami.
2️⃣ Histogram vs. jádrový odhad hustoty (KDE – Kernel Density Estimation)
Histogram může být nahrazen jádrovým odhadem hustoty (KDE), který vytváří hladší křivku místo sloupců.
KDE pomáhá odstranit problémy se šířkou binu, protože nevyužívá pevné intervaly, ale rozprostírá vliv každého bodu přes spojitou křivku.
KDE je obzvláště užitečný pro analýzu malých datových souborů nebo tam, kde je důležité zobrazit přesnější tvar rozdělení.
3️⃣ Praktické problémy při práci s histogramy
Špatná vizualizace: Příliš široké nebo úzké biny mohou vést ke špatné interpretaci dat.
Zkreslení dat: Nevhodně zvolený offset může způsobit posunutí sloupců a tím zkreslit interpretaci rozdělení.
Odlehlé hodnoty: Histogram může zvýraznit nebo naopak skrýt odlehlé hodnoty v závislosti na volbě parametrů.
4️⃣ Interpretace histogramu a jeho vlastnosti
Symetrie vs. asymetrie – pokud je histogram vychýlený, může to znamenat zkosené rozdělení.
Modální charakteristika – unimodální histogram (jedna špička) vs. multimodální histogram (více špiček).
Přítomnost mezer – pokud histogram obsahuje „díry“ (nulové četnosti mezi biny), může to být způsobeno nevhodnou volbou binů nebo přirozenou strukturou dat.
Shrnutí
Histogram je silný nástroj pro vizualizaci dat, ale jeho interpretace silně závisí na správné volbě šířky binu, offsetu a počtu binů.
Důležité je testovat různé hodnoty těchto parametrů a v případě potřeby použít alternativní metody jako KDE (jádrový odhad hustoty) pro získání hladšího a přesnějšího přehledu o rozložení dat.

👉 Neexistuje univerzální správné nastavení histogramu – vždy záleží na konkrétních datech!























