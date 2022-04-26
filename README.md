# Overview of the Ball and Pipe System
<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#overview-of-the-project">Overview of the Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#theory-of-control-method">Theory of Control Method</a>
      <ul>
        <li><a href="#q-table">Q-Table</a></li>
      </ul>
      <li>
      <a href="#guide-to-use-the-code">Guide to Use the Code</a>
      <ul>
        <li><a href="#ir2y-code">ir2y code</a></li>
        <li><a href="#read_data-code">read_data code</a></li>
        <li><a href="#real_world-code">real_world code</a></li>
        <li><a href="#set_pwm-code">set_pwm code</a></li>
      </ul>
    </li>
    <li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>


<!-- Done -->
MATLAB codes to open serial communication with a ball and pipe system. The system is made of a vertical cylinder with a ping pong ball controlled by a fan on the bottom and height measured by a time of flight sensor on top. The objective is to balance the ball at a target altitude. 

<br/>
vtp
velocity of the ball
target is height
position of the ball




# Theory of Control Method (Q-Learning)
Control Method chosen was the **Q-Learning** which is a type of reinforcement learning. The 'Q' in Q-Learning stands for quality. The goal of Q-Learning is to maximize the value of Q by using a Q-table to find the best solution which will tell us what action to take depending on the state that it is in. The q-table will update the more it is in the environment and studies its reward. The q-algorithm detailing is known as the Bellmans equation. 

<br/>
**Some important terms:** 
<br/>
<br/>
  - *Agents* - This is the entity that will explore the environment and makes decisions according to the Q-Table. In this project the Agent is the ball.
<br/>

  - *State* - This is where the location of where the object is at. In this project, the pipe is divided into 5 sections and in each section there are 2 subsections which is the state.
<br/>

  - *Action* - Depending on the state it is in, a specific action will be made.
<br/>

  - *Rewards* - Depending on the state it is in, it will lead to a positive or negative reward.
<br/>

  - *Environment* - The system in which the agent will explore.
<br/>

The order of the Q-Learning Algorithm Process:
1. Initialize Q-Table 
2. Choose an Action
3. Perform and Action
4. Measure Reward
5. Update Q-Table
   * It will go back to "Choose an Action" if the results achieved are not at the terminal state (target destination)


