function [pX,pY,angle_direct] = fScDispTraj001(LastpX,LastpY,subject_choice,Scenario_choice)
% This is the function which has different trajectories for different
% subjects based on their scenarios
% LastpX - last X-coordinate of the Subject
% LastpY - last Y-coordinate of the Subject
% subject_choice,Scenario_choice - %

%%global Temp4 Temp6;

if(Scenario_choice == 1)
    if(subject_choice == 1)
        x1 = LastpX;
        y1 = LastpY;
        
        x2 = x1 + 2;% subject walks away from table 2 units, + means to left side
        % --------- stage 6: Sub1 walks away from table -------- %
        path6x = x1:0.1:x2;
        path6y = y1*ones(size(path6x));
        angle_direct6 = 0*ones(size(path6x));
        path6x = [path6x;ones(size(path6y))]; %%<-------- swing angle check !!!
        % --------- stage 7: Sub1 is away from the chair now -------- %
        path7y = y1:0.1:18;
        path7x = x2*ones(size(path7y));
        angle_direct7 = 90*ones(size(path7x));        
        path7x = [path7x;ones(size(path7x))]; %%<-------- swing angle check !!!
        % --------- stage 8: Sub1 moves near to exit -------- %
        path8x = x2:-0.1:2;
        path8y = 18*ones(size(path8x));
        angle_direct8 = 180*ones(size(path8x));        
        path8x = [path8x;ones(size(path8x))]; %%<-------- swing angle check !!!
        % --------- stage  -------- %
        
        % --------- stage 10: Sub1 moves straight home -------- %
        path10y = 18:-0.1:2;
        path10x = 2*ones(size(path10y));
        angle_direct10 = -90*ones(size(path10x));        
        path10x = [path10x;ones(size(path10x))]; %%<-------- swing angle check !!!
        % --------- stage 11:  -------- %
        path11x = 2:0.1:17;
        path11y = 2*ones(size(path11x));
        angle_direct11 = 0*ones(size(path11x));        
        path11x = [path11x;ones(size(path11x))]; %%<-------- swing angle check !!!
        % --------- stage 12: -------- %
        path12y = 2:0.1:10;
        path12x = 18*ones(size(path12y));
        angle_direct12 = 90*ones(size(path12x));        
        path12x = [path12x;ones(size(path12x))]; %%<-------- swing angle check !!!
        
        pX = [path6x,path7x,path8x,path10x,path11x,path12x];
        pY = [path6y,path7y,path8y,path10y,path11y,path12y];
        angle_direct = [angle_direct6,angle_direct7,angle_direct8,angle_direct10,angle_direct11,angle_direct12];
    elseif(subject_choice == 2)
        x1 = LastpX;
        y1 = LastpY;
        
        x2 = x1 - 1;% Move back from table (-ve sign)
        % --------- stage 6: Sub1 walks away from table -------- %
        path6x = x1:-0.1:x2;
        path6y = y1*ones(size(path6x));
        angle_direct6 = 180*ones(size(path6x));
        path6x = [path6x;ones(size(path6y))]; %%<-------- swing angle check !!!
        % --------- stage 7: Sub1 is away from the chair now -------- %
        path7y = y1:0.1:16.5;
        path7x = x2*ones(size(path7y));
        angle_direct7 = 90*ones(size(path7x));        
        path7x = [path7x;ones(size(path7x))]; %%<-------- swing angle check !!!
        % --------- stage 8: Sub1 moves near to exit -------- %
        path8x = x2:-0.1:2;
        path8y = 16.5*ones(size(path8x));
        angle_direct8 = 180*ones(size(path8x));        
        path8x = [path8x;ones(size(path8x))]; %%<-------- swing angle check !!!
        % --------- stage  -------- %
        
        % --------- stage 10: Sub1 moves straight home -------- %
        path10y = 16.5:-0.1:2;
        path10x = 2*ones(size(path10y));
        angle_direct10 = -90*ones(size(path10x));        
        path10x = [path10x;ones(size(path10x))]; %%<-------- swing angle check !!!
        % --------- stage 11:  -------- %
        path11x = 2:0.1:19;
        path11y = 2*ones(size(path11x));
        angle_direct11 = 0*ones(size(path11x));        
        path11x = [path11x;ones(size(path11x))]; %%<-------- swing angle check !!!        
        
        pX = [path6x,path7x,path8x,path10x,path11x];
        pY = [path6y,path7y,path8y,path10y,path11y];
        angle_direct = [angle_direct6,angle_direct7,angle_direct8,angle_direct10,angle_direct11];               
    elseif(subject_choice == 3)
        x1 = LastpX;
        y1 = LastpY;
        
        x2 = x1 + 1;
        % --------- stage 6: Sub1 walks away from table -------- %
        path6x = x1:0.1:x2;
        path6y = y1*ones(size(path6x));
        angle_direct6 = 0*ones(size(path6x));
        path6x = [path6x;ones(size(path6y))]; %%<-------- swing angle check !!!
        % --------- stage 7: Sub1 is away from the chair now -------- %
        path7y = y1:0.1:17;
        path7x = x2*ones(size(path7y));
        angle_direct7 = 90*ones(size(path7x));        
        path7x = [path7x;ones(size(path7x))]; %%<-------- swing angle check !!!
        % --------- stage 8: Sub1 moves near to exit -------- %
        path8x = x2:-0.1:3;
        path8y = 17*ones(size(path8x));
        angle_direct8 = 180*ones(size(path8x));        
        path8x = [path8x;ones(size(path8x))]; %%<-------- swing angle check !!!
        % --------- stage  -------- %
        
        % --------- stage 10: Sub1 moves straight home -------- %
        path10y = 17:-0.1:1;
        path10x = 3*ones(size(path10y));
        angle_direct10 = -90*ones(size(path10x));        
        path10x = [path10x;ones(size(path10x))]; %%<-------- swing angle check !!!
        % --------- stage 11:  -------- %
        path11x = 1:0.1:6;
        path11y = 1*ones(size(path11x));
        angle_direct11 = 0*ones(size(path11x));        
        path11x = [path11x;ones(size(path11x))]; %%<-------- swing angle check !!!
        
        
        pX = [path6x,path7x,path8x,path10x,path11x];
        pY = [path6y,path7y,path8y,path10y,path11y];
        angle_direct = [angle_direct6,angle_direct7,angle_direct8,angle_direct10,angle_direct11];
        
    elseif(subject_choice == 4)
        x1 = LastpX;
        y1 = LastpY;
        
        x2 = x1 - 1;
        % --------- stage 6: Sub1 walks away from table -------- %
        path6x = x1:-0.1:x2;
        path6y = y1*ones(size(path6x));
        angle_direct6 = 180*ones(size(path6x));
        path6x = [path6x;ones(size(path6y))]; %%<-------- swing angle check !!!
        % --------- stage 7: Sub1 is away from the chair now -------- %
        path7y = y1:0.1:18.5;
        path7x = x2*ones(size(path7y));
        angle_direct7 = 90*ones(size(path7x));        
        path7x = [path7x;ones(size(path7x))]; %%<-------- swing angle check !!!
        % --------- stage 8: Sub1 moves near to exit -------- %
        path8x = x2:-0.1:2;
        path8y = 18.5*ones(size(path8x));
        angle_direct8 = 180*ones(size(path8x));        
        path8x = [path8x;ones(size(path8x))]; %%<-------- swing angle check !!!
        % --------- stage  -------- %
        
        % --------- stage 10: Sub1 moves straight home -------- %
        path10y = 18.5:-0.1:1;
        path10x = 2*ones(size(path10y));
        angle_direct10 = -90*ones(size(path10x));        
        path10x = [path10x;ones(size(path10x))]; %%<-------- swing angle check !!!
        % --------- stage 11:  -------- %
        path11x = 2:0.1:3;
        path11y = 1*ones(size(path11x));
        angle_direct11 = 0*ones(size(path11x));        
        path11x = [path11x;ones(size(path11x))]; %%<-------- swing angle check !!!        
        
        pX = [path6x,path7x,path8x,path10x,path11x];
        pY = [path6y,path7y,path8y,path10y,path11y];
        angle_direct = [angle_direct6,angle_direct7,angle_direct8,angle_direct10,angle_direct11];
        
        
    elseif(subject_choice == 5)
    end
