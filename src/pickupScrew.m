function pickupScrew(s)
dxl_SetVel(3, 50);
dxl_SetPos(3, -50);
arduinoSendOn(s)
waitToComplete(0.5)
pause(1)
%sweepCircle(0.01)
%wait for completion need to write that
waitToComplete(0.5)
dxl_SetPos(3, 100);
end