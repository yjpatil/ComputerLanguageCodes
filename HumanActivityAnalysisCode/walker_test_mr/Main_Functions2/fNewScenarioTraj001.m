function [pX,pY,angle_direct] = fNewScenarioTraj001(subject_choice,Scenario_choice)
% This is the function which has different trajectories for different
% subjects based on their scenarios

global Temp4 Temp6 Wait;
% Temp4 = This is total # of points when they break away and the
% start of a scenario     

if(Scenario_choice == 1)
    if(subject_choice == 1)
        % --------- stage 6: Sub1 walks away from 2&3 -------- %
        path6x = 3:0.1:11;
        path6y = 18*ones(size(path6x));
        angle_direct6 = 0*ones(size(path6x));
        path6x = [path6x;ones(size(path6y))]; %%<-------- swing angle check !!!
        % --------- stage 7: Sub1 moves straight near the table -------- %
        path7y = 18:-0.1:11;
        path7x = 11*ones(size(path7y));
        angle_direct7 = -90*ones(size(path7x));        
        path7x = [path7x;ones(size(path7x))]; %%<-------- swing angle check !!!
        % --------- stage 8: Sub1 moves straight to the table -------- %
        path8x = 11:-0.1:9;
        path8y = 11*ones(size(path8x));
        angle_direct8 = 180*ones(size(path8x));        
        path8x = [path8x;ones(size(path8x))]; %%<-------- swing angle check !!!        
        % --------- stage 9: Meeting in Progress -------- %
        path9x = 9*ones(1,Wait);
        path9y = 11*ones(size(path9x));
        angle_direct9 = 180*ones(size(path9x));        
        path9x = [path9x;zeros(size(path9x))]; %%<-------- swing angle check !!!        
        
        pX = [path6x,path7x,path8x,path9x];
        pY = [path6y,path7y,path8y,path9y];
        angle_direct = [angle_direct6,angle_direct7,angle_direct8,angle_direct9];
    elseif(subject_choice == 2)
        % --------- stage 6 -------- %
        path6x = 2.5:0.1:5;
        path6y = 17*ones(size(path6x));
        angle_direct6 = 0*ones(size(path6x));
        path6x = [path6x;ones(size(path6y))]; %%<-------- swing angle check !!!    
        % --------- stage 7 -------- %        
        path7y = 17:-0.1:13;    
        path7x = 5*ones(size(path7y));
        angle_direct7 = -90*ones(size(path7x));        
        path7x = [path7x;ones(size(path7x))]; %%<-------- swing angle check !!!
        % --------- stage 8: Sub1 moves straight to the table -------- %
        path8x = 5:0.1:6;
        path8y = 13*ones(size(path8x));
        angle_direct8 = 0*ones(size(path8x));        
        path8x = [path8x;ones(size(path8x))]; %%<-------- swing angle check !!!        
        
        % ******** IMPORTANT ******** %
        % ------- Now check the size of size of pY of Sub2 and Sub1(which
        % is greater). Append with extra last position points %%%%%%%%%%
                
        Size2 = length(path6y)+length(path7y)+length(path8y);
        Extra = Temp4 - Size2;
        
        path9x = path8x(1,end)*ones(1,Extra);
        path9y = path8y(1,end)*ones(1,Extra);
        angle_direct9 = 0*ones(size(path9x));
        path9x = [path9x;zeros(size(path9x))]; %%<-------- swing angle check !!!
        
        pX = [path6x,path7x,path8x,path9x];
        pY = [path6y,path7y,path8y,path9y];
        angle_direct = [angle_direct6,angle_direct7,angle_direct8,angle_direct9];
    elseif(subject_choice == 3)
        % --------- stage 6 -------- %
        path6x = 1.5:0.1:11;
        path6y = 18*ones(size(path6x));
        angle_direct6 = 0*ones(size(path6x));
        path6x = [path6x;ones(size(path6y))]; %%<-------- swing angle check !!!
        % --------- stage 7: Sub1 moves straight near the table -------- %
        path7y = 18:-0.1:15;
        path7x = 11*ones(size(path7y));
        angle_direct7 = -90*ones(size(path7x));        
        path7x = [path7x;ones(size(path7x))]; %%<-------- swing angle check !!!
        % --------- stage 8: Sub1 moves straight to the table -------- %
        path8x = 11:-0.1:9;
        path8y = 15*ones(size(path8x));
        angle_direct8 = 180*ones(size(path8x));        
        path8x = [path8x;ones(size(path8x))]; %%<-------- swing angle check !!!
        
        % ******** IMPORTANT ******** %
        % ------- Now check the size of size of pY of Sub2 and Sub1(which
        % is greater). Append with extra last position points %%%%%%%%%%
        
        Size2 = length(path6y)+length(path7y)+length(path8y);
        Extra = Temp4 - Size2;
        
        path9x = path8x(1,end)*ones(1,Extra);
        path9y = path8y(1,end)*ones(1,Extra);
        angle_direct9 = 180*ones(size(path9x));
        path9x = [path9x;zeros(size(path9x))]; %%<-------- swing angle check !!!
        
        pX = [path6x,path7x,path8x,path9x];
        pY = [path6y,path7y,path8y,path9y];
        angle_direct = [angle_direct6,angle_direct7,angle_direct8,angle_direct9];
    elseif(subject_choice == 4)
        % --------- stage 3 -------- %
        path3x = 3.5:0.1:5;
        path3y = 17*ones(size(path3x));
        angle_direct3 = 0*ones(size(path3x));
        path3x = [path3x;ones(size(path3y))]; %%<-------- swing angle check !!!    
        % --------- stage 4 -------- %        
        path4y = 17:-0.1:11.5;    
        path4x = 5*ones(size(path4y));
        angle_direct4 = -90*ones(size(path4x));        
        path4x = [path4x;ones(size(path4x))]; %%<-------- swing angle check !!!
        % --------- stage 5: Sub4 moves straight to the table -------- %
        path5x = 5:0.1:6;
        path5y = 11.5*ones(size(path5x));
        angle_direct5 = 0*ones(size(path5x));        
        path5x = [path5x;ones(size(path5x))]; %%<-------- swing angle check !!!        
        
        % ******** IMPORTANT ******** %
        % ------- Now check the size of size of pY of Sub2 and Sub1(which
        % is greater). Append with extra last position points %%%%%%%%%%
        
        Size4 = length(path3y)+length(path4y)+length(path5y);
        Extra = Temp4 - Size4;
        
        Extra = Temp6 + Extra;
        
        path6x = path5x(1,end)*ones(1,Extra);
        path6y = path5y(1,end)*ones(1,Extra);
        angle_direct6 = 0*ones(size(path6x));
        path6x = [path6x;zeros(size(path6x))]; %%<-------- swing angle check !!!
        
        pX = [path3x,path4x,path5x,path6x];
        pY = [path3y,path4y,path5y,path6y];
        angle_direct = [angle_direct3,angle_direct4,angle_direct5,angle_direct6];
        
    elseif(subject_choice == 5)
    end
