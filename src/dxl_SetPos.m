function dxl_SetPos(DXL_ID, POS)
global PROTOCOL_VERSION ADDR_MX_GOAL_POSITION port_num COMM_SUCCESS group_num_position ...
       LENGTH_MX_GOAL_POSITION 

%Convert to register scale
POS = POS + 180;
POS = round(POS/0.088);
if(length(DXL_ID) ==1)
    % Write goal position
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID, ADDR_MX_GOAL_POSITION, POS);
    dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
    dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    elseif dxl_error ~= 0
        fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
    end
elseif(length(DXL_ID) >1)
    for i = 1:length(DXL_ID)
        dxl_addparam_result = groupSyncWriteAddParam(group_num_position, DXL_ID(i), POS(i), LENGTH_MX_GOAL_POSITION);
        if dxl_addparam_result ~= true
            fprintf('[ID:%03d] groupSyncWrite addparam failed', DXL_ID);
        end
    end
        groupSyncWriteTxPacket(group_num_position);
    if getLastTxRxResult(port_num, PROTOCOL_VERSION) ~= COMM_SUCCESS
        printTxRxResult(PROTOCOL_VERSION, getLastTxRxResult(port_num, PROTOCOL_VERSION));
    end

    % Clear syncwrite parameter storage
    groupSyncWriteClearParam(group_num_position);
    end
end