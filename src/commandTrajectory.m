function commandTrajectory(q,q_dot,q_dotdot,dt)
DXL_IDS = [1,2];
q_measured = zeros(2,size(q,2));
r = robotics.Rate(1/dt);
reset(r)
for i = 1:size(q,2)
            dxl_SetVel(DXL_IDS, q_dot(:,i));
            %fprintf('velocity %d\n', q_dot(c,i))
            dxl_SetAcc(DXL_IDS, q_dotdot(:,i));
            dxl_SetPos(DXL_IDS, q(:,i));
            %q_measured(c, i) = dxl_CurrentPos(c);
        waitfor(r);%Loop at given frequency
end
% t = dt.*(1:length(q));
% plot(t,q_measured(1,:), t, q_measured(2,:))
% hold on
% plot(t, q(1,:), t, q(2,:))
% legend('Measured', 'Measured', 'Commanded', 'Commanded')

end