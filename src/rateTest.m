r = robotics.Rate(100);
for i = 1:100
    fprintf('%d\n', i);
    waitfor(r);
end
statistics(r)