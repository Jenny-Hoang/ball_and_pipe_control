# Ball and Pipe System with Q-Learning
<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#overview-of-the-project">Overview of the Project</a>
      <ul>
        </li>
      </ul>
    </li>
    <li>
      <a href="#theory-of-control-method-q-learning">Theory of Control Method(Q-Learning)</a>
      <ul>
        <li><a href="#q-table">Q-Table</a></li>
      </ul>
      <li>
      <a href="#getting-started">Getting Started</a>
        <li>
      <a href="#guide-to-use-the-code">Guide to Use the Code</a>
      <ul>
        <li><a href="#q-algorithm">Q-Algorithm</a></li>
        <li><a href="#ir2y-code">ir2y code</a></li>
        <li><a href="#read_data-code">read_data code</a></li>
        <li><a href="#real_world-code">real_world code</a></li>
        <li><a href="#set_pwm-code">set_pwm code</a></li>
      </ul>
    </li>
    <li><a href="#next-steps">Next Steps</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>

<!-- Done -->

## Overview of the Project:

The ball and pipe system consists of a vertically oriented cylinder with a ping pong ball inside, which has a fan at the bottom and a time of flight sensor at the top to measure the height. This project is done by using a PID controller and performing tests using the laptop as an external PID controller. This system helps students use what they have learned in class and creates a hands on experience to apply their knowledge on their control theory into the project.

With the help of the Systems & Control Floating Ball Apparaturs (SCFBA) Specification (Spec) Sheet provided by the Rowan University's student and faculty. This Spec sheet will answer and guide the students in the right place and how to use the apparatus given to them. The goal of this project is to accomplish the balance the ball at a target altitude. This project is made completely of MATLAB codes to open serial communication with a ball and pipe system. 


## Theory of Control Method (Q-Learning)
Control Method chosen was the **Q-Learning** which is a type of reinforcement learning. The 'Q' in Q-Learning stands for quality. The goal of Q-Learning is to maximize the value of Q by using a Q-table to find the best solution which will tell us what action to take depending on the state that it is in. The q-table will update the more it is in the environment and studies its reward. The q-algorithm detailing is known as the Bellman equation. 

<br/>

**Some important terms:**

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


##### Q-Table
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


## Getting Started
1.	Open device manager and take note on what port the COM is on. There are many possibilities but one of the options can be COM3 and this varies depending on the port that the system (SCFBA) is plugged into the computer.
2.	Download the PuTTY software which is an implementation of SSH, which is useful for network file transfer application and is a terminal emulator program.
3.	Some important information about the COM port setting is:
    - Baud: 19200 (speed)
    - Data bits: 8
    - Parity: None
    - Stop bits: 1
    - Flow control: None
4. To see and have access to the settings above, have the PuTTY application open and click on “Serial” which is a sub-branch of Connections and the providing information will be given.
5.	We must obtain all the code that was uploaded on Github. To do this, open the command window or any terminal software and run “git pull origin main” to get the latest changes from the branch named main (or master depending on the name) on the remote named “origin” and this is integrated into the local head branch.
6.	The “real_world.m” file is the first file to be ran, which connects the input and device into MATLAB’s workspace. There will be an initial burst that will lift the ball and keep it in the air since the pwm value is set to a specific value.
7.	To change the height of ball, the pwm can be adjusted by entering “action = set_pwm(device,3000)” in the command window. Changing the value of the second parameter will yield different state values. MATLAB will output values of d,p,t,h, where “d” is the distance of ball from the Time of Flight (TOF) sensor (in mm). “p” is the manual pwm potentiometer value and “s” is setpoint potentiometer value. Finally, “h” is the hysteresis potentiometer value.
8.	Using the PuTTY software, entering the command packet, which is packet type “S”, will request sensor read message and are sent from the PID Controller to the SCFBA. This will be in a single packet response and the SCFBA will be in the following string “:dddd,pppp,ssss,hhhh” and this can be converted to readable format based on the SCFBA spec sheet.


