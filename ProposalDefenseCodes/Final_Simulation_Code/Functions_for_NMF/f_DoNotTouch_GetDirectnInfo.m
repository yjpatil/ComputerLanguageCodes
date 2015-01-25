function [Direction] = f_DoNotTouch_GetDirectnInfo(Location);
% This function gives the Direction information based on the information
% in the location matrix
% Direction = [North, North-East, East, South-East, South, South-West,
% West, North-West] ....... Clockwise
Direction = [];
East = 0;SEast = 0;
North = 0;NEast = 0;
West = 0;NWest = 0;
South = 0;SWest = 0;

for i = 2 : 1 : length(Location)
    prev_code = Location(i-1);
    new_code = Location(i);
    
    switch prev_code
        case 1
            if(prev_code == 1 && new_code == 2)
                East = East + 1;
            elseif(prev_code == 1 && new_code == 5)
                South = South + 1;
            elseif(prev_code == 1 && new_code == 6)
                SEast = SEast + 1;
            else
            end
        case 2
            if(prev_code == 2 && new_code == 3)
                East = East + 1;
            elseif(prev_code == 2 && new_code == 7)
                SEast = SEast + 1;
            elseif(prev_code == 2 && new_code == 6)
                South = South + 1;
            elseif(prev_code == 2 && new_code == 5)
                SWest = SWest + 1;
            elseif(prev_code == 2 && new_code == 1)
                West = West + 1;
            else
            end
        case 3
            if(prev_code == 3 && new_code == 4)
                East = East + 1;
            elseif(prev_code == 3 && new_code == 8)
                SEast = SEast + 1;
            elseif(prev_code == 3 && new_code == 7)
                South = South + 1;
            elseif(prev_code == 3 && new_code == 6)
                SWest = SWest + 1;
            elseif(prev_code == 3 && new_code == 2)
                West = West + 1;
            else
            end
        case 4
            if(prev_code == 4 && new_code == 8)
                South = South + 1;
            elseif(prev_code == 4 && new_code == 7)
                SWest = SWest + 1;
            elseif(prev_code == 4 && new_code == 3)
                West = West + 1;
            else
            end
        case 5
            if(prev_code == 5 && new_code == 1)
                North = North + 1;
            elseif(prev_code == 5 && new_code == 2)
                NEast = NEast + 1;
            elseif(prev_code == 5 && new_code == 6)
                East = East + 1;
            elseif(prev_code == 5 && new_code == 10)
                SEast = SEast + 1;
            elseif(prev_code == 5 && new_code == 9)
                South = South + 1;
            else
            end
        case 6
            if(prev_code == 6 && new_code == 2)
                North = North + 1;
            elseif(prev_code == 6 && new_code == 3)
                NEast = NEast + 1;
            elseif(prev_code == 6 && new_code == 7)
                East = East + 1;
            elseif(prev_code == 6 && new_code == 11)
                SEast = SEast + 1;
            elseif(prev_code == 6 && new_code == 10)
                South = South + 1;
            elseif(prev_code == 6 && new_code == 9)
                SWest = SWest + 1;
            elseif(prev_code == 6 && new_code == 5)
                West = West + 1;
            elseif(prev_code == 6 && new_code == 1)
                NWest = NWest + 1;
            else
            end
        case 7
            if(prev_code == 7 && new_code == 3)
                North = North + 1;
            elseif(prev_code == 7 && new_code == 4)
                NEast = NEast + 1;
            elseif(prev_code == 7 && new_code == 8)
                East = East + 1;
            elseif(prev_code == 7 && new_code == 12)
                SEast = SEast + 1;
            elseif(prev_code == 7 && new_code == 11)
                South = South + 1;
            elseif(prev_code == 7 && new_code == 10)
                SWest = SWest + 1;
            elseif(prev_code == 7 && new_code == 6)
                West = West + 1;
            elseif(prev_code == 7 && new_code == 2)
                NWest = NWest + 1;
            else
            end
        case 8
            if(prev_code == 8 && new_code == 4)
                North = North + 1;
            elseif(prev_code == 8 && new_code == 12)
                South = South + 1;
            elseif(prev_code == 8 && new_code == 11)
                SWest = SWest + 1;
            elseif(prev_code == 8 && new_code == 7)
                West = West + 1;
            elseif(prev_code == 8 && new_code == 3)
                NWest = NWest + 1;
            else
            end
        case 9
            if(prev_code == 9 && new_code == 5)
                North = North + 1;
            elseif(prev_code == 9 && new_code == 6)
                NEast = NEast + 1;
            elseif(prev_code == 9 && new_code == 10)
                East = East + 1;
            elseif(prev_code == 9 && new_code == 14)
                SEast = SEast + 1;
            elseif(prev_code == 9 && new_code == 13)
                South = South + 1;
            else
            end
        case 10
            if(prev_code == 10 && new_code == 6)
                North = North + 1;
            elseif(prev_code == 10 && new_code == 11)
                NEast = NEast + 1;
            elseif(prev_code == 10 && new_code == 15)
                East = East + 1;
            elseif(prev_code == 10 && new_code == 14)
                SEast = SEast + 1;
            elseif(prev_code == 10 && new_code == 13)
                South = South + 1;
            elseif(prev_code == 10 && new_code == 9)
                SWest = SWest + 1;
            elseif(prev_code == 10 && new_code == 5)
                West = West + 1;
            elseif(prev_code == 10 && new_code == 6)
                NWest = NWest + 1;
            else
            end
        case 11
            if(prev_code == 11 && new_code == 7)
                North = North + 1;
            elseif(prev_code == 11 && new_code == 8)
                NEast = NEast + 1;
            elseif(prev_code == 11 && new_code == 12)
                East = East + 1;
            elseif(prev_code == 11 && new_code == 16)
                SEast = SEast + 1;
            elseif(prev_code == 11 && new_code == 15)
                South = South + 1;
            elseif(prev_code == 11 && new_code == 14)
                SWest = SWest + 1;
            elseif(prev_code == 11 && new_code == 10)
                West = West + 1;
            elseif(prev_code == 11 && new_code == 6)
                NWest = NWest + 1;
            else
            end
        case 12
            if(prev_code == 12 && new_code == 8)
                North = North + 1;
            elseif(prev_code == 12 && new_code == 16)
                South = South + 1;
            elseif(prev_code == 12 && new_code == 15)
                SWest = SWest + 1;
            elseif(prev_code == 12 && new_code == 11)
                West = West + 1;
            elseif(prev_code == 12 && new_code == 7)
                NWest = NWest + 1;
            else
            end
        case 13
            if(prev_code == 13 && new_code == 9)
                North = North + 1;
            elseif(prev_code == 13 && new_code == 10)
                NEast = NEast + 1;
            elseif(prev_code == 13 && new_code == 14)
                East = East + 1;
            else
            end
        case 14
            if(prev_code == 14 && new_code == 10)
                North = North + 1;
            elseif(prev_code == 14 && new_code == 11)
                NEast = NEast + 1;
            elseif(prev_code == 14 && new_code == 15)
                East = East + 1;
            elseif(prev_code == 14 && new_code == 13)
                West = West + 1;
            elseif(prev_code == 14 && new_code == 9)
                NWest = NWest + 1;
            else
            end
        case 15
            if(prev_code == 15 && new_code == 11)
                North = North + 1;
            elseif(prev_code == 15 && new_code == 12)
                NEast = NEast + 1;
            elseif(prev_code == 15 && new_code == 16)
                East = East + 1;
            elseif(prev_code == 15 && new_code == 14)
                West = West + 1;
            elseif(prev_code == 15 && new_code == 10)
                NWest = NWest + 1;
            else
            end
        case 16
            
            if(prev_code == 16 && new_code == 12)
                North = North + 1;
            elseif(prev_code == 16 && new_code == 15)
                West = West + 1;
            elseif(prev_code == 16 && new_code == 11)
                NWest = NWest + 1;
            else
            end
        otherwise
            fprintf('Check the Location Matrix');
    end
    
end

Direction = [North,NEast,East,SEast,South,SWest,West,NWest];






end


