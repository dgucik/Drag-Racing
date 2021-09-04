import serial

serialPortP1 = serial.Serial(port='COM6', baudrate = 19200, timeout=0)
#serialPortP2 = serial.Serial(port='COM6', baudrate = 19200, timeout=0)

playersData = [bytes(1), bytes(1)]

def init_data_transfer():
    serialPortP1.write(b'\x00')
    playersData[0] = serialPortP1.read(1)
    #serialPortP2.write(playersData[0])
    #playersData[1] = serialPortP2.read(1)
    print("Start_game")

init_data_transfer()

while True:
    serialPortP1.write(playersData[0])
    playersData[0] = serialPortP1.read(1)
    #serialPortP2.write(playersData[0])
    #playersData[1] = serialPortP2.read(1)
    print(playersData[0],playersData[1])


