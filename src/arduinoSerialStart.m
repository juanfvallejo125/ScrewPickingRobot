function s = arduinoSerialStart()
s = serial("/dev/ttyACM1", 'Baudrate', 9600);
fopen(s);
end