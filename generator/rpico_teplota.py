# kod byl vyvijen v jinem editoru

from machine import ADC, Pin
import time
import hashlib
import uos


uart = machine.UART(0, baudrate=11520)
uart.init(115200, bits=8,parity=None, stop=1, tx=Pin(0), rx=Pin(1))
uos.dupterm(uart)
adc = ADC(4) 

# Čtení hodnoty napětí z ADC a převod na teplotu v °C
ADC_voltage = adc.read_u16() * (3.3 / 65536)
temperature_celcius = 27 - (ADC_voltage - 0.706)/0.001721

# Převod teploty na řetězec a výpočet hash
temperature_str = str(temperature_celcius)
seed = hashlib.sha256(temperature_str.encode()).digest()
i = 0

while True:
    print(seed)
    time.sleep(10)