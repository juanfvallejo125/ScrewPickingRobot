clc;
clear all;
%%
global ADDR_MX_TORQUE_ENABLE ADDR_MX_GOAL_POSITION ADDR_MX_PRESENT_POSITION PROTOCOL_VERSION...
       BAUDRATE DEVICENAME TORQUE_ENABLE TORQUE_DISABLE DXL_MINIMUM_POSITION_VALUE DXL_MAXIMUM_POSITION_VALUE ...
       DXL_MOVING_STATUS_THRESHOLD COMM_SUCCESS COMM_TX_FAIL lib_name ADDR_MX_MOVING_SPEED...
       ADDR_MX_P_GAIN ADDR_MX_D_GAIN ADDR_MX_I_GAIN ADDR_MX_GOAL_ACCELERATION LENGTH_MX_GOAL_POSITION ...
       LENGTH_MX_GOAL_ACCELERATION LENGTH_MX_MOVING_SPEED 
%%
lib_name = '';

if strcmp(computer, 'PCWIN')
  lib_name = 'dxl_x86_c';
elseif strcmp(computer, 'PCWIN64')
  lib_name = 'dxl_x64_c';
elseif strcmp(computer, 'GLNX86')
  lib_name = 'libdxl_x86_c';
elseif strcmp(computer, 'GLNXA64')
  lib_name = 'libdxl_x64_c';
elseif strcmp(computer, 'MACI64')
  lib_name = 'libdxl_mac_c';
end

% Load Libraries
if ~libisloaded(lib_name)
    [notfound, warnings] = loadlibrary(lib_name, 'dynamixel_sdk.h', 'addheader', 'port_handler.h', 'addheader', 'packet_handler.h', 'addheader','group_sync_write.h');
end
   
%% Control table address
ADDR_MX_TORQUE_ENABLE       = 24;           % Control table address is different in Dynamixel model
ADDR_MX_GOAL_POSITION       = 30;
ADDR_MX_PRESENT_POSITION    = 36;
ADDR_MX_MOVING_SPEED        = 32;
ADDR_MX_D_GAIN              = 26;
ADDR_MX_I_GAIN              = 27;
ADDR_MX_P_GAIN              = 28;
ADDR_MX_GOAL_ACCELERATION   = 73;

%% Register Lengths
LENGTH_MX_GOAL_POSITION     = 2;
LENGTH_MX_GOAL_ACCELERATION = 1;
LENGTH_MX_MOVING_SPEED      = 2;
%% 
% Protocol version
PROTOCOL_VERSION            = 1.0;          % See which protocol version is used in the Dynamixel

% Default setting
DXL_ID                      = 1;            % Dynamixel ID: 1
BAUDRATE                    = 1000000;
DEVICENAME                  = '/dev/ttyUSB0';       % Check which port is being used on your controller
                                            % ex) Windows: 'COM1'   Linux: '/dev/ttyUSB0' Mac: '/dev/tty.usbserial-*'

TORQUE_ENABLE               = 1;            % Value for enabling the torque
TORQUE_DISABLE              = 0;            % Value for disabling the torque
DXL_MINIMUM_POSITION_VALUE  = 100;          % Dynamixel will rotate between this value
DXL_MAXIMUM_POSITION_VALUE  = 4000;         % and this value (note that the Dynamixel would not move when the position value is out of movable range. Check e-manual about the range of the Dynamixel you use.)
DXL_MOVING_STATUS_THRESHOLD = 10;           % Dynamixel moving status threshold

ESC_CHARACTER               = 'e';          % Key for escaping loop

COMM_SUCCESS                = 0;            % Communication Success result value
COMM_TX_FAIL                = -1001;        % Communication Tx Failed


%% Functions





