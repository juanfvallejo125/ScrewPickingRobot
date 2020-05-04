function q = RRRDA(xy, elbowdown)%Returns in degrees
angleLimits1 = ([42.81, 316.92]-180).*(pi/180);
angleLimits2 = ([45.01, 316.84]-180).*(pi/180);
L1 = 195.75e-3;%Ruler
L2 = 248e-3;%Temporal
L3 = 13e-3;%
L2prime = sqrt(L2^2+L3^2);
phi_offset = atan(L3/L2);

distance = sqrt(xy(1)^2+xy(2)^2);
alpha = atan2(xy(2), xy(1));
phi1 = acos((L1^2+distance^2-L2prime^2)/(2*L1*distance));
phi2 = acos((L1^2+L2prime^2-distance^2)/(2*L1*L2prime));
if(~isreal(phi1))
    phi1 = real(phi1);
end
if(~isreal(phi2))
    phi2 = real(phi2);
end
q1down = alpha - phi1;
q2down = pi - phi2;
q1up = alpha + phi1;
q2up = phi2 - pi;

%Handle the offset
q2up = q2up + phi_offset;
q2down = q2down + phi_offset;

elbowdown_possible = (q1down > angleLimits1(1) && q1down < angleLimits1(2))...
            && (q2down > angleLimits2(1) && q2down < angleLimits2(2));
elbowup_possible = (q1up > angleLimits1(1) && q1up < angleLimits1(2))...
            && (q2up > angleLimits2(1) && q2up < angleLimits2(2));
if elbowdown
    if(elbowdown_possible)
        q = [q1down, q2down].*180./pi;
        return
    elseif(elbowup_possible)
        q = [q1up, q2up].*180./pi;
        return
    else
        q = NaN;
        fprintf('Violates joint limits')
        return
    end
else
    if(elbowup_possible)
        q = [q1up, q2up].*180./pi;
        return
    elseif(elbowdown_possible)
        q = [q1down, q2down].*180./pi;
        return
    else
        q = NaN;
        fprintf('Violates joint limits')
        return
    end
end
end