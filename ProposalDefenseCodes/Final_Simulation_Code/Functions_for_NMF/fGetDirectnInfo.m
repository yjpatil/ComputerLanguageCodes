function [Direction] = fGetDirectnInfo(Location);
% This function gives the Direction information based on the information
% in the location matrix
% Direction = [North(1), North-East(2), East(3), South-East(4), South(5), South-West(6),
% West(7), North-West(8)] ....... Clockwise
Direction = [0,0,0,0,0,0,0,0];
East = 0;SEast = 0;
North = 0;NEast = 0;
West = 0;NWest = 0;
South = 0;SWest = 0;
Tracker = 0; % Tracker is variable that keeps track of the previous Direction index #

for i = 2 : 1 : length(Location)
    prev_code = Location(i-1);
    new_code = Location(i);
    
    switch prev_code
        case 1
            if(prev_code == 1 && new_code == 2)
                East = East + 1;
                Direction(3) = Direction(3)+1;
                Tracker = 3; % Tracker tells that the person is currently heading East i.e. Direction(3)
            elseif(prev_code == 1 && new_code == 5)
                South = South + 1;
                Direction(5) = Direction(5)+1;
                Tracker = 5;
            elseif(prev_code == 1 && new_code == 6)
                SEast = SEast + 1;
                Direction(4) = Direction(4)+1;
                Tracker = 4;
            elseif(prev_code == 1 && new_code == 1 && Tracker > 0)
                Direction(Tracker) = Direction(Tracker)+1;
            end
        case 2
            if(prev_code == 2 && new_code == 3)
                East = East + 1;
                Direction(3) = Direction(3)+1;
                Tracker = 3;
            elseif(prev_code == 2 && new_code == 7)
                SEast = SEast + 1;
                Direction(4) = Direction(4)+1;
                Tracker = 4;
            elseif(prev_code == 2 && new_code == 6)
                South = South + 1;
                Direction(5) = Direction(5)+1;
                Tracker = 5;
            elseif(prev_code == 2 && new_code == 5)
                SWest = SWest + 1;
                Direction(6) = Direction(6)+1;
                Tracker = 6;
            elseif(prev_code == 2 && new_code == 1)
                West = West + 1;
                Direction(7) = Direction(7)+1;
                Tracker = 7;
            elseif(prev_code == 2 && new_code == 2 && Tracker > 0)
                Direction(Tracker) = Direction(Tracker)+1;
            end
        case 3
            if(prev_code == 3 && new_code == 4)
                East = East + 1;
                Direction(3) = Direction(3)+1;
                Tracker = 3;
            elseif(prev_code == 3 && new_code == 8)
                SEast = SEast + 1;
                Direction(4) = Direction(4)+1;
                Tracker = 4;
            elseif(prev_code == 3 && new_code == 7)
                South = South + 1;
                Direction(5) = Direction(5)+1;
                Tracker = 5;
            elseif(prev_code == 3 && new_code == 6)
                SWest = SWest + 1;
                Direction(6) = Direction(6)+1;
                Tracker = 6;
            elseif(prev_code == 3 && new_code == 2)
                West = West + 1;
                Direction(7) = Direction(7)+1;
                Tracker = 7;
            elseif(prev_code == 3 && new_code == 3 && Tracker > 0)
                Direction(Tracker) = Direction(Tracker)+1;
            end
        case 4
            if(prev_code == 4 && new_code == 8)
                South = South + 1;
                Direction(5) = Direction(5)+1;
                Tracker = 5;
            elseif(prev_code == 4 && new_code == 7)
                SWest = SWest + 1;
                Direction(6) = Direction(6)+1;
                Tracker = 6;
            elseif(prev_code == 4 && new_code == 3)
                West = West + 1;
                Direction(7) = Direction(7)+1;
                Tracker = 7;
            elseif(prev_code == 4 && new_code == 4 && Tracker > 0)
                Direction(Tracker) = Direction(Tracker)+1;
            end
        case 5
            if(prev_code == 5 && new_code == 1)
                North = North + 1;
                Direction(1) = Direction(1)+1;
                Tracker = 1;
            elseif(prev_code == 5 && new_code == 2)
                NEast = NEast + 1;
                Direction(2) = Direction(2)+1;
                Tracker = 2;
            elseif(prev_code == 5 && new_code == 6)
                East = East + 1;
                Direction(3) = Direction(3)+1;
                Tracker = 3;
            elseif(prev_code == 5 && new_code == 10)
                SEast = SEast + 1;
                Direction(4) = Direction(4)+1;
                Tracker = 4;
            elseif(prev_code == 5 && new_code == 9)
                South = South + 1;
                Direction(5) = Direction(5)+1;
                Tracker = 5;
            elseif(prev_code == 5 && new_code == 5 && Tracker > 0)
                Direction(Tracker) = Direction(Tracker)+1;
            end
        case 6
            if(prev_code == 6 && new_code == 2)
                North = North + 1;
                Direction(1) = Direction(1)+1;
                Tracker = 1;
            elseif(prev_code == 6 && new_code == 3)
                NEast = NEast + 1;
                Direction(2) = Direction(2)+1;
                Tracker = 2;
            elseif(prev_code == 6 && new_code == 7)
                East = East + 1;
                Direction(3) = Direction(3)+1;
                Tracker = 3;
            elseif(prev_code == 6 && new_code == 11)
                SEast = SEast + 1;
                Direction(4) = Direction(4)+1;
                Tracker = 4;
            elseif(prev_code == 6 && new_code == 10)
                South = South + 1;
                Direction(5) = Direction(5)+1;
                Tracker = 5;
            elseif(prev_code == 6 && new_code == 9)
                SWest = SWest + 1;
                Direction(6) = Direction(6)+1;
                Tracker = 6;
            elseif(prev_code == 6 && new_code == 5)
                West = West + 1;
                Direction(7) = Direction(7)+1;
                Tracker = 7;
            elseif(prev_code == 6 && new_code == 1)
                NWest = NWest + 1;
                Direction(8) = Direction(8)+1;
                Tracker = 8;
            elseif(prev_code == 6 && new_code == 6 && Tracker > 0)
                Direction(Tracker) = Direction(Tracker)+1;
            end
        case 7
            if(prev_code == 7 && new_code == 3)
                North = North + 1;
                Direction(1) = Direction(1)+1;
                Tracker = 1;
            elseif(prev_code == 7 && new_code == 4)
                NEast = NEast + 1;
                Direction(2) = Direction(2)+1;
                Tracker = 2;
            elseif(prev_code == 7 && new_code == 8)
                East = East + 1;
                Direction(3) = Direction(3)+1;
                Tracker = 3;
            elseif(prev_code == 7 && new_code == 12)
                SEast = SEast + 1;
                Direction(4) = Direction(4)+1;
                Tracker = 4;
            elseif(prev_code == 7 && new_code == 11)
                South = South + 1;
                Direction(5) = Direction(5)+1;
                Tracker = 5;
            elseif(prev_code == 7 && new_code == 10)
                SWest = SWest + 1;
                Direction(6) = Direction(6)+1;
                Tracker = 6;
            elseif(prev_code == 7 && new_code == 6)
                West = West + 1;
                Direction(7) = Direction(7)+1;
                Tracker = 7;
            elseif(prev_code == 7 && new_code == 2)
                NWest = NWest + 1;
                Direction(8) = Direction(8)+1;
                Tracker = 8;
            elseif(prev_code == 7 && new_code == 7 && Tracker > 0)
                Direction(Tracker) = Direction(Tracker)+1;
            end
        case 8
            if(prev_code == 8 && new_code == 4)
                North = North + 1;
                Direction(1) = Direction(1)+1;
                Tracker = 1;
            elseif(prev_code == 8 && new_code == 12)
                South = South + 1;
                Direction(5) = Direction(5)+1;
                Tracker = 5;
            elseif(prev_code == 8 && new_code == 11)
                SWest = SWest + 1;
                Direction(6) = Direction(6)+1;
                Tracker = 6;
            elseif(prev_code == 8 && new_code == 7)
                West = West + 1;
                Direction(7) = Direction(7)+1;
                Tracker = 7;
            elseif(prev_code == 8 && new_code == 3)
                NWest = NWest + 1;
                Direction(8) = Direction(8)+1;
                Tracker = 8;
            elseif(prev_code == 8 && new_code == 8 && Tracker > 0)
                Direction(Tracker) = Direction(Tracker)+1;
            end
        case 9
            if(prev_code == 9 && new_code == 5)
                North = North + 1;
                Direction(1) = Direction(1)+1;
                Tracker = 1;
            elseif(prev_code == 9 && new_code == 6)
                NEast = NEast + 1;
                Direction(2) = Direction(2)+1;
                Tracker = 2;
            elseif(prev_code == 9 && new_code == 10)
                East = East + 1;
                Direction(3) = Direction(3)+1;
                Tracker = 3;
            elseif(prev_code == 9 && new_code == 14)
                SEast = SEast + 1;
                Direction(4) = Direction(4)+1;
                Tracker = 4;
            elseif(prev_code == 9 && new_code == 13)
                South = South + 1;
                Direction(5) = Direction(5)+1;
                Tracker = 5;
            elseif(prev_code == 9 && new_code == 9 && Tracker > 0)
                Direction(Tracker) = Direction(Tracker)+1;
            end
        case 10
            if(prev_code == 10 && new_code == 6)
                North = North + 1;
                Direction(1) = Direction(1)+1;
                Tracker = 1;
            elseif(prev_code == 10 && new_code == 7)
                NEast = NEast + 1;
                Direction(2) = Direction(2)+1;
                Tracker = 2;
            elseif(prev_code == 10 && new_code == 11)
                East = East + 1;
                Direction(3) = Direction(3)+1;
                Tracker = 3;
            elseif(prev_code == 10 && new_code == 15)
                SEast = SEast + 1;
                Direction(4) = Direction(4)+1;
                Tracker = 4;
            elseif(prev_code == 10 && new_code == 14)
                South = South + 1;
                Direction(5) = Direction(5)+1;
                Tracker = 5;
            elseif(prev_code == 10 && new_code == 13)
                SWest = SWest + 1;
                Direction(6) = Direction(6)+1;
                Tracker = 6;
            elseif(prev_code == 10 && new_code == 9)
                West = West + 1;
                Direction(7) = Direction(7)+1;
                Tracker = 7;
            elseif(prev_code == 10 && new_code == 5)
                NWest = NWest + 1;
                Direction(8) = Direction(8)+1;
                Tracker = 8;
            elseif(prev_code == 10 && new_code == 10 && Tracker > 0)
                Direction(Tracker) = Direction(Tracker)+1;
            end
        case 11
            if(prev_code == 11 && new_code == 7)
                North = North + 1;
                Direction(1) = Direction(1)+1;
                Tracker = 1;
            elseif(prev_code == 11 && new_code == 8)
                NEast = NEast + 1;
                Direction(2) = Direction(2)+1;
                Tracker = 2;
            elseif(prev_code == 11 && new_code == 12)
                East = East + 1;
                Direction(3) = Direction(3)+1;
                Tracker = 3;
            elseif(prev_code == 11 && new_code == 16)
                SEast = SEast + 1;
                Direction(4) = Direction(4)+1;
                Tracker = 4;
            elseif(prev_code == 11 && new_code == 15)
                South = South + 1;
                Direction(5) = Direction(5)+1;
                Tracker = 5;
            elseif(prev_code == 11 && new_code == 14)
                SWest = SWest + 1;
                Direction(6) = Direction(6)+1;
                Tracker = 6;
            elseif(prev_code == 11 && new_code == 10)
                West = West + 1;
                Direction(7) = Direction(7)+1;
                Tracker = 7;
            elseif(prev_code == 11 && new_code == 6)
                NWest = NWest + 1;
                Direction(8) = Direction(8)+1;
                Tracker = 8;
            elseif(prev_code == 11 && new_code == 11 && Tracker > 0)
                Direction(Tracker) = Direction(Tracker)+1;
            end
        case 12
            if(prev_code == 12 && new_code == 8)
                North = North + 1;
                Direction(1) = Direction(1)+1;
                Tracker = 1;
            elseif(prev_code == 12 && new_code == 16)
                South = South + 1;
                Direction(5) = Direction(5)+1;
                Tracker = 5;
            elseif(prev_code == 12 && new_code == 15)
                SWest = SWest + 1;
                Direction(6) = Direction(6)+1;
                Tracker = 6;
            elseif(prev_code == 12 && new_code == 11)
                West = West + 1;
                Direction(7) = Direction(7)+1;
                Tracker = 7;
            elseif(prev_code == 12 && new_code == 7)
                NWest = NWest + 1;
                Direction(8) = Direction(8)+1;
                Tracker = 8;
            elseif(prev_code == 12 && new_code == 12 && Tracker > 0)
                Direction(Tracker) = Direction(Tracker)+1;
            end
        case 13
            if(prev_code == 13 && new_code == 9)
                North = North + 1;
                Direction(1) = Direction(1)+1;
                Tracker = 1;
            elseif(prev_code == 13 && new_code == 10)
                NEast = NEast + 1;
                Direction(2) = Direction(2)+1;
                Tracker = 2;
            elseif(prev_code == 13 && new_code == 14)
                East = East + 1;
                Direction(3) = Direction(3)+1;
                Tracker = 3;
            elseif(prev_code == 13 && new_code == 13 && Tracker > 0)
                Direction(Tracker) = Direction(Tracker)+1;
            end
        case 14
            if(prev_code == 14 && new_code == 10)
                North = North + 1;
                Direction(1) = Direction(1)+1;
                Tracker = 1;
            elseif(prev_code == 14 && new_code == 11)
                NEast = NEast + 1;
                Direction(2) = Direction(2)+1;
                Tracker = 2;
            elseif(prev_code == 14 && new_code == 15)
                East = East + 1;
                Direction(3) = Direction(3)+1;
                Tracker = 3;
            elseif(prev_code == 14 && new_code == 13)
                West = West + 1;
                Direction(7) = Direction(7)+1;
                Tracker = 7;
            elseif(prev_code == 14 && new_code == 9)
                NWest = NWest + 1;
                Direction(8) = Direction(8)+1;
                Tracker = 8;
            elseif(prev_code == 14 && new_code == 14 && Tracker > 0)
                Direction(Tracker) = Direction(Tracker)+1;
            end
        case 15
            if(prev_code == 15 && new_code == 11)
                North = North + 1;
                Direction(1) = Direction(1)+1;
                Tracker = 1;
            elseif(prev_code == 15 && new_code == 12)
                NEast = NEast + 1;
                Direction(2) = Direction(2)+1;
                Tracker = 2;
            elseif(prev_code == 15 && new_code == 16)
                East = East + 1;
                Direction(3) = Direction(3)+1;
                Tracker = 3;
            elseif(prev_code == 15 && new_code == 14)
                West = West + 1;
                Direction(7) = Direction(7)+1;
                Tracker = 7;
            elseif(prev_code == 15 && new_code == 10)
                NWest = NWest + 1;
                Direction(8) = Direction(8)+1;
                Tracker = 8;
            elseif(prev_code == 15 && new_code == 15 && Tracker > 0)
                Direction(Tracker) = Direction(Tracker)+1;
            end
        case 16            
            if(prev_code == 16 && new_code == 12)
                North = North + 1;
                Direction(1) = Direction(1)+1;
                Tracker = 1;
            elseif(prev_code == 16 && new_code == 15)
                West = West + 1;
                Direction(7) = Direction(7)+1;
                Tracker = 7;
            elseif(prev_code == 16 && new_code == 11)
                NWest = NWest + 1;
                Direction(8) = Direction(8)+1;
                Tracker = 8;
            elseif(prev_code == 16 && new_code == 16 && Tracker > 0)
                Direction(Tracker) = Direction(Tracker)+1;
            end
        otherwise
            fprintf('Check the Location Matrix');
    end
    
end

[North,NEast,East,SEast,South,SWest,West,NWest]






end


