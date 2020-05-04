function dxl_goal_position = dxl_getGoalPosition(DXL_ID)
global PROTOCOL_VERSION ADDR_MX_GOAL_POSITION port_num COMM_SUCCESS
% Read goal position
dxl_goal_position = read2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID, ADDR_MX_GOAL_POSITION);
dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
if dxl_comm_result ~= COMM_SUCCESS
   fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
elseif dxl_error ~= 0
   fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
end
dxl_goal_position = dxl_goal_position*0.088-180;
end