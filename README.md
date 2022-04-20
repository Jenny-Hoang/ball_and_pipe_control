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




# Theory of Control Method
Control Method chosen was the **Q-Learning** which is a type of reinforcement learning. The 'Q' in Q-Learning stands for quality. The goal of Q-Learning is to maximuze the value of Q by using a Q-table to find the best solution.<br/>
**Some important terms:** <br/>
*Agents* - This is the entity that will explore the environment and makes decisions according to the Q-Table. In this project the Agent is the ball.
<br/>

*State* - This is where the location of where the object is at. In this project, the pipe is divided into 5 sections and in each section there are 2 subsections which is the state.
<br/>

*Action* - Depending on the state it is in, a specific action will be made.
<br/>

*Rewards* - Depending on the state it is in, it will lead to a positive or negative reward.
<br/>

*Environment* - The system in which the agent will explore.
<br/>

The order of the Q-Learning Algorithm Process:
1. Initialize Q-Table
2. Choose an Action
3. Perform and Action
4. Measure Reward
5. Update Q-Table


### Q-Table
   (maybe add a picture somehow?) 


  

# Guide to Use the Code
Floating Ball Apparatus Spec Sheet- [Spec Sheet](https://github.com/Jenny-Hoang/ball_and_pipe_control/blob/main/SCFBA%20Specification%20Sheet.pdf)<br/>
[q_algorithim](https://github.com/Jenny-Hoang/ball_and_pipe_control/commit/795b4836eecb71e963c6cdd3a1d1df821d32a5ec) <br/>
To control the ball and pipe system 4 different files were used:<br/>
[ir2y.m](https://github.com/Jenny-Hoang/ball_and_pipe_control/blob/main/ir2y.m)
, [read_data.m](https://github.com/Jenny-Hoang/ball_and_pipe_control/blob/main/read_data.m)
, [real_world.m](https://github.com/Jenny-Hoang/ball_and_pipe_control/blob/main/real_world.m).
, [set_pwm.m](https://github.com/Jenny-Hoang/ball_and_pipe_control/blob/main/real_world.m).

#### q-algorithim
Built from scratch and has multiple parts

#### ir2y code
* Added the parameters (ir_bottom and ir_top) values 
* Added the portion under "Bound the IR reading and send error message" and under "Set"

#### read_data code

* Ask and take data from device as a string value
* Turn data from a string to a double and then extract the data for the different values
* All the data is seperated by a special character so extracting the value for each value is easy
* This gives us the value of the distance, pwm, deadpan, and target

<!-- distance skip : 2345
pwm skip 6(,) 78910
k
 -->

#### real_world code
Change the COM Port if neccessary under "Connect to Device"

#### set_pwm code



##### Steps
1. Binned State
2. Sample State
3. Indexing Function
4. Get Action
5. Simulation Step
6. Get Reward
7. Bellmans Equation
8. 


## Notes:
1. device manager<br/>
  check what com port it is on (Possibly COM3)<br/> 
  PuTTY <br/>
      *Port: COM3<br/>
      *Speed: 19200 Speed<br/>
      *Click on "Serial" bubble
     
2. Pull the codes down from GITHUB

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


# Next Steps



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
