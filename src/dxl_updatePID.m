function dxl_updatePID(DXL_ID, P, I, D)
global PROTOCOL_VERSION ADDR_MX_TORQUE_ENABLE TORQUE_ENABLE port_num COMM_SUCCESS ADDR_MX_P_GAIN ...
        ADDR_MX_D_GAIN ADDR_MX_I_GAIN

%Update PID
%P
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID, ADDR_MX_P_GAIN, P);
dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
if dxl_comm_result ~= COMM_SUCCESS
    fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
elseif dxl_error ~= 0
    fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
else
    %fprintf('Updated P gain to %d\n', P);
end
%D
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID, ADDR_MX_D_GAIN, D);
dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
if dxl_comm_result ~= COMM_SUCCESS
    fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
elseif dxl_error ~= 0
    fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
else
    %fprintf('Updated D gain to %d\n', D);
end
%I
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID, ADDR_MX_I_GAIN, I);
dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
if dxl_comm_result ~= COMM_SUCCESS
    fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
elseif dxl_error ~= 0
    fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
else
    %fprintf('Updated I gain to %d\n', I);
end
end