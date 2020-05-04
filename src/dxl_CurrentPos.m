function present_position = dxl_CurrentPos(DXL_ID)
global PROTOCOL_VERSION ADDR_MX_PRESENT_POSITION port_num COMM_SUCCESS
% Read present position
dxl_present_position = read2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID, ADDR_MX_PRESENT_POSITION);
dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
if dxl_comm_result ~= COMM_SUCCESS
   fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
elseif dxl_error ~= 0
   fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
end
present_position = dxl_present_position*0.088-180;
end