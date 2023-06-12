[top]
components : repair_robot

[repair_robot]
type : cell
width : 16
height : 24
delay : inertial
defaultDelayTime  : 100
border : nowrapped

% Neighbourhood definition
neighbors : repair_robot(-1,-1,0) repair_robot(-1,0,0) repair_robot(-1,1,0)
neighbors : repair_robot(0,-1,0)  repair_robot(0,0,0)  repair_robot(0,1,0)
neighbors : repair_robot(1,-1,0)  repair_robot(1,0,0)  repair_robot(1,1,0)
neighbors : repair_robot(0,0,1)  repair_robot(0,0,-1)

% Initialization of dimensional space
initialvalue : 0
initialCellsValue : damaged_field.val 

localtransition : scan_field

% Borders definitions
zone : top_bounce { (0,1,0)..(0,14,0) }
zone : bottom_bounce { (23,1,0)..(23,14,0) }
zone : left_bounce { (1,0,0)..(22,0,0) }
zone : right_bounce { (1,15,0)..(22,15,0) }
zone : ul_corner_bounce { (0,0,0) }
zone : ur_corner_bounce { (0,15,0) }
zone : ll_corner_bounce { (23,0,0) }
zone : lr_corner_bounce { (23,15,0) }
zone : repair_time_memory { (0,0,1)..(23,15,1) }

% Definition of cell states
%
% 0 	Cell is free.  Will accept a robot
% 1	Robot present and travelling North-East
% 2	Robot present and travelling North-West
% 3	Robot present and travelling South-East
% 4	Robot present and travelling South-West
% 5X	Collision will occur in this cell unless robots alter course.
%	It is suggested that robots move around the cell 
%	in a counter-clockwise direction.  The "X" is the state of the 
%	cell before it detected the potential collision.
% 6X	Collision will occur in this cell unless robots alter course.
%	It is suggested that robots move the cell 
%	in a clockwise direction.  The "X" is the state of the 
%	cell before it detected the potential collision.
% 7X	Deadlock.  A collision will occur and moving around the cell 
%	is not an option to prevent the collision.  Robots are to alter
%	course 180 degrees.


[scan_field]
% Rules to stop a robot to effect repairs.
%
% Repair of a single damage
rule : 81 100 { (((-1,-1,0) = 5 or (-1,0,0) = 5 or (-1,1,0) = 5 or (0,1,0) = 5 or (1,1,0) = 5) and (1,-1,0) = 1) }
rule : 82 100 { (((1,-1,0) = 5 or (0,-1,0) = 5 or (-1,-1,0) = 5 or (-1,0,0) = 5 or (-1,1,0) = 5) and (1,1,0) = 2) }
rule : 83 100 { (((1,-1,0) = 5 or (-1,1,0) = 5 or (0,1,0) = 5 or (1,1,0) = 5 or (1,0,0) = 5) and (-1,-1,0) = 3) }
rule : 84 100 { (((1,-1,0) = 5 or (0,-1,0) = 5 or (-1,-1,0) = 5 or (1,1,0) = 5 or (1,0,0) = 5) and (-1,1,0) = 4) }
% Repair of a double damage
rule : 81 100 { (((-1,-1,0) = 6 or (-1,0,0) = 6 or (-1,1,0) = 6 or (0,1,0) = 6 or (1,1,0) = 6) and (1,-1,0) = 1) }
rule : 82 100 { (((1,-1,0) = 6 or (0,-1,0) = 6 or (-1,-1,0) = 6 or (-1,0,0) = 6 or (-1,1,0) = 6) and (1,1,0) = 2) }
rule : 83 100 { (((1,-1,0) = 6 or (-1,1,0) = 6 or (0,1,0) = 6 or (1,1,0) = 6 or (1,0,0) = 6) and (-1,-1,0) = 3) }
rule : 84 100 { (((1,-1,0) = 6 or (0,-1,0) = 6 or (-1,-1,0) = 6 or (1,1,0) = 6 or (1,0,0) = 6) and (-1,1,0) = 4) }

