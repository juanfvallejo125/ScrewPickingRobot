function result = RRFDA(displ)

%function that takes in joint angles and give out end effector
%positions
angleLimits1 = [42.81, 316.92]-180;
angleLimits2 = [45.01, 316.84]-190;
%%Add the horizontal offset of the last link
L1 = 195.75e-3;%Ruler
L2 = 248e-3;%Temporal
L3 = 13e-3;%
th3 = -pi/2;%
L3p = [1,1]; %non-vertical offset from adapter piece ** vertical offset should be 
            % included in rack actuation later on!!!

th1 = displ(1).*(pi/180); %theta one value
th2 = displ(2).*(pi/180); %theta two value
phi = th1 + th2; %sum of joint angles at every ste
xe0 = L1*cos(th1) + L2*cos(th1+th2) + L3*cos(th1+th2+th3); %FDA to find EE x coord
ye0 = L1*sin(th1) + L2*sin(th1+th2) + L3*sin(th1+th2+th3); %FDA to find EE y coord

xe = xe0;
ye = ye0;
result = [xe; ye];
%reassign values to struct array ??

end