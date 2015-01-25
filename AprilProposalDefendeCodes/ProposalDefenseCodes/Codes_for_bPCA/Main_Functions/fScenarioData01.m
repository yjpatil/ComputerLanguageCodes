function[ScenarioData] = fScenarioData01(Choice,Blocks);
% This function simply configures the geometric coding of the scenario %


if(Choice==1)
    NumInstances = 43; % <---------- Change:: Total number of samples
    
    ScenarioData = zeros(Blocks,NumInstances);
    % <> --------- Training Data ----------- <> %
    % <> <> ---- Data01 -- PART 01
    ScenarioData([1:5],1) = 1;%ScenarioData([1,7,13,19,25],1) = 1;
    ScenarioData([7:11],2) = 1;
    ScenarioData([13:17],3) = 1;%ScenarioData([3,9,15,21,27],3) = 1;
    ScenarioData([19:23],4) = 1;
    ScenarioData([25:29],5) = 1;
    ScenarioData([31:35],6) = 1;
    % <> <> ---- Data01 -- PART 02
    ScenarioData([2:6],7) = 1;
    ScenarioData([8:12],8) = 1;
    ScenarioData([14:18],9) = 1;
    ScenarioData([20:24],10) = 1;
    ScenarioData([26:30],11) = 1;
    ScenarioData([32:36],12) = 1;
    % <> <> ---- Data02 -- PART 01
    ScenarioData([1,8,15,22],13) = 1;
    ScenarioData([2,9,16,23],14) = 1;
    ScenarioData([3,10,17,24],15) = 1;
    ScenarioData([7,14,21,28],16) = 1;
    ScenarioData([14,21,28,35],17) = 1;
    ScenarioData([8,15,22,29],18) = 1;
    ScenarioData([15,22,29,36],19) = 1;
    ScenarioData([9,16,23,30],20) = 1;
    % <> <> ---- Data02 -- PART 02
    ScenarioData([13,20,27,34],21) = 1;
    ScenarioData([14,21,28,35],22) = 1;
    ScenarioData([15,22,29,36],23) = 1;
    % <> <> ---- Data03 -- PART 01
    ScenarioData([6,11,16,21],24) = 1;
    ScenarioData([5,10,15,20],25) = 1;
    ScenarioData([4,9,14,19],26) = 1;
    ScenarioData([12,17,22,27],27) = 1;
    ScenarioData([18,23,28,33],28) = 1;
    % <> <> ---- Data03 -- PART 02
    ScenarioData([11,16,21,26],29) = 1;
    ScenarioData([16,21,26,31],30) = 1;
    ScenarioData([10,15,20,25],31) = 1;
    % <> <> ---- Data04 -- PART 01
    ScenarioData([1,7,13,19],32) = 1;
    ScenarioData([2,8,14,20],33) = 1;
    ScenarioData([3,9,15,21],34) = 1;
    ScenarioData([4,10,16,22],35) = 1;
    ScenarioData([5,11,17,23],36) = 1;
    ScenarioData([6,12,18,24],37) = 1;
    % <> <> ---- Data04 -- PART 02
    ScenarioData([7,13,19,25],38) = 1;
    ScenarioData([8,14,20,26],39) = 1;
    ScenarioData([9,15,21,27],40) = 1;
    ScenarioData([10,16,22,28],41) = 1;
    ScenarioData([11,17,23,29],42) = 1;
    ScenarioData([12,18,24,30],43) = 1;
    
elseif(Choice==2)
    NumInstances = 10; % Total number of samples
    
    ScenarioData = zeros(Blocks,NumInstances);
    ScenarioData([1,2,3,7,9,13,14,15],1) = 1;
    ScenarioData([2,3,4,8,10,14,15,16],2) = 1;
    ScenarioData([7,8,9,13,15,19,20,21],3) = 1;
    ScenarioData([8,9,10,14,16,20,21,22],4) = 1;
    ScenarioData([3,4,5,9,11,15,16,17],5) = 1;
    ScenarioData([4,5,6,10,12,16,17,18],6) = 1;
    ScenarioData([9,10,11,15,17,21,22,23],7) = 1;
    ScenarioData([10,11,12,16,18,22,23,24],8) = 1;
    ScenarioData([19,20,21,25,27,31,32,33],9) = 1;
    ScenarioData([20,21,22,26,28,32,33,34],10) = 1;
    
    
elseif(Choice==3)
    NumInstances = 10; % Total number of samples
    
    % <> <> ---- Data01 -- PART 01
    ScenarioData = zeros(Blocks,NumInstances);
    ScenarioData([1,7,13,19,8,14,15],1) = 1;
    ScenarioData([2,8,14,20,9,15,16],2) = 1;
    ScenarioData([3,9,15,21,10,16,17],3) = 1;
    ScenarioData([4,10,16,22,11,17,18],4) = 1;
    ScenarioData([4,10,16,22,11,17,12],5) = 1;
    % <> <> ---- Data01 -- PART 02    
    ScenarioData([1,7,13,19,8,14,9],6) = 1;
    ScenarioData([2,8,14,20,9,15,10],7) = 1;
    ScenarioData([3,9,15,21,10,16,11],8) = 1;
    ScenarioData([3,9,15,21,10,16,12],9) = 1;
    ScenarioData([3,9,15,21,10,16,18],10) = 1;
    
elseif(Choice==4)
    ScenarioData = [];
else
    disp('Wrong Choice!!!')
    stop
end
    





end





