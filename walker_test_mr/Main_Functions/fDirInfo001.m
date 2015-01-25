function [Hist,DirInfo] = fDirInfo001(Location);
% This function gives the Direction information based on the information
% in the location matrix
% Hist = [North,North-East,East,South-East,South,South-West,West,North-West] ....... Clockwise
% DirInfo = [North(1),North-East(2),East(3),South-East(4),South(5),South-West(6),West(7),North-West(8)]

Hist = [];
DirInfo = [];
East = 0;SEast = 0;
North = 0;NEast = 0;
West = 0;NWest = 0;
South = 0;SWest = 0;
Counter = 1;
Direction = 0;

for i = 2 : 1 : length(Location)
    prev_code = Location(i-1);
    new_code = Location(i);
    
    switch prev_code
        case 1
            if(prev_code == 1 && new_code == 2)
                East = East + 1;
                Direction = 3;
            elseif(prev_code == 1 && new_code == 6)
                South = South + 1;
                Direction = 5;
            elseif(prev_code == 1 && new_code == 7)
                SEast = SEast + 1;
                Direction = 4;
            else
            end
        case 2
            if(prev_code == 2 && new_code == 3)
                East = East + 1;
                Direction = 3;
            elseif(prev_code == 2 && new_code == 8)
                SEast = SEast + 1;
                Direction = 4;
            elseif(prev_code == 2 && new_code == 7)
                South = South + 1;
                Direction = 5;
            elseif(prev_code == 2 && new_code == 6)
                SWest = SWest + 1;
                Direction = 6;
            elseif(prev_code == 2 && new_code == 1)
                West = West + 1;
                Direction = 7;
            else
            end
        case 3
            if(prev_code == 3 && new_code == 4)
                East = East + 1;
                Direction = 3;
            elseif(prev_code == 3 && new_code == 9)
                SEast = SEast + 1;
                Direction = 4;
            elseif(prev_code == 3 && new_code == 8)
                South = South + 1;
                Direction = 5;
            elseif(prev_code == 3 && new_code == 7)
                SWest = SWest + 1;
                Direction = 6;
            elseif(prev_code == 3 && new_code == 2)
                West = West + 1;
                Direction = 7;
            else
            end
        case 4
            if(prev_code == 4 && new_code == 5)
                East = East + 1;
                Direction = 3;
            elseif(prev_code == 4 && new_code == 10)
                SEast = SEast + 1;
                Direction = 4;
            elseif(prev_code == 4 && new_code == 9)
                South = South + 1;
                Direction = 5;
            elseif(prev_code == 4 && new_code == 8)
                SWest = SWest + 1;
                Direction = 6;
            elseif(prev_code == 4 && new_code == 3)
                West = West + 1;
                Direction = 7;
            else
            end
        case 5
            if(prev_code == 5 && new_code == 10)
                South = South + 1;
                Direction = 5;
            elseif(prev_code == 5 && new_code == 9)
                SWest = SWest + 1;
                Direction = 6;
            elseif(prev_code == 5 && new_code == 4)
                West = West + 1;
                Direction = 7;
            else
            end
        case 6
            if(prev_code == 6 && new_code == 1)
                North = North + 1;
                Direction = 1;
            elseif(prev_code == 6 && new_code == 2)
                NEast = NEast + 1;
                Direction = 2;
            elseif(prev_code == 6 && new_code == 7)
                East = East + 1;
                Direction = 3;
            elseif(prev_code == 6 && new_code == 12)
                SEast = SEast + 1;
                Direction = 4;
            elseif(prev_code == 6 && new_code == 11)
                South = South + 1;
                Direction = 5;
            else
            end
        case 7
            if(prev_code == 7 && new_code == 2)
                North = North + 1;
                Direction = 1;
            elseif(prev_code == 7 && new_code == 3)
                NEast = NEast + 1;
                Direction = 2;
            elseif(prev_code == 7 && new_code == 8)
                East = East + 1;
                Direction = 3;
            elseif(prev_code == 7 && new_code == 13)
                SEast = SEast + 1;
                Direction = 4;
            elseif(prev_code == 7 && new_code == 12)
                South = South + 1;
                Direction = 5;
            elseif(prev_code == 7 && new_code == 11)
                SWest = SWest + 1;
                Direction = 6;
            elseif(prev_code == 7 && new_code == 6)
                West = West + 1;
                Direction = 7;
            elseif(prev_code == 7 && new_code == 1)
                NWest = NWest + 1;
                Direction = 8;
            else
            end
        case 8
            if(prev_code == 8 && new_code == 3)
                North = North + 1;
                Direction = 1;
            elseif(prev_code == 8 && new_code == 4)
                NEast = NEast + 1;
                Direction = 2;
            elseif(prev_code == 8 && new_code == 9)
                East = East + 1;
                Direction = 3;
            elseif(prev_code == 8 && new_code == 14)
                SEast = SEast + 1;
                Direction = 4;
            elseif(prev_code == 8 && new_code == 13)
                South = South + 1;
                Direction = 5;
            elseif(prev_code == 8 && new_code == 12)
                SWest = SWest + 1;
                Direction = 6;
            elseif(prev_code == 8 && new_code == 7)
                West = West + 1;
                Direction = 7;
            elseif(prev_code == 8 && new_code == 2)
                NWest = NWest + 1;
                Direction = 8;
            else
            end
        case 9
            if(prev_code == 9 && new_code == 4)
                North = North + 1;
                Direction = 1;
            elseif(prev_code == 9 && new_code == 5)
                NEast = NEast + 1;
                Direction = 2;
            elseif(prev_code == 9 && new_code == 10)
                East = East + 1;
                Direction = 3;
            elseif(prev_code == 9 && new_code == 15)
                SEast = SEast + 1;
                Direction = 4;
            elseif(prev_code == 9 && new_code == 14)
                South = South + 1;
                Direction = 5;
            elseif(prev_code == 9 && new_code == 13)
                SWest = SWest + 1;
                Direction = 6;
            elseif(prev_code == 9 && new_code == 8)
                West = West + 1;
                Direction = 7;
            elseif(prev_code == 9 && new_code == 3)
                NWest = NWest + 1;
                Direction = 8;
            else
            end
        case 10
            if(prev_code == 10 && new_code == 5)
                North = North + 1;
                Direction = 1;
            elseif(prev_code == 10 && new_code == 15)
                South = South + 1;
                Direction = 5;
            elseif(prev_code == 10 && new_code == 14)
                SWest = SWest + 1;
                Direction = 6;
            elseif(prev_code == 10 && new_code == 9)
                West = West + 1;
                Direction = 7;
            elseif(prev_code == 10 && new_code == 4)
                NWest = NWest + 1;
                Direction = 8;
            else
            end
        case 11
            if(prev_code == 11 && new_code == 6)
                North = North + 1;
                Direction = 1;
            elseif(prev_code == 11 && new_code == 7)
                NEast = NEast + 1;
                Direction = 2;
            elseif(prev_code == 11 && new_code == 12)
                East = East + 1;
                Direction = 3;
            elseif(prev_code == 1 && new_code == 17)
                SEast = SEast + 1;
                Direction = 4;
            elseif(prev_code == 11 && new_code == 16)
                South = South + 1;
                Direction = 5;
            else
            end
        case 12
            if(prev_code == 12 && new_code == 7)
                North = North + 1;
                Direction = 1;
            elseif(prev_code == 12 && new_code == 8)
                NEast = NEast + 1;
                Direction = 2;
            elseif(prev_code == 12 && new_code == 13)
                East = East + 1;
                Direction = 3;
            elseif(prev_code == 12 && new_code == 18)
                SEast = SEast + 1;
                Direction = 4;
            elseif(prev_code == 12 && new_code == 17)
                South = South + 1;
                Direction = 5;
            elseif(prev_code == 12 && new_code == 16)
                SWest = SWest + 1;
                Direction = 6;
            elseif(prev_code == 12 && new_code == 11)
                West = West + 1;
                Direction = 7;
            elseif(prev_code == 12 && new_code == 6)
                NWest = NWest + 1;
                Direction = 8;
            else
            end 
        case 13
            if(prev_code == 13 && new_code == 8)
                North = North + 1;
                Direction = 1;
            elseif(prev_code == 13 && new_code == 9)
                NEast = NEast + 1;
                Direction = 2;
            elseif(prev_code == 13 && new_code == 14)
                East = East + 1;
                Direction = 3;
            elseif(prev_code == 13 && new_code == 19)
                SEast = SEast + 1;
                Direction = 4;
            elseif(prev_code == 13 && new_code == 18)
                South = South + 1;
                Direction = 5;
            elseif(prev_code == 13 && new_code == 17)
                SWest = SWest + 1;
                Direction = 6;
            elseif(prev_code == 13 && new_code == 12)
                West = West + 1;
                Direction = 7;
            elseif(prev_code == 13 && new_code == 7)
                NWest = NWest + 1;
                Direction = 8;
            else
            end  
        case 14
            if(prev_code == 14 && new_code == 9)
                North = North + 1;
                Direction = 1;
            elseif(prev_code == 14 && new_code == 10)
                NEast = NEast + 1;
                Direction = 2;
            elseif(prev_code == 14 && new_code == 15)
                East = East + 1;
                Direction = 3;
            elseif(prev_code == 14 && new_code == 20)
                SEast = SEast + 1;
                Direction = 4;
            elseif(prev_code == 14 && new_code == 19)
                South = South + 1;
                Direction = 5;
            elseif(prev_code == 14 && new_code == 18)
                SWest = SWest + 1;
                Direction = 6;
            elseif(prev_code == 14 && new_code == 13)
                West = West + 1;
                Direction = 7;
            elseif(prev_code == 14 && new_code == 8)
                NWest = NWest + 1;
                Direction = 8;
            else
            end
        case 15
            if(prev_code == 15 && new_code == 10)
                North = North + 1;
                Direction = 1;
            elseif(prev_code == 15 && new_code == 20)
                South = South + 1;
                Direction = 5;
            elseif(prev_code == 15 && new_code == 19)
                SWest = SWest + 1;
                Direction = 6;
            elseif(prev_code == 15 && new_code == 14)
                West = West + 1;
                Direction = 7;
            elseif(prev_code == 15 && new_code == 9)
                NWest = NWest + 1;
                Direction = 8;
            else
            end
        case 16
            if(prev_code == 16 && new_code == 11)
                North = North + 1;
                Direction = 1;
            elseif(prev_code == 16 && new_code == 12)
                NEast = NEast + 1;
                Direction = 2;
            elseif(prev_code == 16 && new_code == 17)
                East = East + 1;
                Direction = 3;
            elseif(prev_code == 16 && new_code == 22)
                SEast = SEast + 1;
                Direction = 4;
            elseif(prev_code == 16 && new_code == 21)
                South = South + 1;
                Direction = 5;
            else
            end
        case 17
            if(prev_code == 17 && new_code == 12)
                North = North + 1;
                Direction = 1;
            elseif(prev_code == 17 && new_code == 13)
                NEast = NEast + 1;
                Direction = 2;
            elseif(prev_code == 17 && new_code == 18)
                East = East + 1;
                Direction = 3;
            elseif(prev_code == 17 && new_code == 23)
                SEast = SEast + 1;
                Direction = 4;
            elseif(prev_code == 17 && new_code == 22)
                South = South + 1;
                Direction = 5;
            elseif(prev_code == 17 && new_code == 21)
                SWest = SWest + 1;
                Direction = 6;
            elseif(prev_code == 17 && new_code == 16)
                West = West + 1;
                Direction = 7;
            elseif(prev_code == 17 && new_code == 11)
                NWest = NWest + 1;
                Direction = 8;
            else
            end
        case 18
            if(prev_code == 18 && new_code == 13)
                North = North + 1;
                Direction = 1;
            elseif(prev_code == 18 && new_code == 14)
                NEast = NEast + 1;
                Direction = 2;
            elseif(prev_code == 18 && new_code == 19)
                East = East + 1;
                Direction = 3;
            elseif(prev_code == 18 && new_code == 24)
                SEast = SEast + 1;
                Direction = 4;
            elseif(prev_code == 18 && new_code == 23)
                South = South + 1;
                Direction = 5;
            elseif(prev_code == 18 && new_code == 22)
                SWest = SWest + 1;
                Direction = 6;
            elseif(prev_code == 18 && new_code == 17)
                West = West + 1;
                Direction = 7;
            elseif(prev_code == 18 && new_code == 12)
                NWest = NWest + 1;
                Direction = 8;
            else
            end
        case 19
            if(prev_code == 19 && new_code == 14)
                North = North + 1;
                Direction = 1;
            elseif(prev_code == 19 && new_code == 15)
                NEast = NEast + 1;
                Direction = 2;
            elseif(prev_code == 19 && new_code == 20)
                East = East + 1;
                Direction = 3;
            elseif(prev_code == 19 && new_code == 25)
                SEast = SEast + 1;
                Direction = 4;
            elseif(prev_code == 19 && new_code == 24)
                South = South + 1;
                Direction = 5;
            elseif(prev_code == 19 && new_code == 23)
                SWest = SWest + 1;
                Direction = 6;
            elseif(prev_code == 19 && new_code == 18)
                West = West + 1;
                Direction = 7;
            elseif(prev_code == 19 && new_code == 13)
                NWest = NWest + 1;
                Direction = 8;
            else
            end
        case 20
            if(prev_code == 20 && new_code == 15)
                North = North + 1;
                Direction = 1;
            elseif(prev_code == 20 && new_code == 25)
                South = South + 1;
                Direction = 5;
            elseif(prev_code == 20 && new_code == 24)
                SWest = SWest + 1;
                Direction = 6;
            elseif(prev_code == 20 && new_code == 19)
                West = West + 1;
                Direction = 7;
            elseif(prev_code == 20 && new_code == 14)
                NWest = NWest + 1;
                Direction = 8;
            else
            end 
        case 21
            if(prev_code == 21 && new_code == 16)
                North = North + 1;
                Direction = 1;
            elseif(prev_code == 21 && new_code == 17)
                NEast = NEast + 1;
                Direction = 2;
            elseif(prev_code == 21 && new_code == 22)
                East = East + 1;
                Direction = 3;
            else
            end
        case 22
            if(prev_code == 22 && new_code == 17)
                North = North + 1;
                Direction = 1;
            elseif(prev_code == 22 && new_code == 18)
                NEast = NEast + 1;
                Direction = 2;
            elseif(prev_code == 22 && new_code == 23)
                East = East + 1;
                Direction = 3;
            elseif(prev_code == 22 && new_code == 21)
                West = West + 1;
                Direction = 7;
            elseif(prev_code == 22 && new_code == 16)
                NWest = NWest + 1;
                Direction = 8;
            else
            end
        case 23
            if(prev_code == 23 && new_code == 18)
                North = North + 1;
                Direction = 1;
            elseif(prev_code == 23 && new_code == 19)
                NEast = NEast + 1;
                Direction = 2;
            elseif(prev_code == 23 && new_code == 24)
                East = East + 1;
                Direction = 3;
            elseif(prev_code == 23 && new_code == 22)
                West = West + 1;
                Direction = 7;
            elseif(prev_code == 23 && new_code == 17)
                NWest = NWest + 1;
                Direction = 8;
            else
            end
        case 24
            if(prev_code == 24 && new_code == 19)
                North = North + 1;
                Direction = 1;
            elseif(prev_code == 24 && new_code == 20)
                NEast = NEast + 1;
                Direction = 2;
            elseif(prev_code == 24 && new_code == 25)
                East = East + 1;
                Direction = 3;
            elseif(prev_code == 24 && new_code == 23)
                West = West + 1;
                Direction = 7;
            elseif(prev_code == 24 && new_code == 18)
                NWest = NWest + 1;
                Direction = 8;
            else
            end
        case 25
            if(prev_code == 25 && new_code == 20)
                North = North + 1;
                Direction = 1;
            elseif(prev_code == 25 && new_code == 24)
                West = West + 1;
                Direction = 7;
            elseif(prev_code == 25 && new_code == 19)
                NWest = NWest + 1;
                Direction = 8;
            else
            end
        otherwise
            fprintf('Check the Location Matrix');
    end
    DirInfo(1,Counter) = Direction;
    Counter = Counter + 1;
    
end

Hist = [North,NEast,East,SEast,South,SWest,West,NWest];






end


