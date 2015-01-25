function[VtsVT] = fRemove_Unwanted_BC(VtsVT,PtsVT,MinTime)
% This code Removes the unwanted Breath Cycles from the VT signal
% VtsVT = Tidal Volume Valleys = [time amplitude]
% PtsVT = Tidal Volume Peaks = [time amplitude]
% Date : 22 July 2013


L11 = (length(VtsVT)) - 1


i = 1;
while(i <= L11)
    T1 = VtsVT(i,1);               % Get the time duration between two consecutive valleys
    T2 = VtsVT(i+1,1);             % Delete one of the valleys
    if(T2 - T1 <= MinTime)         %(T2 - T1 <= 1.0)  ; MinTime = 1.0 sec
        if(VtsVT(i,1) < VtsVT(i+1,1)) % Delete the valley which has the lowest value
            VtsVT(i+1,:) = [];
            L11 = L11 - 1; 
        else
            VtsVT(i,:) = [];
            L11 = L11 - 1;
        end
    else
    end
    i = i + 1;
end

L11    

L11 = (length(VtsVT)) - 1
i = 1;
while(i <= L11)
    T1 = VtsVT(i,1);                  % Get the time duration between two consecutive valleys
    T2 = VtsVT(i+1,1);                % Check if there is a peak present in-between them
    indtemp = find(T1 <= PtsVT(:,1) & PtsVT(:,1) <= T2);
    if(isempty(indtemp))
        if(VtsVT(i,1) < VtsVT(i+1,1)) % Delete the valley which has the lowest value
            VtsVT(i+1,:) = [];
            L11 = L11 - 1; 
        else
            VtsVT(i,:) = [];
            L11 = L11 - 1;
        end
    else
    end
    i = i + 1;
end




end




