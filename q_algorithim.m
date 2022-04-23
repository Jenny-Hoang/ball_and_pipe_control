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
if is_done == true
    r=10; %Agent is at the desired value. 
else 
    r=-1; %Agent is not at the desired value
end
end
%%
sys = zpk([],[0 -7.9239],5.05);
s_s = ss(sys); 
% a = actions - 2730; 
y = s_s.C+s_s.D;
x = (1./s_s.C).*(y - s_s.D);
[x,y,~] = lsim(s_s,a,t,x);
%%  action 
function random_action = get_action(Q,s)
idx=index_function(s);
action=actions(max(Q(idx)));
e = 0.1; 
 if e < random(0,1)
     action= random(actions);
 end 
end 

%% index_function
function index_fucntion = index(v_index,p_index,t_index)  % Get the index of of each states so that it can get access to the Q table.
    index = p_index + length(p_bins)*(v_index-1)+length(p_bins)*length(v_bins)*(t_index-1);
end 
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
p = d * (10e-3); 
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