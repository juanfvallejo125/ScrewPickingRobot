function dxl_start()
global DEVICENAME lib_name BAUDRATE port_num group_num_position ...
       group_num_velocity group_num_acceleration ADDR_MX_GOAL_POSITION ...
       PROTOCOL_VERSION LENGTH_MX_GOAL_POSITION ADDR_MX_MOVING_SPEED ...
       LENGTH_MX_MOVING_SPEED ADDR_MX_GOAL_ACCELERATION LENGTH_MX_GOAL_ACCELERATION
% Initialize PortHandler Structs
% Set the port path
% Get methods and members of PortHandlerLinux or PortHandlerWindows
port_num = portHandler(DEVICENAME);

% Initialize PacketHandler Structs
packetHandler();

% Open port
if (openPort(port_num))
    fprintf('Succeeded to open the port!\n');
else
    unloadlibrary(lib_name);
    fprintf('Failed to open the port!\n');
    input('Press any key to terminate...\n');
    return;
end

% Set port baudrate
if (setBaudRate(port_num, BAUDRATE))
    fprintf('Succeeded to change the baudrate!\n');
else
    unloadlibrary(lib_name);
    fprintf('Failed to change the baudrate!\n');
    input('Press any key to terminate...\n');
    return;
end

group_num_position = groupSyncWrite(port_num, PROTOCOL_VERSION, ADDR_MX_GOAL_POSITION, LENGTH_MX_GOAL_POSITION);
group_num_velocity = groupSyncWrite(port_num, PROTOCOL_VERSION, ADDR_MX_MOVING_SPEED, LENGTH_MX_MOVING_SPEED);
group_num_acceleration = groupSyncWrite(port_num, PROTOCOL_VERSION, ADDR_MX_GOAL_ACCELERATION, LENGTH_MX_GOAL_ACCELERATION);
end