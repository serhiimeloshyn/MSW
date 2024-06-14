import numpy as np

def randomize():
    with open("/Users/denisvejrazka/Projects/MSW/generator/seminka_desktop.txt", "r") as file:
        seed_str = file.readline()

    nums = list(filter(lambda znak: znak.isdigit(), seed_str))
    nums_str = ''.join(nums)  # Spojuje všechny čísla do jednoho řetězce
    nums_int = int(nums_str) % (2**32 - 1)  # Upravit semínko, pokud překračuje maximální hodnotu


    np.random.seed(nums_int)
    random_list = np.random.rand(7)
    print(random_list)

randomize()