### Q-Table
There are 10 states in total:  S<sub>11</sub>, S<sub>12</sub>, S<sub>21</sub>, S<sub>31</sub>, ..., S<sub>52</sub> (State#)
<br/>
Each of these states are combined with different v_bins and p_bins, which means that each of the 10 states will have 5 subsets to be combined with. This is done in code and done by permutation.
<br/>
<br/>
The values of the v_bins, p_bins, and t_bins are as follows:   <br/>
v_bins = [-5 -1 0 1 5]; <br/>
t_bins = [.300];<br/>
p_bins = [.130 .230 .320 .410 .470 .555 .640 .710 .800 .950]; <br/>
   <br/>
   The state name in the table below is formatted as S<sub>state#(v_bins,t_bins)</sub> to avoid confusion through the table.
   <br/>
| (State Name) | **v_bins** | **p_bins** | **t_bins** | action_1(a_1) | action_2(a_2) | action_3(a_3) | action_4(a_4) | action_5(a_5)
| :---: | :--: | :--: | :--: | :--: | :---: | :---: | :---: | :---:
S<sub>11(-5,0.95)</sub> | **-5** | **0.3** | **0.95** | Q[S<sub>11(-5,0.95)</sub>,a_1] | Q[S<sub>11(-5,0.95]</sub>,a_2] | Q[S<sub>11(-5,0.95)</sub>,a_3] | Q[S<sub>11(-5,0.95)</sub>,a_4] | Q[S<sub>11(-5,.95)</sub>,a_5]
S<sub>11(-1,0.95)</sub> | **-1** | **0.3** | **0.95** | Q[S<sub>11(-1,0.95)</sub>,a_1] | Q[S<sub>11[-1,0.95]</sub>,a_2] | Q[S<sub>11(-1,0.95)</sub>,a_3] | Q[S<sub>11(-1,0.95)</sub>,a_4]  | Q[S<sub>11(-1,0.95)</sub>,a_5]
S<sub>11(0,0.95)</sub> | **0** | **0.3** | **0.95** | Q[S<sub>11(0,0.95)</sub>,a_1] | Q[S<sub>11(0,0.95)</sub>,a_2] | Q[S<sub>11(0,0.95)</sub>,a_3] | Q[S<sub>11(0,0.95)</sub>,a_4]  | Q[S<sub>11(0,0.95)</sub>,a_5]
S<sub>11(1,0.95)</sub> | **1** | **0.3** | **0.95** | Q[S<sub>11(1,0.95]</sub>,a_1] | Q[S<sub>11(1,0.95]</sub>,a_2] | Q[S<sub>11(1,0.95]</sub>,a_3] | Q[S<sub>11(1,0.95)</sub>,a_4]  | Q[S<sub>11(1,0.95)</sub>,a_5]
S<sub>11(5,0.95)</sub> | **5** | **0.3** | **0.95** | Q[S<sub>11(5,0.95)</sub>,a_1] | Q[S<sub>11(5,0.95)</sub>,a_2] | Q[S<sub>11(5,0.95)</sub>,a_3] | Q[S<sub>11(5,0.95]</sub>,a_4]  | Q[S<sub>11(5,0.95)</sub>,a_5]
**An** | **Example** | **of** | **the** | **Next** | **State** | **is** | **Shown** | **Below** |
S<sub>12(-5,0.8)</sub> | **-5** | **0.3** | **0.8** | Q[S<sub>12(-5,0.8)</sub>,a_1] | Q[S<sub>12(-5,0.8)</sub>,a_2) | Q[S<sub>12(-5,0.8)</sub>,a_3) | Q[S<sub>12(-5,0.8)</sub>,a_4)  | Q[S<sub>12(-5,0.8)</sub>, a_5)
S<sub>12(-1,0.8)</sub> | **-1** | **0.3** | **0.8** | Q[S<sub>12(-1,0.8)</sub>,a_1) | Q[S<sub>12(-1,0.8)</sub>,a_2) | Q[S<sub>12(-1,0.8)</sub>,a_3) | Q[S<sub>12(-1,0.8))</sub>,a_4)  | Q[S<sub>12(-1,0.8)</sub>,a_5)
S<sub>12(0,0.8)</sub> | **0** | **0.3** | **0.8** | Q(S<sub>12(0,0.8)</sub>,a_1) | Q(S<sub>12(0,0.8)</sub>,a_2) | Q(S<sub>12(0,0.8)</sub>,a_3) | Q(S<sub>12(0,0.8)</sub>,a_4)  | Q(S<sub>12(0,0.95)</sub>,a_5)
S<sub>12(1,0.8)</sub> | **1** | **0.3** | **0.8** | Q(S<sub>12(1,0.8)</sub>,a_1) | Q(S<sub>12(1,0.8)</sub>,a_2) | Q(S<sub>12(1,0.8)</sub>,a_3) | Q(S<sub>12(1,0.8)</sub>,a_4)  | Q(S<sub>12(1,0.8)</sub>,a_5)
S<sub>12(5,0.8)</sub> | **5** | **0.3** | **0.8** | Q(S<sub>12(5,0.8)</sub>,a_1) | Q(S<sub>12(5,0.8)</sub>,a_2) | Q(S<sub>12(5,0.8)</sub>,a_3) | Q[S<sub>12(5,0.8)</sub>,a_4]  | Q(S<sub>12(5,0.8)</sub>,a_5]
Complete the next 8th States | Repeat above (-5,-1,0,1,5) | 0.3 | Decrease p_bins values for the next 8 states | ... | ...| ... | ...| ...
**An** | **Example** | **of** | **the** | **Last** | **State** | **is** | **Shown** | **Below** |
S<sub>52(-5,0.13)</sub> | **-5** | **0.3** | **0.13** | Q(S<sub>52(-5,0.13)</sub>,a_1) | Q(S<sub>52(-5,0.13)</sub>,a_2) | Q(S<sub>52(-5,0.13)</sub>,a_3) | Q(S<sub>52(-5,0.13)</sub>,a_4)  | Q(S<sub>52(-5,.13)</sub>,a_5)
S<sub>52(-1,0.13)</sub> | **-1** | **0.3** | **0.13** | Q(S<sub>52(-1,0.13)</sub>,a_1) | Q(S<sub>52(-1,0.13)</sub>,a_2) | Q(S<sub>52(-1,0.13)</sub>,a_3) | Q(S<sub>52(-1,0.13)</sub>,a_4)  | Q(S<sub>52(-1,.13)</sub>,a_5)
S<sub>52(0,0.13)</sub> | **0** | **0.3** | **0.13** | Q(S<sub>52(0,0.13)</sub>,a_1) | Q(S<sub>52(0,0.13)</sub>,a_2) | Q(S<sub>52(0,0.13)</sub>,a_3) | Q(S<sub>52(0,0.13)</sub>,a_4)  | Q(S<sub>52(0,0.13)</sub>,a_5)
S<sub>52(1,0.13)</sub> | **1** | **0.3** | **0.13** | Q(S<sub>52(1,0.13)</sub>,a_1) | Q(S<sub>52(1,0.13)</sub>,a_2) | Q(S<sub>52(1,0.13)</sub>,a_3) | Q(S<sub>52(1,0.13)</sub>,a_4)  | Q(S<sub>52(1,0.13)</sub>,a_5)
S<sub>52(5,0.13)</sub> | **5** | **0.3** | **0.13** | Q(S<sub>52(5,0.13)</sub>,a_1) | Q(S<sub>52(5,0.13)</sub>,a_2) | Q(S<sub>52(5,0.13)</sub>,a_3) | Q(S<sub>52(5,0.13)</sub>,a_4)  | Q(S<sub>52(5,0.13)</sub>,a_5)


