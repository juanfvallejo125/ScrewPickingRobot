function goToPos(xy, vel, inputType,profileType)
if ~exist('profileType', 'var')
   profileType = 'Linear'; 
end

if ~exist('inputType', 'var')
   inputType = 'xy'; 
end

dxl_updatePID(1, 35,5,5);
dxl_updatePID(2, 35,5,5);%dxl_updatePID(2, 5,2,1);
dt = 0.02;
dxl_TorqueEnable(1);
dxl_TorqueEnable(2);

if strcmp(inputType, 'xy')
    [t, q, q_dot, q_dotdot] = generateTrajectory(xy,vel,dt,profileType);
    commandTrajectory(q,q_dot,q_dotdot,dt);
elseif strcmp(inputType, 'q')
    q_dot = [vel;vel];
    q_dotdot = [0;0];
    q = xy';
    commandTrajectory(q,q_dot,q_dotdot,dt);
end
% dxl_updatePID(1, 15,5,5);
% dxl_updatePID(2, 15,5,5);


end