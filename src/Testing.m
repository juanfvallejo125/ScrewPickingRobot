%% Testing
%Dynamixel_Functions
%dxl_start
DXL_IDS = [1,2];
q = [0,0];

dxl_TorqueDisable(1)
dxl_TorqueDisable(2)
plot(0,0)
Q_acum = []
x = [];
y = [];

for i = 1:100
    for id = DXL_IDS
        q(id) = dxl_CurrentPos(id);
    end
    Q_acum = [Q_acum;q];
    xy = RRFDA(q);
    fprintf('Current position x: %d y: %d\n', xy(1), xy(2))
    pause(0.1)
    x = [x, xy(1)];
    y = [y, xy(2)];
    plot(x,y, 'r')
end
  
% dxl_TorqueEnable(1)
% dxl_TorqueEnable(2)
% dxl_SetVel(1,20)
% dxl_SetVel(2,20)
% dxl_ReadVel(1);
% dxl_ReadVel(2);
% for i = 1:50
%     for id = DXL_IDS
%         dxl_SetPos(id, Q_acum(i, id))
%     end
%     pause(0.5)
% end
% dxl_stop
%%

dxl_updatePID(1, 5,2,1);
dxl_updatePID(2, 5,2,1);

x = 0;
y = 0.3;
vel = 180;%deg/s
dt = 0.02;
dxl_TorqueEnable(1);
dxl_TorqueEnable(2);
[t, q, q_dot, q_dotdot] = generateTrajectory([x y],vel, dt);
commandTrajectory(q,q_dot,q_dotdot,dt);
pause(1)
dxl_updatePID(1, 15,5,5);
dxl_updatePID(2, 15,5,5);
%%
x = 0.1;
y = -0.25;
vel = 0.5;
dt = 0.02;
dxl_TorqueEnable(1);
dxl_TorqueEnable(2);
[t, q, q_dot, q_dotdot] = generateTrajectory([x y],vel, dt);
commandTrajectory(q, q_dot, q_dotdot, dt)
%%
pause(4)
command = [0.3,0];
goToPos(command, 15, 'xy', 'Trapezoidal')
waitToComplete(0.5)
command = [-0.3,0];
goToPos(command, 15, 'xy', 'Trapezoidal')
waitToComplete(0.5)
goHome()