# Guide to Use the Code
Floating Ball Apparatus Spec Sheet- [Spec Sheet](https://github.com/Jenny-Hoang/ball_and_pipe_control/blob/main/SCFBA%20Specification%20Sheet.pdf)<br/>
[q_algorithim](https://github.com/Jenny-Hoang/ball_and_pipe_control/blob/main/q_algorithim.m) <br/>
To control the ball and pipe system 4 different files were used:<br/>
[ir2y.m](https://github.com/Jenny-Hoang/ball_and_pipe_control/blob/main/ir2y.m)
, [read_data.m](https://github.com/Jenny-Hoang/ball_and_pipe_control/blob/main/read_data.m)
, [real_world.m](https://github.com/Jenny-Hoang/ball_and_pipe_control/blob/main/real_world.m).
, [set_pwm.m](https://github.com/Jenny-Hoang/ball_and_pipe_control/blob/main/real_world.m).

#### q-algorithim (NEED TO FIX)
Built from scratch and has multiple parts. (TYPE MORE IN THIS PART)
###### Creating Bins for the States

###### Bellmans Equation

###### Reward Function

###### Create Simulation for the Agent to Run Through

######


##### Functions in Q-algorithm
1. Binned State Function 
2. Sample State Function
3. Indexing Function
4. Is_done Function 
5. Ramdom Action Function
6. Reward Function 
7. Bellmans Equation

#### ir2y code
Using the command ir2y(x) to calculate the distance from the bottom of the pipe to the ball. x is the ir reading from time flight sensor. X-value  will be calculated by the read_data function. Input ir is the length from the top of the pipe to the ball. Output y is the length from the bottom of the pipe to the ball. y_top is the length of the pipe. In order to calculate the length from the bottom of the pipe to the ball, using the ir_top value and ir value to calculate the distance percentage of the ball. Hence, using the length of the pipe, the distance from the bottom of the pipe to the ball is calculated. 

#### read_data code
The read data function is an important feature in the ball and pipe system that allows the system to get information from the system. The fucntion works by first asking for data from the system. To achieve this you have to send the letter "s" to the system. The system in return will give a 20 value string value. These 20 lines will contain all the values of the distance, pwm, deadpan, and target. The values are in a string value and are seperated by special characters. Next we turned the data from a string to a double and then extracted the data for the different values adn set them to their own variables. 

<!-- distance skip : 2345
pwm skip 6(,) 78910
k
 -->

#### real_world code
It is important to run some of the section in real world to be able to control the ball and pipe system manually. First, using device manager, find out to which port the console USB of the ball and pipe is connected to. This information is used in the section titled "Connect to device". The variable device takes in two parameters, the COM port, string that console USB is connected to, and the baud rate which should be set as 19200 per the spec sheet. Furthermore, give an initial burst between 2000 and 4000 which will start the ball and pipe and one can change it throught the set_pwm command. The feedback loop section is where the q-algorithm would go which would give certain PWM values in relation to what state the agent finds itself or in this case the ping-pong ball.

#### set_pwm code
This code gives the PWM value set as string for action to send it to the ball and pip system per the spec sheet. The first step in taking this code was to first bin the PW values to make sure that values between 0 and 4095 were being inserted into the system. This then assures that an value inserted above 4095 is bounded to 4095 and any value inserted below 0 is bounded to 0. After this is complete, one then need to format the PWM values in order to send said values to the system. This is done first using the sprintf command that writes formatted data to a string or character vectors which in this as is characters. It is then desired to 0 pad the PWM values four zeros after the decimal point. Since the system takes in the format 'PXXXX' the character P will be concatenated with the PWM value. This code cna then be ra in the command window using 'set_pwm(device,#)' which will allow you send pwm vlaues to control the ball and pipe system. 


 


## Getting Started (NEED TO FIX)
Requirements
1.	Need to open device manager and take note on what port the COM is on. There are many possibilities but one of the options can be COM3 and this varies depending on the port that the system (SCFBA) is plug into the computer.
2.	Download PuTTY software which is an implementation of SSH and useful for network file transfer application and is a terminal emulator program.
3.	Some important information about the COM port setting is 
    - Baud: 19200 (speed)
    - Data bits: 8
    - Parity: None
    - Stop bits: 1
    - Flow control: None
    - To see and have access to the settings above, have the PuTTY application open and click on “Serial” which is a sub-branch of Connections and the providing information is given.
5.	We must obtain all the code that was uploaded on Github so open command window or any terminal software and run “git pull origin main” to get the latest changes from the branch named main (or master depending on the name) on the remote named “origin” and this is integrated into local head branch.


3. run the section "device" in "real_world.m" to connect the device and to input that into MATLABs workspace.
(In 'set_pwm'??)

4. in the command window put:
      action = set_pwm (device,3000)
This will allow the ball to move up and down the pipe

5. keep changing the pwm to get the different state values 
  MATLAB will give values of d,p,t,h
    d is the distance from the top of the sensor (cm or mm)
    p
    t
    h
    
5. Using Putty??
    p200
    press 's' to read the value
    
6. s
  
time step is from

realword --> sample rate
target (just make one)
0 bottom
0.5 ball in the middle

reward is open ended to how we set it up


get the different values such as the height and the velocity of the ball from the ball and pipe system
the different values are received from using 
read data and the set_pwm and real world code 

then that gets put into the q-algorithim



Put in the binning states located in Q-algorithm
target --> ball position
10 measurements --> 1 terminal position = target = desired height for the ball = (needed to measure different ball postions)


# Next Steps
  The next steps to this project is to iterate through the simulations and acquire a q-table and measure the times for values to converge. Thus, various simulation will be completed where certain parameters of the bellman’s. Parameters that will be fixed for future simulation will be the learning rate, this will tell the agent whether the action to be taken should be random or to take the action that will reap the best reward. If the learning rate is set to a low value, then actions taken will be more random then measured. On the other hand, if the learning rate is high, then the actions taken will stick to the protocol or values in that will reap the best reward. Ideally, the starting simulation will have a low learning rate in order to drive the algorithm to explore other options and thus having the chance to discover a certain path that will lead faster to the terminal state.
  Another parameter that will be changed is the discount factor, this will then lead to the agent to determine the value of future rewards. Setting this value to zero will lead to decisions that will only reap an immediate reward and thus disregarding future rewards. On the other hand, if the value is set ot 1, then it will assume its actions as the sum of all future rewards. Values between zero and one will be tested in the future to determine which values will lead to a faster convergence to terminal state. After a optimal q-table is implemented, the final step is to add this control or q-algorithm into the feedback loop of the real_world code. One then needs to configure the code to pass in the arguments from the read.m code and use the data to allow the algorithm to determine which state it is in through the binning, then sample_state and then finally indexing_function. Other work in the future is to implement then deep q-learning which replaces the regular Q-table with a neural network. Instead mapping state to action, we would map the input states to action,Q-vlaue pairs. Thus there consists of 2 neural networks which has the main network and target network where ate every N-steps, the weight from the main network are copied to the target network.


# Contact
- Hiep Tran - tranhi75@students.rowan.edu
- Fernando Avila-Nunez - avilan93@students.rowan.edu
- Kevin Thompson - thomps57@students.rowan.edu
- Antonio Silva - silvaa34@students.rowan.edu
- Jenny Hoang - hoangj87@students.rowan.edu


# Acknowledgments/Resources
The background theory of Q-Learning were from the following sources: <br/>
[Source 1](https://gotensor.com/2019/10/02/q-learning-an-introduction-through-a-simple-table-based-implementation-with-learning-rate-discount-factor-and-exploration/)
, [Source 2](https://towardsdatascience.com/a-beginners-guide-to-q-learning-c3e2a30a653c)
, [Source 3](https://www.freecodecamp.org/news/an-introduction-to-q-learning-reinforcement-learning-14ac0b4493cc/).