elseif(Scenario_choice == 2)
    if(subject_choice == 1)
        x1 = LastpX;
        y1 = LastpY;
        
        x2 = x1 - 1;
        % --------- stage 6: Sub1 walks away from table -------- %
        path6x = x1:-0.1:x2;
        path6y = y1*ones(size(path6x));
        angle_direct6 = 180*ones(size(path6x));
        path6x = [path6x;ones(size(path6y))]; %%<-------- swing angle check !!!
        % --------- stage 7: Sub1 is away from the chair now -------- %
        path7y = y1:0.1:18;
        path7x = x2*ones(size(path7y));
        angle_direct7 = 90*ones(size(path7x));        
        path7x = [path7x;ones(size(path7x))]; %%<-------- swing angle check !!!
        % --------- stage 8: Sub1 moves near to exit -------- %
        path8x = x2:-0.1:2;
        path8y = 18*ones(size(path8x));
        angle_direct8 = 180*ones(size(path8x));        
        path8x = [path8x;ones(size(path8x))]; %%<-------- swing angle check !!!
        % --------- stage  -------- %
        
        % --------- stage 10: Sub1 moves straight home -------- %
        path10y = 18:-0.1:2;
        path10x = 2*ones(size(path10y));
        angle_direct10 = -90*ones(size(path10x));        
        path10x = [path10x;ones(size(path10x))]; %%<-------- swing angle check !!!
        % --------- stage 11:  -------- %
        path11x = 2:0.1:17;
        path11y = 2*ones(size(path11x));
        angle_direct11 = 0*ones(size(path11x));        
        path11x = [path11x;ones(size(path11x))]; %%<-------- swing angle check !!!
        % --------- stage 12: -------- %
        path12y = 2:0.1:10;
        path12x = 18*ones(size(path12y));
        angle_direct12 = 90*ones(size(path12x));        
        path12x = [path12x;ones(size(path12x))]; %%<-------- swing angle check !!!
        
        pX = [path6x,path7x,path8x,path10x,path11x,path12x];
        pY = [path6y,path7y,path8y,path10y,path11y,path12y];
        angle_direct = [angle_direct6,angle_direct7,angle_direct8,angle_direct10,angle_direct11,angle_direct12];        
        
    elseif(subject_choice == 2)
        x1 = LastpX;
        y1 = LastpY;
        
        x2 = x1 - 1;
        % --------- stage 6: Sub1 walks away from table -------- %
        path6x = x1:-0.1:x2;
        path6y = y1*ones(size(path6x));
        angle_direct6 = 180*ones(size(path6x));
        path6x = [path6x;ones(size(path6y))]; %%<-------- swing angle check !!!
        % --------- stage 7: Sub1 is away from the chair now -------- %
        path7y = y1:0.1:16.5;
        path7x = x2*ones(size(path7y));
        angle_direct7 = 90*ones(size(path7x));        
        path7x = [path7x;ones(size(path7x))]; %%<-------- swing angle check !!!
        % --------- stage 8: Sub1 moves near to exit -------- %
        path8x = x2:-0.1:2;
        path8y = 16.5*ones(size(path8x));
        angle_direct8 = 180*ones(size(path8x));        
        path8x = [path8x;ones(size(path8x))]; %%<-------- swing angle check !!!
        % --------- stage  -------- %
        
        % --------- stage 10: Sub1 moves straight home -------- %
        path10y = 16.5:-0.1:2;
        path10x = 2*ones(size(path10y));
        angle_direct10 = -90*ones(size(path10x));        
        path10x = [path10x;ones(size(path10x))]; %%<-------- swing angle check !!!
        % --------- stage 11:  -------- %
        path11x = 2:0.1:19;
        path11y = 2*ones(size(path11x));
        angle_direct11 = 0*ones(size(path11x));        
        path11x = [path11x;ones(size(path11x))]; %%<-------- swing angle check !!!        
        
        pX = [path6x,path7x,path8x,path10x,path11x];
        pY = [path6y,path7y,path8y,path10y,path11y];
        angle_direct = [angle_direct6,angle_direct7,angle_direct8,angle_direct10,angle_direct11];
    elseif(subject_choice == 3)
        x1 = LastpX;
        y1 = LastpY;
        
        x2 = x1 - 1;
        % --------- stage 6: Sub1 walks away from table -------- %
        path6x = x1:-0.1:x2;
        path6y = y1*ones(size(path6x));
        angle_direct6 = 180*ones(size(path6x));
        path6x = [path6x;ones(size(path6y))]; %%<-------- swing angle check !!!
        % --------- stage 7: Sub1 is away from the chair now -------- %
        path7y = y1:0.1:16.5;
        path7x = x2*ones(size(path7y));
        angle_direct7 = 90*ones(size(path7x));        
        path7x = [path7x;ones(size(path7x))]; %%<-------- swing angle check !!!
        % --------- stage 8: Sub1 moves near to exit -------- %
        path8x = x2:-0.1:2;
        path8y = 16.5*ones(size(path8x));
        angle_direct8 = 180*ones(size(path8x));        
        path8x = [path8x;ones(size(path8x))]; %%<-------- swing angle check !!!
        % --------- stage  -------- %
        
        % --------- stage 10: Sub1 moves straight home -------- %
        path10y = 16.5:-0.1:1;
        path10x = 2*ones(size(path10y));
        angle_direct10 = -90*ones(size(path10x));        
        path10x = [path10x;ones(size(path10x))]; %%<-------- swing angle check !!!
        % --------- stage 11:  -------- %
        path11x = 2:0.1:10;
        path11y = 1*ones(size(path11x));
        angle_direct11 = 0*ones(size(path11x));        
        path11x = [path11x;ones(size(path11x))]; %%<-------- swing angle check !!!        
        
        pX = [path6x,path7x,path8x,path10x,path11x];
        pY = [path6y,path7y,path8y,path10y,path11y];
        angle_direct = [angle_direct6,angle_direct7,angle_direct8,angle_direct10,angle_direct11];
    elseif(subject_choice == 4) 
        x1 = LastpX;
        y1 = LastpY;
        
        x2 = x1 - 1;
        % --------- stage 6: Sub1 walks away from table -------- %
        path6x = x1:-0.1:x2;
        path6y = y1*ones(size(path6x));
        angle_direct6 = 180*ones(size(path6x));
        path6x = [path6x;ones(size(path6y))]; %%<-------- swing angle check !!!
        % --------- stage 7: Sub1 is away from the chair now -------- %
        path7y = y1:0.1:16.5;
        path7x = x2*ones(size(path7y));
        angle_direct7 = 90*ones(size(path7x));        
        path7x = [path7x;ones(size(path7x))]; %%<-------- swing angle check !!!
        % --------- stage 8: Sub1 moves near to exit -------- %
        path8x = x2:-0.1:2;
        path8y = 16.5*ones(size(path8x));
        angle_direct8 = 180*ones(size(path8x));        
        path8x = [path8x;ones(size(path8x))]; %%<-------- swing angle check !!!
        % --------- stage  -------- %
        
        % --------- stage 10: Sub1 moves straight home -------- %
        path10y = 16.5:-0.1:0.5;
        path10x = 2*ones(size(path10y));
        angle_direct10 = -90*ones(size(path10x));        
        path10x = [path10x;ones(size(path10x))]; %%<-------- swing angle check !!!
        % --------- stage 11:  -------- %
        path11x = 2:0.1:6;path11x = [path11x,path11x(1,end)];
        path11y = 0.5*ones(size(path11x));path11y = [path11y,path11y(1,end)];
        angle_direct11 = 0*ones(size(path11x));angle_direct11 = [angle_direct11,-90];
        path11x = [path11x;ones(size(path11x))]; %%<-------- swing angle check !!!        
        
        pX = [path6x,path7x,path8x,path10x,path11x];
        pY = [path6y,path7y,path8y,path10y,path11y];
        angle_direct = [angle_direct6,angle_direct7,angle_direct8,angle_direct10,angle_direct11];
        
    elseif(subject_choice == 5)
    end
elseif(Scenario_choice == 3)
    if(subject_choice == 1)
        
    elseif(subject_choice == 2)
        % --------- stage 6 -------- %
        
    elseif(subject_choice == 3)
        
    elseif(subject_choice == 4)
        
    elseif(subject_choice == 5)
    
    end
    
    
end











end







