%%
s= ([v_bins p_bins t_bins])';
pwm = action - 2727.0447;
action_1 = pwm + 25;
action_2 = pwm + 50;
action_3 = pwm - 25;
action_4 = pwm - 50;
actions = [action_1 action_2 action_3 action_4];
time_horizon = 10,000; 
state_size= perm(length(v_bins,p_bins,t_bins));
action_size = length(action); 
Q=random(state_size, action_size);
s = sample_state();
for i=1:1000
    for j=1:(time_horizon) %actual time for the training to happen 
        a=get_actions(Q,s)
        s' = [x,y,~];
        r= get_reward;
        Q= bellmans;
        s= s';
    end
end
%%
function q_new = Bellman(s, s_previous, actions, discount_factor, learning_rate)
idx = s_previous;
idx_prime = s;
Max = max(Q(idx,:));
q_old = q(idx,actions);
%q_prime = q(idx_prime,action);
q_new = q_old + learning_rate * (get_reward(s,s_previous, actions) + discount_factor + Max - q_old);  
%q_old = q_new; %set state we just caclulated as old state for q table to re run
end

%%
function reward = get_reward(s,a,is_done)
if is_done == true % taking the condition from the is_done function to determine if the agent is at the terminal state. 
    r=10;   %Agent is at the desired value. 
else 
    r=-1;    %Agent is not at the desired value
end
end

%%
% This section will create the simualtion or the environment in which the agent will run through
% We will use a general trasnfer fucntion that describes environment of the ball and pipe system
sys = zpk([],[0 -7.9239],5.05); % The final transfer function is G(s)= 5.05/(s(s+7.9239).
s_s = ss(sys); % calculating the state space for the lsim function. 
a = actions - 2730; %pwm values must refelect the actual values being inserted 
 % ss comand above gives A,B,C,D values that will be used in the lsim fucntion 
 %particularly to calculate x 
y = s_s.C+s_s.D; 
[x,y,~] = lsim(s_s,a,t,x);

%%  
%This fucntion will determine what acito tnhe agent will take in relation to what state it is
%in and the distance from the terminal state
function random_action = get_action(Q,s)% takes in arguments from the Q table and the state
idx=index_function(s);%grabs the index in relation to what state is in in per the indexing fucntion
action=actions(max(Q(idx))); %action is then determined by aquiring the maximimum q-value from the q-table 
e = 0.1; 
% This loop will allow the agent to explore by first creating a random list of number between
% 0 and 1. if e is less then one of the random number of the array, then the agent will take a random action 
% and will overwrite the action determined above. 
 if e < random(0,1)
     action= random(actions);
 end 
end 

%%
function is_done = check_is_done(v_next,p_next,t_next)
if p_next==t_next && v_next==0  % if the next position = target position and the velocity is 0 since we are at the desired position
    is_done = true;             % isdone function to make the learning stop and reach the terminal state.
else
    is_done = false;            % if the next position is different from target position and the velocity is not 0, the ball is not at final terminal state. 
end 

end 
%% index_function
function index_fucntion = index(v_index,p_index,t_index)  % Get the index of of each states so that it can get access to the Q table.
    index = p_index + length(p_bins)*(v_index-1)+length(p_bins)*length(v_bins)*(t_index-1); % This index value will return the state of the q-table corresponding to the action that the agent should take. 
end                                                                                         % The values of v_pins, t_bins, and p_bins are the index from the q-table. 

%% 
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
%%
%This is the fist step to this algorthim where the continous states 
%from the read file 
function [binned_state,bin_indx] = binning(cont_state)
p = d * (10e-3); % this will convert the mm reading in to a m reading for distance
v = (p'-p)./sample_rate; %How would we save two different time stamps and positions
target = .317;
cont_state = [v t p]; 
v_bins = [-5 -1 0 1 5]; % open-ended
t_bins = [.300];
p_bins = [.130 .230 .320 .410 .470 .555 .640 .710 .800 .950]; 
v_cont = cont_state(1); 
t_cont = cont_state(2); 
p_cont = cont_state(3); 

dist_v = abs(v_bins - v_cont(1));
dist_t = abs(t_bins - v_cont(2));
dist_p = abs(p_bins - v_cont(3));
[binned_v,v_idx] = min(dist_v);
[binned_t,t_idx] = min(dist_t);
[binned_p,p_idx] = min(dist_p);

binned_state = cat(2,binned_v,binned_t,binned_t);
bin_idx = cat(2,v_idx,t_idx,p_idx);
end
