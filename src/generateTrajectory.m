function [t, q, q_dot, q_dotdot] = generateTrajectory(desiredxy, avgspeed, dt, profileType)%Avg speed in rpm
q1_curr = dxl_CurrentPos(1);
q2_curr = dxl_CurrentPos(2);
q_curr = [q1_curr;q2_curr];
%distance = sqrt((desiredxy(1)-currentxy(1))^2+(desiredxy(2)-currentxy(2))^2);%Get distance
elbowdown = 1;
avgspeed = avgspeed*360/60;
qdesired = RRRDA(desiredxy, elbowdown)';%Get the desired q from xy
if(strcmp(profileType,'Trapezoidal'))
    tf = max(abs((qdesired-q_curr)/avgspeed));%Get desired time to get there
    qdesired = RRRDA(desiredxy, elbowdown)';%Get the deired q from xy
    cruisingSpeed = ((qdesired-q_curr)./tf)*1.5;%in deg/s
    tc = abs((q_curr-qdesired+cruisingSpeed.*tf)./cruisingSpeed);%Time when velocity slope becomes 0
    if(all(tc>dt))
        acceleration = cruisingSpeed.^2./(q_curr-qdesired+cruisingSpeed.*tf);% in deg/s^2 from book formula
        t11 = 0:dt:tc(1);
        t12 = 0:dt:tc(2);
        t1 = [t11;t12];%Time for acceleration
        t21 = tc(1)+dt:dt:tf-tc(1);
        t22 = tc(2)+dt:dt:tf-tc(2);
        t2 = [t21;t22];%Time for constant velocity
        t31 = [tf-tc(1)+dt:dt:tf, tf];
        t32 = [tf-tc(2)+dt:dt:tf, tf];
        t3 = [t31;t32];% Time for deceleration
        traj1 = zeros(2,length(t1));
        traj2 = zeros(2,length(t2));
        traj3 = zeros(2,length(t3));
        vel1 = zeros(2,length(t1));
        vel2 = zeros(2,length(t2));
        vel3 = zeros(2,length(t3));
        acc1 = zeros(2,length(t1));
        acc2 = zeros(2,length(t2));
        acc3 = zeros(2,length(t3));
        for i = 1:length(t1)%Calculate acceleration, velocity and displacement for first section
            traj1(:,i) = q_curr+0.5*acceleration.*(t1(:,i).^2);
            vel1(:,i) = acceleration.*t1(:,i);
            acc1(:,i) = acceleration;
        end
        for i = 1:length(t2)%Calculate acceleration, velocity and displacement for second section
            traj2(:,i) = q_curr+acceleration.*tc.*(t2(:,i)-tc/2);
            vel2(:,i) = acceleration.*tc;
            acc2(:,i) = zeros(2,1);
        end
        for i = 1:length(t3)%Calculate acceleration, velocity and displacement for third section
            traj3(:,i) = qdesired-0.5.*acceleration.*(tf-t3(:,i)).^2;
            vel3(:,i) = acceleration.*(tf-t3(:,i));
            acc3(:,i) = -acceleration;
        end

        t = [t1,t2,t3];
        q = [traj1,traj2,traj3];%degrees
        q_dot = [vel1,vel2,vel3].*60./360;%converted to rpm
        q_dotdot = [acc1, acc2, acc3];
        % plot(t(1,:),q(1,:),t(1,:),q_dot(1,:),t(1,:),q_dotdot(1,:));
        % figure(2)
        % plot(t(2,:),q(2,:),t(2,:),q_dot(2,:),t(2,:),q_dotdot(2,:));
        fprintf('Trap\n')
    else
        profileType = 'Linear';
        avgspeed = 15;
    end
end
if(strcmp(profileType,'Linear'))
    fprintf('Linear\n')
    q = qdesired;
    q_dot = [avgspeed;avgspeed];
    q_dotdot = [0;0];
    t=0;
end
end