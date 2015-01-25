function[Sc01,Sc02,Sc03,Info] = fHScenarioData001(Blocks);
% This function simply configures the geometric coding of the scenario %
% ****
% %-- YOU CAN HAVE ONE SCENARIO WITH TWO OR MORE GEOMETRICAL STRUCTURE -% %
% ****
NumInstances1 = 41; % <---------- Change:: Total number of samples    
NumInstances2 = 28; % <---------- Change:: Total number of samples    
NumInstances3 = 20; % <---------- Change:: Total number of samples    

Info = [NumInstances1,NumInstances2,NumInstances3];

Sc01 = zeros(Blocks,NumInstances1);% Sc01 is a matrix of 25 x blocks
Sc02 = zeros(Blocks,NumInstances2);
Sc03 = zeros(Blocks,NumInstances3);


% <> --------- Training Data ----------- <> %
% <> <> ---- Scenario 01 -- Case 01 <> <> ----- %
% Info:: Case Data Length -> 1 to ; Horizontal RECTANGLE BOX ---- 
Sc01([1,2,3,6,7,8],1) = 1;%ScenarioData([1,7,13,19,25],1) = 1;
Sc01([2,3,4,7,8,9],2) = 1;
Sc01([3,4,5,8,9,10],3) = 1;
Sc01([6,7,8,11,12,13],4) = 1;
Sc01([7,8,9,12,13,14],5) = 1;%ScenarioData([3,9,15,21,27],3) = 1;
Sc01([8,9,10,13,14,15],6) = 1;
Sc01([16,17,18,21,22,23],7) = 1;
Sc01([17,18,19,22,23,24],8) = 1;
Sc01([18,19,20,23,24,25],9) = 1;

% --- Vertical RECTANGLE BOX ---- 
Sc01([1,2,6,7,11,12],10) = 1;
Sc01([3,4,8,9,13,14],11) = 1;
Sc01([4,5,9,10,14,15],12) = 1;
Sc01([6,7,11,12,16,17],13) = 1;
Sc01([8,9,13,14,18,19],14) = 1;
Sc01([9,10,14,15,19,20],15) = 1;
Sc01([11,12,16,17,21,22],16) = 1;
Sc01([13,14,18,19,23,24],17) = 1;
Sc01([14,15,19,20,24,25],18) = 1;

% --- SQUARE NORMAL --
Sc01([1,2,6,7],19) = 1;
Sc01([3,4,8,9],20) = 1;
Sc01([4,5,9,10],21) = 1;
Sc01([6,7,11,12],22) = 1;
Sc01([7,8,12,13],23) = 1;
Sc01([8,9,13,14],24) = 1;
Sc01([9,10,14,15],25) = 1;
Sc01([11,12,16,17],26) = 1;
Sc01([13,14,18,19],27) = 1;
Sc01([14,15,19,20],28) = 1;
Sc01([16,17,21,22],29) = 1;
Sc01([17,18,22,23],30) = 1;
Sc01([18,19,23,24],31) = 1;
Sc01([19,20,24,25],32) = 1;

% ---- SQUARE DIAGONAL ---- %
Sc01([6,2,8,12],33) = 1;
Sc01([7,3,13,9],34) = 1;
Sc01([8,4,14,10],35) = 1;
Sc01([11,7,17,13],36) = 1;
Sc01([12,8,18,14],37) = 1;
Sc01([13,9,19,15],38) = 1;
Sc01([16,12,22,18],39) = 1;
Sc01([17,13,23,19],40) = 1;
Sc01([18,14,24,20],41) = 1;

% <> <> ---- Scenario 02 -- Case 01 <> <> ----- %
% --- HORIZONTAL LINE 4 People ---- % 
Sc02([1:4],1) = 1;
Sc02([2:5],2) = 1;
Sc02([6:9],3) = 1;
Sc02([7:10],4) = 1;
Sc02([11:14],5) = 1;
Sc02([12:15],6) = 1;
Sc02([16:19],7) = 1;
Sc02([17:20],8) = 1;
Sc02([21:24],9) = 1;
Sc02([22:25],10) = 1;

% ---- DIAGONAL LINE BACK SLASH ---- %
Sc02([1,7,13,19],11) = 1;
Sc02([2,8,14,20],12) = 1;
Sc02([6,12,18,24],13) = 1;
Sc02([7,13,19,25],14) = 1;

% ---- DIAGONAL LINE FORWARD SLASH ---- %
Sc02([4,8,12,16],15) = 1;
Sc02([5,9,13,17],16) = 1;
Sc02([10,14,18,22],17) = 1;
Sc02([9,13,17,21],18) = 1;

% ----- VERTICAL LINE ----- %
Sc02([1,6,11,16],19) = 1;
Sc02([2,7,12,17],20) = 1;
Sc02([3,8,13,18],21) = 1;
Sc02([4,9,14,19],22) = 1;
Sc02([5,10,15,20],23) = 1;
Sc02([6,11,16,21],24) = 1;
Sc02([7,12,17,22],25) = 1;
Sc02([8,13,18,23],26) = 1;
Sc02([9,14,19,24],27) = 1;
Sc02([10,15,20,25],28) = 1;



% % <> <> ---- Data03 -- Case 01 <> <> ----- %
% Info:: Case Data Length -> 1 to 34; one person (standing in center) giving PPT to a group
Sc03([1,2,6,7,8,11,12,13],1) = 1;
Sc03([3,4,8,9,10,13,14],2) = 1;
Sc03([11,12,16,17,18,21,22],3) = 1;
Sc03([13,14,18,19,23,24],4) = 1;
Sc03([6,7,11,12,13,16,17],5) = 1;
Sc03([8,9,13,14,15,18,19],6) = 1;
Sc03([2,3,6,7,8,12,13],7) = 1;
Sc03([4,5,8,9,10,14,15],8) = 1;
Sc03([7,8,11,12,13,17,18],9) = 1;
Sc03([9,10,13,14,15,19,20],10) = 1;
Sc03([12,13,16,17,18,22,23],11) = 1;
Sc03([13,14,17,18,19,23,24],12) = 1;
Sc03([14,15,18,19,20,24,25],13) = 1;
Sc03([6,11,2,7,12,8,13],14) = 1;
Sc03([8,13,4,9,14,10,15],15) = 1;
Sc03([11,16,7,12,17,13,18],16) = 1;
Sc03([13,18,9,14,19,15,20],17) = 1;
Sc03([16,21,12,17,22,18,23],18) = 1;
Sc03([18,23,14,19,24,20,25],19) = 1;
Sc03([1,6,2,7,12,3,8],20) = 1;
Sc03([3,8,4,9,14,5,10],21) = 1;
Sc03([11,16,12,17,22,13,18],22) = 1;
Sc03([13,18,14,19,24,15,20],23) = 1;
Sc03([2,3,4,7,8,9,13],24) = 1;
Sc03([7,8,9,12,13,14,18],25) = 1;
Sc03([12,13,14,17,18,19,23],26) = 1;
Sc03([13,17,18,19,22,23,24],27) = 1;
Sc03([8,12,13,14,17,18,19],28) = 1;
Sc03([3,7,8,9,12,13,14],29) = 1;
Sc03([],30) = 1;




   
    
   
    
    
   



end





