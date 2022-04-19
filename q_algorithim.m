%%
s= [v_bins p_bins t_bins]
action=[0 1000 4000]
state_size= perm(length(v_bins),....)
Q=random(state_size, action_size)
s=sample_state()
for i=1:1000
    for j=1:(time horizontal)
        a=get_action(Q,s)
        s_previous= simulate or realworld
        r= get_reward
        Q=bellmans
        s= s_previous
    end
end


%% Graphing leanring overtime
lsim(ss(s'),a,time,x)
a = ;

%% Bell 
q_new = q_old + a + discount * (get_reward + discount_factor + max_reward - q_old);  


%%
function reward=get_reward(s,s_previous, a)
terminal_state=.......;
if (s,a) == terminal_state
    r=10; %agent at the desired value
else (s,a) ~= terminal_state
    r=-1; 
end
end



%% 
function random_action=get_action(Q,s)
index=index_function(s);
action=actions(argmax(Q(indx,)));
% if e < random(0,1);
%     action= random(actions);
% end 
end    

%% weqwe
function index_fucntion = s(v,p,t)
indx = where(v==-1,p==0,t==0);
end

%% qwe
%Function sample_state grabs the sample of each vector passed in and find
%the state and concatenate three vectors, into one vector which is one a
%sample of the state that the agent is in.
function sample_state(v_bins, p_bins, t_bins) 
   
    %Grabs the random element in the array for each vector (vector =
    %sample) and assigned them to each variable.
    V_Sample = rand(v_bins); 
    P_Sample = rand(p_bins);
    T_Sample = rand(t_bins);

    Sample = cat(2, V_Sample,P_Sample,T_Sample); %cat function conccatenate 
    % the three vectors along dimension "dim" which is either 1 or 2. 1
    % concatenates vertically while 2 concatenates horizontally.
end
%% qwe 
function binned_state = binning(cont_state)
v_bins = [-5 -1 0 1 5]; % open-ended
t_bins = [0 1];
p_bins = [0 1 2 3 4 5 6]; %not yet decided
v_cont = cont_state(1); 
t_cont = cont_state(1); 
p_cont = cont_state(1); 
binned_v = v_bins(argmin(abs(v_bins - v_cont)));
binned_t = v_bins(argmin(abs(t_bins - v_cont)));
binned_p = v_bins(argmin(abs(p_bins - v_cont)));
binned_state = concat(binned_v,binned_t,binned_t);
end
