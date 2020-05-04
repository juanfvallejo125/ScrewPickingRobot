%% Denavit-Hartenberg data for RRR Serial Robot
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% -This structure contains the DH parameters for the RRR robot. 
% -Unless otherwise noted, values are logically indexed from frame 0 (base)
%  to frame n+1 (gripper).
%--------------------------------------------------------------------------

dh.t = [nan,     0,     0,     0,     0];  %joint angles (first element ignored)
dh.d = [nan,     0,     0,     0,     0];  %joint offsets (first element ignored)
dh.a = [  0,   9.3,   9.3,  10.2,   nan];  %link common normals (last element ignored)
dh.f = [  0,     0,     0,     0,   nan];  %link twist angles (last element ignored)
dh.j = ['B',   'R',   'R',   'R',   'G'];  %joint type R/P/G/B/N - Revolute/Prismatic/Gripper/Base/None