## Guide to Use the Code
Floating Ball Apparatus Spec Sheet - [Spec Sheet](https://github.com/Jenny-Hoang/ball_and_pipe_control/blob/main/SCFBA%20Specification%20Sheet.pdf)<br/>
Code Specifically Made for Desired Learning Method - [q_algorithim](https://github.com/Jenny-Hoang/ball_and_pipe_control/blob/main/q_algorithim.m) <br/>
The 4 Start-Up Files Given Which Were Updated - 
[ir2y.m](https://github.com/Jenny-Hoang/ball_and_pipe_control/blob/main/ir2y.m)
, [read_data.m](https://github.com/Jenny-Hoang/ball_and_pipe_control/blob/main/read_data.m)
, [real_world.m](https://github.com/Jenny-Hoang/ball_and_pipe_control/blob/main/real_world.m)
, [set_pwm.m](https://github.com/Jenny-Hoang/ball_and_pipe_control/blob/main/real_world.m)

#### Q-Algorithm
This file was built from scratch and contains multiple parts and listed below. The algorithm consists of many functions and were initially set by the states and actions. This is the groundwork for the Q-table. The state is comprised of the target, ball position, and ball velocity. The learning rate and discount factor are both declared. A random value was assigned for the Q-learning to start the algorithm. The q-algorithm has 10,000 episodes to train the q-table. The episode starts with triggering an action based on the q-value and its state. Then the next state is declared. The reward is then given by calling the reward function. The bellman equation, which is the main component of q-learning, is then run to determine the next Q-value. The state is then set as the next state and the function is ran again. This will repeat mutliple times as the q-table gets more and more refined. 

###### Functions in Q-Algorithm
1. Binned State Function 
2. Sample State Function
3. Indexing Function
4. Is_done Function 
5. Random Action Function
6. Reward Function 
7. Bellman Equation

#### ir2y code
The command ir2y(x) was used to calculate the distance from the bottom of the pipe to the ball. x is the ir reading from time flight sensor. X-value will be calculated by the read_data function. Input ir is the length from the top of the pipe to the ball. Output y is the length from the bottom of the pipe to the ball. y_top is the length of the pipe. In order to calculate the length from the bottom of the pipe to the ball, using the ir_top value and ir value to calculate the distance percentage of the ball. Hence, using the length of the pipe, the distance from the bottom of the pipe to the ball is calculated. 

#### read_data code
The read data function is an important feature in the ball and pipe system that allows the system to get information from the system. The function works by first asking for data from the system. To achieve this you have to send the letter "s" to the system. The system in return will give a 20 value string value. These 20 lines will contain all the values of the distance, pwm, deadpan, and target. The values are in a string value and are seperated by special characters. Next we convert the data from a string to a double and then extracted the data for the different values and set them to their own variables. 

#### real_world code
It is important to run some of the section in real world to be able to control the ball and pipe system manually. First, using device manager, find out to which port the console USB of the ball and pipe is connected to. This information is used in the section titled "Connect to device" in the code.(Information on how to find COM port is in the "Getting Started" in this README. The variable device takes in two parameters, the COM port (string that console USB is connected to) and the baud rate which should be set as 19200 per the spec sheet given. Next, give an initial burst between 2000 and 4000 which will start the ball shooting up in the pipe and one can change it throught the set_pwm command. The feedback loop section is where the q-algorithm would go which would give certain PWM values in relation to what state the agent, in this case the ping-pong ball, finds itself.

#### set_pwm code
This code gives the PWM value set as string for action to send it to the ball and pipe system per the spec sheet. The first step in taking this code was to first bin the PW values to make sure that values between 0 and 4095 were being inserted into the system. This then assures that a value inserted above 4095 is bounded to 4095 and any value inserted below 0 is bounded to 0. After this is complete, then the PWM values need to be formatted in order to send the values to the system. This is done first using the sprintf command that writes the formatted data to a string or character vectors, which in this case is characters. It is then desired to 0 pad the PWM values four zeros after the decimal point. Since the system takes in the format 'PXXXX' the character P will be concatenated with the PWM value. This code can then be ran in the command window using 'set_pwm(device,#)' which will allow you send pwm values to control the ball and pipe system. 


# Next Steps
#### Learning Rate
  The next steps to this project is to iterate through the simulations and acquire a q-table and measure the times for values to converge.Thus, various simulation will be completed where certain parameters of the bellman equation will be changed to explore alternative paths. Parameters that will be fixed for future simulation will be the learning rate, this will tell the agent whether the action to be taken should be random or to take the action that will acquire the best reward. If the learning rate is set to a low value, then actions taken will be more random then measured. On the other hand, if the learning rate is high, then the actions taken will stick to the protocol or values in that will acquire the best reward. Ideally, the starting simulation will have a low learning rate in order to drive the algorithm to explore other options and thus having the chance to discover a certain path that will lead faster to the terminal state.
  <br/>
 #### Discount Factor
  Another parameter that will be changed is the discount factor, this will then lead to the agent to determine the value of future rewards. Setting this value to zero will lead to decisions that will only reap an immediate reward and thus disregarding future rewards. On the other hand, if the value is set ot 1, then it will assume its actions as the sum of all future rewards. Values between zero and one will be tested in the future to determine which values will lead to a faster convergence to terminal state. After a optimal q-table is implemented, the final step is to add this control or q-algorithm into the feedback loop of the real_world code. One then needs to configure the code to pass in the arguments from the read.m code and use the data to allow the algorithm to determine which state it is in through the binning, then sample_state and then finally indexing_function. Other work in the future is to implement then deep q-learning which replaces the regular Q-table with a neural network. Instead mapping state to action, we would map the input states to action, Q-value pairs. Thus there consists of 2 neural networks which has the main network and target network where every N-steps, the weight from the main network are copied to the target network.


# Contact
- Hiep Tran - tranhi75@students.rowan.edu
- Fernando Avila-Nunez - avilan93@students.rowan.edu
- Kevin Thompson - thomps57@students.rowan.edu
- Antonio Silva - silvaa34@students.rowan.edu
- Jenny Hoang - hoangj87@students.rowan.edu


# Acknowledgments
The background theory of Q-Learning were from the following sources: <br/>
[Source 1](https://gotensor.com/2019/10/02/q-learning-an-introduction-through-a-simple-table-based-implementation-with-learning-rate-discount-factor-and-exploration/)
, [Source 2](https://towardsdatascience.com/a-beginners-guide-to-q-learning-c3e2a30a653c)
, [Source 3](https://www.freecodecamp.org/news/an-introduction-to-q-learning-reinforcement-learning-14ac0b4493cc/).

<!-- distance skip : 2345
pwm skip 6(,) 78910
k
 -->
