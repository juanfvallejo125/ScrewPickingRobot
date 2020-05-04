function dxl_SetVel(DXL_ID, VELOCITY)
global ADDR_MX_MOVING_SPEED port_num PROTOCOL_VERSION COMM_SUCCESS ...
       LENGTH_MX_MOVING_SPEED group_num_velocity
%Velocity in rpm
VELOCITY = round(abs(VELOCITY/0.114));

if(length(DXL_ID) == 1)%Single Write
    %fprintf('Velocity commanded %d\n', VELOCITY)
    if VELOCITY <=30
        VELOCITY = 30;
    end
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID, ADDR_MX_MOVING_SPEED, VELOCITY);
    dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
    dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    elseif dxl_error ~= 0
        fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
    end
elseif(length(DXL_ID) >1)
    if any(VELOCITY <=30)
        VELOCITY(VELOCITY<=30) = 30;
    end
    for i = 1:length(DXL_ID)
        dxl_addparam_result = groupSyncWriteAddParam(group_num_velocity, DXL_ID(i), VELOCITY(i), LENGTH_MX_MOVING_SPEED);
        if dxl_addparam_result ~= true
            fprintf('[ID:%03d] groupSyncWrite addparam failed', DXL1_ID);
        end
    end
        groupSyncWriteTxPacket(group_num_velocity);
    if getLastTxRxResult(port_num, PROTOCOL_VERSION) ~= COMM_SUCCESS
        printTxRxResult(PROTOCOL_VERSION, getLastTxRxResult(port_num, PROTOCOL_VERSION));
    end

    % Clear syncwrite parameter storage
    groupSyncWriteClearParam(group_num_velocity);
    
    end
end