% Potential collision detection rules.  One of these rules will be true
% if a potential collision is detected and if altering course in a 
% counter-clockwise direction around the collision cell seems to be the
% right thing to do.
% Robot to robot collisions
rule : { 50+(0,0,0) } 000 { ((-1,1,0) = 4 and (1,1,0) = 2 and (-1,0,0) != 3 and (1,0,0) != 1 and (0,1,0) != 2 and (0,-1,0) != 1 and (0,0,0) < 10) }
rule : { 50+(0,0,0) } 000 { ((-1,1,0) = 4 and (1,-1,0) = 1 and (0,-1,0) != 3 and (0,-1,0) != 1 and (0,1,0) != 2 and (0,1,0) != 4 and (0,0,0) < 10) }
rule : { 50+(0,0,0) } 000 { ((-1,1,0) = 4 and (-1,-1,0) = 3 and (0,1,0) != 2 and (0,-1,0) != 1 and (-1,0,0) != 4 and (1,0,0) != 2 and (0,0,0) < 10) }
rule : { 50+(0,0,0) } 000 { ((1,1,0) = 2 and (1,-1,0) = 1 and (-1,0,0) != 3 and (1,0,0) != 1 and (0,1,0) != 4 and (0,-1,0) != 3 and (0,0,0) < 10) }
rule : { 50+(0,0,0) } 000 { ((1,1,0) = 2 and (-1,-1,0) = 3 and (-1,0,0) != 3 and (-1,0,0) != 4 and (1,0,0) != 1 and (1,0,0) != 2 and (0,0,0) < 10) }
rule : { 50+(0,0,0) } 000 { ((1,-1,0) = 1 and (-1,-1,0) = 3 and (0,1,0) != 4 and (0,-1,0) != 3 and (-1,0,0) != 4 and (1,0,0) != 2 and (0,0,0) < 10) }

% Robot to damage collision
rule : { 50+(0,0,0) } 000 { ((-1,1,0) = 4 and (0,0,0) >= 5 and (0,0,0) <= 8.4 and (0,1,0) != 2 and (0,1,0) != 82 and (0,-1,0) != 1 and (0,-1,0) != 81) }
rule : { 50+(0,0,0) } 000 { ((-1,-1,0) = 3 and (0,0,0) >= 5 and (0,0,0) <= 8.4 and (1,0,0) != 2 and (1,0,0) != 82 and (-1,0,0) != 4 and (-1,0,0) != 84) }
rule : { 50+(0,0,0) } 000 { ((1,-1,0) = 1 and (0,0,0) >= 5 and (0,0,0) <= 8.4 and (0,-1,0) != 3 and (0,-1,0) != 83 and (0,1,0) != 4 and (0,1,0) != 84) }
rule : { 50+(0,0,0) } 000 { ((1,1,0) = 2 and (0,0,0) >= 5 and (0,0,0) <= 8.4 and (1,0,0) != 1 and (1,0,0) != 81 and (-1,0,0) != 3 and (-1,0,0) != 83) }

