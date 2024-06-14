import numpy as np
from scipy.integrate import odeint
import matplotlib.pyplot as plt

# Parametry modelu
alpha = 1.0
beta = 0.1
delta = 0.075
gamma = 1.5

# Funkce pro systém diferenciálních rovnic
def model(y, t):
    x, y = y
    dxdt = alpha * x - beta * x * y
    dydt = delta * x * y - gamma * y
    return [dxdt, dydt]

# Počáteční podmínky
x0 = 40
y0 = 9
y0 = [x0, y0]

# Časový interval
t = np.linspace(0, 20, 1000)

# Řešení diferenciálních rovnic
y = odeint(model, y0, t)

# Vykreslení výsledků
plt.plot(t, y[:,0], 'r-', label='Kořist (x)')
plt.plot(t, y[:,1], 'b-', label='Predátoři (y)')
plt.xlabel('Čas')
plt.ylabel('Populace')
plt.title('Lotka-Volterra model')
plt.legend()
plt.grid()
plt.show()
