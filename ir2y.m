function [y, pipe_percentage] = ir2y(ir)
%% Converts IR reading from the top to the distance in meters from the bottom
% Inputs:
%  ~ ir: the IR reading from time of flight sensor
% Outputs:
%  ~ y: the distance in [m] from the bottom to the ball
%  ~ pipe_percentage: on a scale of 0 (bottom of pipe) to 1 (top of pipe)
%  where is the ball
%
% Created by:  Kyle Naddeo 2/2/2022
% Modified by: YOUR NAME and DATE

%% Parameters
ir_bottom = 0.96; % IR reading when ball is at bottom of pipe
ir_top    =  0.055; % "                        " top of pipe
y_top     = 0.9144; % Ball at top of the pipe [m]

%% Bound the IR reading and send error message 
% (remeber the IR values are inverted ie small values == large height and large values == small height)
if (ir >= ir_bottom)
    ir = ir_bottom;
if (ir <= ir_top)
    ir = ir_top;
end
%% Set
<<<<<<< HEAD
% pipe_percentage =  
% y = 
% this file has been edited
=======
pipe_percentage =  1 - ((ir-ir_top)/(ir_bottom-ir_top));   %ir=0.351
y = pipe_percentage*y_top;
>>>>>>> f3d16c2b8bc13d6f637c04c50a5def227431e08f