elseif(Scenario_choice == 2)
    if(subject_choice == 1)
        % --------- stage 6: Sub1 walks away from 2&3 -------- %
        path6x = 3:0.1:4.5;
        path6y = 18*ones(size(path6x));
        angle_direct6 = 0*ones(size(path6x));
        path6x = [path6x;ones(size(path6y))]; %%<-------- swing angle check !!!
        % --------- stage 7: Sub1 moves to chair to watch TV -------- %
        path7y = 18:-0.1:7.6;
        path7x = 4.5*ones(size(path7y));
        angle_direct7 = -90*ones(size(path7x));        
        path7x = [path7x;ones(size(path7x))]; %%<-------- swing angle check !!!
        % --------- stage 8: Sub1 moves straight to the chair to watch TV -------- %
        path8x = 4.5:0.1:7.6;
        path8y = 7.6*ones(size(path8x));
        angle_direct8 = 0*ones(size(path8x));        
        path8x = [path8x;ones(size(path8x))]; %%<-------- swing angle check !!!        
        % --------- stage 9: Meeting in Progress -------- %
        path9x = 7.6*ones(1,30);
        path9y = 7.6*ones(size(path9x));
        angle_direct9 = 180*ones(size(path9x));        
        path9x = [path9x;zeros(size(path9x))]; %%<-------- swing angle check !!!
        
        pX = [path6x,path7x,path8x,path9x];
        pY = [path6y,path7y,path8y,path9y];
        angle_direct = [angle_direct6,angle_direct7,angle_direct8,angle_direct9];
        
    elseif(subject_choice == 2)
        % --------- stage 6 -------- %
        path6x = 2.5:0.1:5;
        path6y = 17*ones(size(path6x));
        angle_direct6 = 0*ones(size(path6x));
        path6x = [path6x;ones(size(path6y))]; %%<-------- swing angle check !!!    
        % --------- stage 7 -------- %        
        path7y = 17:-0.1:11.3;    
        path7x = 5*ones(size(path7y));
        angle_direct7 = -90*ones(size(path7x));        
        path7x = [path7x;ones(size(path7x))]; %%<-------- swing angle check !!!
        % --------- stage 8: Sub1 moves straight to the table -------- %
        path8x = 5:0.1:7.6;
        path8y = 11.3*ones(size(path8x));
        angle_direct8 = 0*ones(size(path8x));        
        path8x = [path8x;ones(size(path8x))]; %%<-------- swing angle check !!!        
        
        % ******** IMPORTANT ******** %
        % ------- Now check the size of size of pY of Sub2 and Sub1(which
        % is greater). Append with extra last position points %%%%%%%%%%
        
        Size2 = length(path6y)+length(path7y)+length(path8y);
        Extra = Temp4 - Size2;
        
        path9x = path8x(1,end)*ones(1,Extra);
        path9y = path8y(1,end)*ones(1,Extra);
        angle_direct9 = 180*ones(size(path9x));
        path9x = [path9x;zeros(size(path9x))]; %%<-------- swing angle check !!!
        
        pX = [path6x,path7x,path8x,path9x];
        pY = [path6y,path7y,path8y,path9y];
        angle_direct = [angle_direct6,angle_direct7,angle_direct8,angle_direct9];
        
    elseif(subject_choice == 3)
        % --------- stage 6 -------- %
        path6x = 3:0.1:5;
        path6y = 18.5*ones(size(path6x));
        angle_direct6 = 0*ones(size(path6x));
        path6x = [path6x;ones(size(path6y))]; %%<-------- swing angle check !!!
        % --------- stage 7 -------- %        
        path7y = 18.5:-0.1:13;    
        path7x = 5*ones(size(path7y));
        angle_direct7 = -90*ones(size(path7x));        
        path7x = [path7x;ones(size(path7x))]; %%<-------- swing angle check !!!
        % --------- stage 8: Sub1 moves straight to the table -------- %
        path8x = 5:0.1:7.6;
        path8y = 13*ones(size(path8x));
        angle_direct8 = 0*ones(size(path8x));        
        path8x = [path8x;ones(size(path8x))]; %%<-------- swing angle check !!!        
        % ------- Now check the size of size of pY of Sub2 and Sub1(which
        % is greater). Append with extra last position points %%%%%%%%%%
        
        Size2 = length(path6y)+length(path7y)+length(path8y);
        Extra = Temp4 - Size2;
        
        path9x = path8x(1,end)*ones(1,Extra);
        path9y = path8y(1,end)*ones(1,Extra);
        angle_direct9 = 180*ones(size(path9x));
        path9x = [path9x;zeros(size(path9x))]; %%<-------- swing angle check !!!
        
        pX = [path6x,path7x,path8x,path9x];
        pY = [path6y,path7y,path8y,path9y];
        angle_direct = [angle_direct6,angle_direct7,angle_direct8,angle_direct9];
    elseif(subject_choice == 4)
        % --------- stage 3 -------- %
        path3x = 3.5:0.1:5;
        path3y = 17*ones(size(path3x));
        angle_direct3 = 0*ones(size(path3x));
        path3x = [path3x;ones(size(path3y))]; %%<-------- swing angle check !!!    
        % --------- stage 4 -------- %        
        path4y = 17:-0.1:16.3;    
        path4x = 5*ones(size(path4y));
        angle_direct4 = -90*ones(size(path4x));        
        path4x = [path4x;ones(size(path4x))]; %%<-------- swing angle check !!!
        % --------- stage 5: Sub4 moves straight to the table -------- %
        path5x = 5:0.1:7.6;
        path5y = 16.3*ones(size(path5x));
        angle_direct5 = 0*ones(size(path5x));        
        path5x = [path5x;ones(size(path5x))]; %%<-------- swing angle check !!!        
        % ------- Now check the size of size of pY of Sub2 and Sub1(which
        % is greater). Append with extra last position points %%%%%%%%%%
        
        Size4 = length(path3y)+length(path4y)+length(path5y);
        Extra = Temp4 - Size4;
        
        Extra = Temp6 + Extra;
        
        path6x = path5x(1,end)*ones(1,Extra);
        path6y = path5y(1,end)*ones(1,Extra);
        angle_direct6 = 180*ones(size(path6x));
        path6x = [path6x;zeros(size(path6x))]; %%<-------- swing angle check !!!
        
        pX = [path3x,path4x,path5x,path6x];
        pY = [path3y,path4y,path5y,path6y];
        angle_direct = [angle_direct3,angle_direct4,angle_direct5,angle_direct6];
    elseif(subject_choice == 5)
    end
