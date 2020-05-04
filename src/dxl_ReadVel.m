function VELOCITY = dxl_ReadVel(DXL_ID)
global ADDR_MX_MOVING_SPEED port_num PROTOCOL_VERSION COMM_SUCCESS
%Velocity in rpm

VELOCITY = read2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID, ADDR_MX_MOVING_SPEED);
dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
if dxl_comm_result ~= COMM_SUCCESS
    fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
elseif dxl_error ~= 0
    fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
end
%fprintf('Velocity: %d rpm',VELOCITY*0.114);
end