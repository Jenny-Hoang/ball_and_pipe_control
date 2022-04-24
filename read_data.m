function [distance,pwm,target,deadpan] = read_data(device)
%% Reads data sent back from Ball and Pipe system
% Inputs:
%  ~ device: serialport object controlling the real world system
% Outputs:
%  ~ distance: the IR reading from the time of flight sensor
%  ~ pwm: the PWM from the manual knob of the system (NOT THE SAME AS THE
%  PWM YOU MAY SET THROUGH SERIAL COMMUNICATION)
%  ~ target: the desired height of the ball set by the manual knob of the
%  system
%  ~ deadpan: the time delay after an action set by the manual knob of the
%  system
%
% Created by:  Kyle Naddeo 1/3/2022
% Modified by: Antonio Silva

%% Ask nicely for data
write(device,"s","string");%send "s" to device which causes device to produce a set of values from ball and pipe system 
%% Read data
data = read(device,20,"string"); %read 20 string values from device and call it data, device only sends 20 string values before it repeats
%% Translate
%extract and convert to double for each specific data type
%different data is seperated by special characters
distance   = str2double(extractBetween(data,2,5)); %4 values to distance
pwm        = str2double(extractBetween(data,7,10)); %4 values for pwm
target     = str2double(extractBetween(data,12,15)); %4 values for target value
deadpan    = str2double(extractBetween(data,17,20)); %4 values for deadpan value

end