elseif(Scenario_choice == 3)
    if(subject_choice == 1)
        % --------- stage 6: Sub1 walks away from 2&3 -------- %
        path6x = 3:0.1:11;
        path6y = 18*ones(size(path6x));
        angle_direct6 = 0*ones(size(path6x));
        path6x = [path6x;ones(size(path6y))]; %%<-------- swing angle check !!!
        % --------- stage 7: Sub1 moves straight near the table -------- %
        path7y = 18:-0.1:11;
        path7x = 11*ones(size(path7y));
        angle_direct7 = -90*ones(size(path7x));        
        path7x = [path7x;ones(size(path7x))]; %%<-------- swing angle check !!!
        % --------- stage 8: Sub1 moves straight to the table -------- %
        path8x = 11:-0.1:10;
        path8y = 11*ones(size(path8x));
        angle_direct8 = 180*ones(size(path8x));        
        path8x = [path8x;ones(size(path8x))]; %%<-------- swing angle check !!!        
        
        pX = [path6x,path7x,path8x];
        pY = [path6y,path7y,path8y];
        angle_direct = [angle_direct6,angle_direct7,angle_direct8];
    elseif(subject_choice == 2)
        % --------- stage 6 -------- %
        path6x = 2.5:0.1:5;
        path6y = 17*ones(size(path6x));
        angle_direct6 = 0*ones(size(path6x));
        path6x = [path6x;ones(size(path6y))]; %%<-------- swing angle check !!!    
        % --------- stage 7 -------- %        
        path7y = 17:-0.1:13;    
        path7x = 5*ones(size(path7y));
        angle_direct7 = -90*ones(size(path7x));        
        path7x = [path7x;ones(size(path7x))]; %%<-------- swing angle check !!!
        % --------- stage 8: Sub1 moves straight to the table -------- %
        path8x = 5:0.1:6;
        path8y = 13*ones(size(path8x));
        angle_direct8 = 0*ones(size(path8x));        
        path8x = [path8x;ones(size(path8x))]; %%<-------- swing angle check !!!        
        % ------- Now check the size of size of pY of Sub2 and Sub1(which
        % is greater). Append with extra last position points %%%%%%%%%%
        
        Size2 = length(path6y)+length(path7y)+length(path8y);
        Extra = Temp4 - Size2;
        
        path9x = path8x(1,end)*ones(1,Extra);
        path9y = path8y(1,end)*ones(1,Extra);
        angle_direct9 = 0*ones(size(path9x));
        path9x = [path9x;zeros(size(path9x))]; %%<-------- swing angle check !!!
        
        pX = [path6x,path7x,path8x,path9x];
        pY = [path6y,path7y,path8y,path9y];
        angle_direct = [angle_direct6,angle_direct7,angle_direct8,angle_direct9];
    elseif(subject_choice == 3)
        % --------- stage 6 -------- %
        path6x = 1.5:0.1:11;
        path6y = 18*ones(size(path6x));
        angle_direct6 = 0*ones(size(path6x));
        path6x = [path6x;ones(size(path6y))]; %%<-------- swing angle check !!!
        % --------- stage 7: Sub1 moves straight near the table -------- %
        path7y = 18:-0.1:15;
        path7x = 11*ones(size(path7y));
        angle_direct7 = -90*ones(size(path7x));        
        path7x = [path7x;ones(size(path7x))]; %%<-------- swing angle check !!!
        % --------- stage 8: Sub1 moves straight to the table -------- %
        path8x = 11:-0.1:10;
        path8y = 15*ones(size(path8x));
        angle_direct8 = 180*ones(size(path8x));        
        path8x = [path8x;ones(size(path8x))]; %%<-------- swing angle check !!!
        % ------- Now check the size of size of pY of Sub2 and Sub1(which
        % is greater). Append with extra last position points %%%%%%%%%%
        
        Size2 = length(path6y)+length(path7y)+length(path8y);
        Extra = Temp4 - Size2;
        
        path9x = path8x(1,end)*ones(1,Extra);
        path9y = path8y(1,end)*ones(1,Extra);
        angle_direct9 = 180*ones(size(path9x));
        path9x = [path9x;zeros(size(path9x))]; %%<-------- swing angle check !!!
        
        pX = [path6x,path7x,path8x,path9x];
        pY = [path6y,path7y,path8y,path9y];
        angle_direct = [angle_direct6,angle_direct7,angle_direct8,angle_direct9];
    elseif(subject_choice == 4)
        % --------- stage 3 -------- %
        path3x = 3:0.1:5;
        path3y = 17*ones(size(path3x));
        angle_direct3 = 0*ones(size(path3x));
        path3x = [path3x;ones(size(path3y))]; %%<-------- swing angle check !!!    
        % --------- stage 4 -------- %
        path4x = 5:0.1:6.5;
        path4y = 17:-0.1:15;       
        
        for i = 1 : 1 : length(path4x) - 1
            angle_direct4(i) = atan((path4y(i+1) - path4y(i))/(path4x(i+1) - path4x(i)+eps))/pi*180;
        end
        path4x = [path4x;ones(size(path4x))]; %%<-------- swing angle check !!!
        
        pX = [path3x,path4x];
        pY = [path3y,path4y];
        angle_direct = [angle_direct3,angle_direct4];
    elseif(subject_choice == 5)
    
    end
    
    
end











end







