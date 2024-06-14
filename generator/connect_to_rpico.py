import serial

port = "/dev/cu.usbmodem2301"
baudrate = 115200 # defaultní baudrate pro raspberry pi pico
serial_connection = serial.Serial(port, baudrate)

seeds = open("/Users/denisvejrazka/Projects/seminka_desktop.txt", "wb")

while True:
    data = serial_connection.read(128)
    if data == b"EOF":
        break
    print(data)
    seeds.write(data)

seeds.close()
serial_connection.close()