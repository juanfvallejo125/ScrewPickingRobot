function dxl_SetAcc(DXL_ID, ACCELERATION)
global ADDR_MX_GOAL_ACCELERATION port_num PROTOCOL_VERSION COMM_SUCCESS ...
       group_num_acceleration LENGTH_MX_GOAL_ACCELERATION
%Velocity in deg/s^2
ACCELERATION = round(abs(ACCELERATION/8.583));
if(length(DXL_ID) == 1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID, ADDR_MX_GOAL_ACCELERATION, ACCELERATION);
    dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
    dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    elseif dxl_error ~= 0
        fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
    end
elseif(length(DXL_ID) >1)
    for i = 1:length(DXL_ID)
        dxl_addparam_result = groupSyncWriteAddParam(group_num_acceleration, DXL_ID(i), ACCELERATION(i), LENGTH_MX_GOAL_ACCELERATION);
        if dxl_addparam_result ~= true
            fprintf('[ID:%03d] groupSyncWrite addparam failed', DXL1_ID);
        end
    end
        groupSyncWriteTxPacket(group_num_acceleration);
    if getLastTxRxResult(port_num, PROTOCOL_VERSION) ~= COMM_SUCCESS
        printTxRxResult(PROTOCOL_VERSION, getLastTxRxResult(port_num, PROTOCOL_VERSION));
    end

    % Clear syncwrite parameter storage
    groupSyncWriteClearParam(group_num_acceleration);
end
end