% Potential collision detection rules.  One of these rules will be true
% if a potential collision is detected and if altering course in a 
% clockwise direction around the collision cell seems to be the
% right thing to do.
% Robot-to-robot collision
rule : { 60+(0,0,0) } 000 { ((-1,1,0) = 4 and (1,1,0) = 2 and (-1,0,0) != 3 and (1,0,0) != 1 and (0,1,0) != 4 and (0,-1,0) != 3 and (0,0,0) < 10) }
rule : { 60+(0,0,0) } 000 { ((-1,1,0) = 4 and (1,-1,0) = 1 and (-1,0,0) != 3 and (-1,0,0) != 4 and (1,0,0) != 2 and (1,0,0) != 1 and (0,0,0) < 10) }
rule : { 60+(0,0,0) } 000 { ((-1,1,0) = 4 and (-1,-1,0) = 3 and (0,-1,0) != 1 and (0,1,0) != 2 and (-1,0,0) != 3 and (1,0,0) != 1 and (0,0,0) < 10) }
rule : { 60+(0,0,0) } 000 { ((1,1,0) = 2 and (1,-1,0) = 1 and (0,1,0) != 4 and (0,-1,0) != 3 and (-1,0,0) != 4 and (1,0,0) != 2 and (0,0,0) < 10) }
rule : { 60+(0,0,0) } 000 { ((1,1,0) = 2 and (-1,-1,0) = 3 and (0,1,0) != 2 and (0,1,0) != 4 and (0,-1,0) != 1 and (0,-1,0) != 3 and (0,0,0) < 10) }
rule : { 60+(0,0,0) } 000 { ((1,-1,0) = 1 and (-1,-1,0) = 3 and (1,0,0) != 2 and (-1,0,0) != 4 and (0,1,0) != 2 and (0,-1,0) != 1 and (0,0,0) < 10) }
%
% Robot to damage collision
rule : { 60+(0,0,0) } 000 { ((-1,1,0) = 4 and (0,0,0) >= 5 and (0,0,0) <= 8.4 and (-1,0,0) != 3 and (-1,0,0) != 83 and (1,0,0) != 1 and (1,0,0) != 81) }
rule : { 60+(0,0,0) } 000 { ((-1,-1,0) = 3 and (0,0,0) >= 5 and (0,0,0) <= 8.4 and (0,-1,0) != 1 and (0,-1,0) != 81 and (0,1,0) != 2 and (0,1,0) != 2) }
rule : { 60+(0,0,0) } 000 { ((1,-1,0) = 1 and (0,0,0) >= 5 and (0,0,0) <= 8.4 and (-1,0,0) != 4 and (-1,0,0) != 84 and (1,0,0) != 2 and (1,0,0) != 82) }
rule : { 60+(0,0,0) } 000 { ((1,1,0) = 2 and (0,0,0) >= 5 and (0,0,0) <= 8.4 and (0,-1,0) != 3 and (0,-1,0) != 83 and (0,1,0) != 4 and (0,1,0) != 84) }

% Deadlock detection rules.  One of these rules will be true
% if a potential collision is detected and it was foind that altering course
% in a clockwise or counter-clockwise direction around the collision cell
% would not prevent the collision.
rule : { (70+(0,0,0)) } 000 { ((-1,1,0) = 4 and (1,1,0) = 2 and (0,0,0) < 10) }
rule : { (70+(0,0,0)) } 000 { ((-1,1,0) = 4 and (1,-1,0) = 1 and (0,0,0) < 10) }
rule : { (70+(0,0,0)) } 000 { ((-1,1,0) = 4 and (-1,-1,0) = 3 and (0,0,0) < 10) }
rule : { (70+(0,0,0)) } 000 { ((1,1,0) = 2 and (1,-1,0) = 1 and (0,0,0) < 10) }
rule : { (70+(0,0,0)) } 000 { ((1,1,0) = 2 and (-1,-1,0) = 3 and (0,0,0) < 10) }
rule : { (70+(0,0,0)) } 000 { ((1,-1,0) = 1 and (-1,-1,0) = 3 and (0,0,0) < 10) }


% Collision avoidance rules.  These rules move robots in a clockwise
% or counter clockwise direction around a cell which detected a 
% potential collision or cause the robots to alter course
% 180 degrees if a deadlock has been signalled.
rule : 1 100 { ((0,1,0) >= 60 and (0,1,0) <= 69 and (1,0,0) = 1) }
rule : 1 100 { ((-1,0,0) >= 50 and (-1,0,0) <= 59 and (0,-1,0) = 1) }
rule : 2 100 { ((-1,0,0) >= 60 and (-1,0,0) <= 69 and (0,1,0) = 2) }
rule : 2 100 { ((0,-1,0) >= 50 and (0,-1,0) <= 59 and (1,0,0) = 2) }
rule : 3 100 { ((1,0,0) >= 60 and (1,0,0) <= 69 and (0,-1,0) = 3) }
rule : 3 100 { ((0,1,0) >= 50 and (0,1,0) <= 59 and (-1,0,0) = 3) }
rule : 4 100 { ((0,-1,0) >= 60 and (0,-1,0) <= 69 and (-1,0,0) = 4) }
rule : 4 100 { ((1,0,0) >= 50 and (1,0,0) <= 59 and (0,1,0) = 4) }
% FIX ME - these rules cause a robot to stay in the same 
% cell for 200 msec.
rule : 1 100 { ((1,-1,0) >= 70 and (1,-1,0) <= 79 and (0,0,0) = 4) }
rule : 2 100 { ((1,1,0) >= 70 and (1,1,0) <= 79 and (0,0,0) = 3) }
rule : 3 100 { ((-1,-1,0) >= 70 and (-1,-1,0) <= 79 and (0,0,0) = 2) }
rule : 4 100 { ((-1,1,0) >= 70 and (-1,1,0) <= 79 and (0,0,0) = 1) }

