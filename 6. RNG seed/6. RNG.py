# POZOR: Tento skript využívá knihovnu easygui. Nutno nainstalovat přes "pip install easygui".
# Tento skript je v raw python souboru, poněvadž jupyter měl problémy s easygui.

# Tento skript vytvoří seed do pseudonáhodného generátoru pomocí:
#   - Načteného obrázku
#   - Času spotřebovaného na vybraní obrázku a jeho zpracování (kvůli vyšší náhodnosti)

import easygui
import numpy
from matplotlib.pyplot import imread
import timeit

def read_image() -> str:
    return easygui.fileopenbox("Please, select an image from your computer.", filetypes=["*.png", "*.jpeg", "*.jpg"])

def file_type_check(path:str) -> bool:
    return ".png" in path or ".jpeg" in path or ".jpg" in path

def process_image() -> int:

    # Zapnutí časovače
    start_timer = timeit.default_timer()

    # Načtení obrázku
    path = read_image()
    assert file_type_check(path), "Included file must be of type: .png, .jpeg or .jpg"
    num_array = imread(path)

    # Vytvoření seedu
    size = num_array.size
    values = num_array.sum()

    # Vypnutí časovače
    elapsed = timeit.default_timer() - start_timer

    return (size * elapsed)**2 % values

if __name__ == "__main__":
    import random
    seed = process_image()
    print(seed)
    random.seed(seed)

    for num in range(5):
        print(random.random())