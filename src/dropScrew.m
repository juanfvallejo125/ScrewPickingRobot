function dropScrew(s)
dxl_SetVel(3, 50);
dxl_SetPos(3, 0);
waitToComplete(0.5);
arduinoSendOff(s)
pause(1)
dxl_SetPos(3, 100);
end