% Rule to turn damage into damage under repair
rule : 5.1 000 { ((0,0,0) = 5 and (stateCount(81) + stateCount(82) + stateCount(83) + stateCount(84)) > 0) }

rule : 6.1 000 { ((0,0,0) = 6 and ((-1,0,0) >= 80 or (1,0,0) >= 80 or (0,1,0) >=80 or (0,-1,0) >= 80 or (-1,-1,0) >= 80 or (1,1,0) >=80 or (-1,1,0) >= 80 or (1,-1,0) >= 80)) }
rule : 6.2 000 { ((0,0,0) = 6.1 and ((-1,0,0) >= 80 or (1,0,0) >= 80 or (0,1,0) >=80 or (0,-1,0) >= 80 or (-1,-1,0) >= 80 or (1,1,0) >=80 or (-1,1,0) >= 80 or (1,-1,0) >= 80)) }

% Rule to turn damage under repair into "no damage"
rule : 0 { if(((0,0,1) > time),((0,0,1) - time),1000) } { (0,0,0) = 5.1 }

% Rule to return a repairing robot to a scanning robot after it has completed
% repairs.
rule :  { remainder((0,0,0),10) } 1000 { ((0,0,0) >= 80 and (0,0,0) <= 89) }

% Rules to return a cell to the state it was in prior to it detecting
% a potential collision.
rule :  { remainder((0,0,0),10) } 100 { ((0,0,0) >= 50 and (0,0,0) <= 79) }

% Rules to move the robots.
rule : 1 100 { ((1,-1,0) = 1) }
rule : 2 100 { ((1,1,0) = 2) }
rule : 3 100 { ((-1,-1,0) = 3) }
rule : 4 100 { ((-1,1,0) = 4) }

% Rule to keep damage at its present location
rule : { (0,0,0) } 100 { ((0,0,0) >= 5 and (0,0,0) <= 8.4) }

% Default rule.  Causes a cell to go back to 0 after a robot 
% left the cell
rule : 0 100 { t }

[top_bounce]
rule : 3 100 { (1,-1,0) = 1 }
rule : 4 100 { (1,1,0) = 2 }
rule : 0 100 { t }

[bottom_bounce]
rule : 2 100 { (-1,1,0) = 4 }
rule : 1 100 { (-1,-1,0) = 3 }
rule : 0 100 { t }

[left_bounce]
rule : 1 100 { (1,1,0) = 2 }
rule : 3 100 { (-1,1,0) = 4 }
rule : 0 100 { t }

[right_bounce]
rule : 2 100 { (1,-1,0) = 1 }
rule : 4 100 { (-1,-1,0) = 3 }
rule : 0 100 { t }

[ul_corner_bounce]
rule : 3 100 { (1,1,0) = 2 }
rule : 0 100 { t }

[ur_corner_bounce]
rule : 4 100 { (1,-1,0) = 1 }
rule : 0 100 { t }

[ll_corner_bounce]
rule : 1 100 { (-1,1,0) = 4 }
rule : 0 100 { t }

[lr_corner_bounce]
rule : 2 100 { (-1,-1,0) = 3 }
rule : 0 100 { t }

[repair_time_memory]
rule : { time+1000 } 000 { ((0,0,-1) = 5.1 and (0,0,0) = 0) }
rule : { time+4000 } 000 { ((0,0,-1) = 6.1 and (0,0,0) = 0) }
rule : { time+8000 } 000 { ((0,0,-1) = 7.1 and (0,0,0) = 0) }
rule : { time+16000 } 000 { ((0,0,-1) = 8.1 and (0,0,0) = 0) }
rule : { (0,0,0) } 100 { t }
