function waitToComplete(threshold)
completed = 0;
q = zeros(1,3);
q_goal = zeros(1,3);
while(~completed)
    for i = 1:3
        q(i) = dxl_CurrentPos(i);
        q_goal(i) = dxl_getGoalPosition(i);
    end
    error = q_goal - q;
    completed = all(abs(error)<=threshold);
end
end