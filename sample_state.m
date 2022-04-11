%Function sample_state grabs the sample of each vector passed in and find
%the state and concatenate three vectors, into one vector which is one a
%sample of the state that the agent is in.
function sample_state(v_bins, p_bins, t_bins) 
   
    %Round the element passed in the paramter, to 
    % the nearest integer. Make sure any elements passed in are rounded to
    % whole numbers.
    V_Sample = round(v_bins); 
    P_Sample = round(p_bins);
    T_Sample = round(t_bins);

    Sample = cat(2, V_Sample,P_Sample,T_Sample); %cat function conccatenate 
    % the three vectors along dimension "dim" which is either 1 or 2. 1
    % concatenates vertically while 2 concatenates horizontally.
end