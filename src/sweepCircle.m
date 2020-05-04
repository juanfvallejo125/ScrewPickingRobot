function sweepCircle(r)
    t = 0:0.2:2*pi;
    x = r*cos(t);
    y = r*sin(t);
    q1_current = dxl_CurrentPos(1);
    q2_current = dxl_CurrentPos(2);
    xy = RRFDA([q1_current q2_current]);
    vel = 15;
    for i = 1:length(t)
       goToPos([xy(1)+x(i), xy(2)+y(i)], vel, 'xy', 'Linear')
       waitToComplete(0.5)
    end
end