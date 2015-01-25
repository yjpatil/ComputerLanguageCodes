
% *******  Clearing all Parameters ************%
%clear('EtsPs','SEtsPS','PtsAS','PtsVT');
clear('ps14','ps141','ps142','ind14','s14','l14','mean14');
clear('ind6','');

%******* Parameter 6 and others *******%
if(err6 == 0) %% the "end" and "else" for this "if" is in FFE_EXT_Part2
    
else
    S(I).h(6,hamp(ha)) = 0; % amplitude %
    S(I).h(6,hamp(ha) + 1) = SEtsPS(H,1);   % Start Time %
    S(I).h(6,hamp(ha) + 2) = SEtsPS(H,2);   % End Time %
    S(I).h(6,hamp(ha) + 3) = err6;   % Error %
    
    %**********  PARA # 05  ***************%
    ind51 = find(EtsPS(H) <= LpVT & LpVT <= EtsPS(H) + 25,1);
    err51 = isempty(ind51);
    if(err51 == 0)
        S(I).h(5,hamp(ha)) = PtsVT(ind51,2); % amplitude %
        S(I).h(5,hamp(ha) + 1) = SEtsPS(H,1);   % Start Time %
        S(I).h(5,hamp(ha) + 2) = PtsVT(ind51,1);   % End Time %
        S(I).h(5,hamp(ha) + 3) = err5;   % Error %
        else
            S(I).h(5,hamp(ha)) = 0; % amplitude %
            S(I).h(5,hamp(ha) + 1) = SEtsPS(H,1);   % Start Time %
            S(I).h(5,hamp(ha) + 2) = SEtsPS(H,2);;   % End Time %
            S(I).h(5,hamp(ha) + 3) = err5;   % Error %
    end
    
    %**********  PARA # 11  ***************%
   ind111 = find(EtsPS(H) <= LvVT & LvVT <= EtsPS(H) + 25,1);
    err111 = isempty(ind111);
    if(err111 == 0)
        S(I).h(11,hamp(ha)) = VtsVT(ind111,2); % amplitude %
        S(I).h(11,hamp(ha) + 1) = SEtsPS(H,1);   % Start Time %
        S(I).h(11,hamp(ha) + 2) = VtsVT(ind111,1);   % End Time %
        S(I).h(11,hamp(ha) + 3) = err111;   % Error %
        else
            S(I).h(11,hamp(ha)) = 0; % amplitude %
            S(I).h(11,hamp(ha) + 1) = SEtsPS(H,1);   % Start Time %
            S(I).h(11,hamp(ha) + 2) = SEtsPS(H,2);;   % End Time %
            S(I).h(11,hamp(ha) + 3) = err111;   % Error %
    end
    
    %**********  PARA # 13  ***************%
    ind131 = find(EtsPS(H) <= LvAS & LvAS <= EtsPS(H) + 25,1);
    err131 = isempty(ind131);
    if(err131 == 0)
        S(I).h(13,hamp(ha)) = VtsAS(ind131,2); % amplitude %
        S(I).h(13,hamp(ha) + 1) = SEtsPS(H,1);   % Start Time %
        S(I).h(13,hamp(ha) + 2) = VtsVT(ind131,1);   % End Time %
        S(I).h(13,hamp(ha) + 3) = err131;   % Error %
        else
            S(I).h(13,hamp(ha)) = 0; % amplitude %
            S(I).h(13,hamp(ha) + 1) = SEtsPS(H,1);   % Start Time %
            S(I).h(13,hamp(ha) + 2) = SEtsPS(H,2);   % End Time %
            S(I).h(13,hamp(ha) + 3) = err131;   % Error %
    end
    
    %**********  PARA # 12  ***************%
    ind121 = find(EtsPS(H) <= tsintZVT & tsintZVT <= EtsPS(H) + 25,1);
    err121 = isempty(ind121);
    if(err121 == 0)
        S(I).h(12,hamp(ha)) = tsintZVT(ind121) - S(I).h(11,hamp(ha)+2); % amplitude %
        S(I).h(12,hamp(ha) + 1) = S(I).h(11,hamp(ha)+2);   % Start Time %
        S(I).h(12,hamp(ha) + 2) = tsintZVT(ind121);   % End Time %
        S(I).h(12,hamp(ha) + 3) = err121;   % Error %
        else
            S(I).h(12,hamp(ha)) = 0; % amplitude %
            S(I).h(12,hamp(ha) + 1) = SEtsPS(H,1);   % Start Time %
            S(I).h(12,hamp(ha) + 2) = SEtsPS(H,2);   % End Time %
            S(I).h(12,hamp(ha) + 3) = err121;   % Error %
    end
    
    %**********  PARA # 09  ***************%
    ind9a1 = find(EtsPS(H) <= tsintp10AS & tsintp10AS <= EtsPS(H) + 25,1);
    err9a1 = isempty(ind9a1);
    ind9b1 = find(EtsPS(H) <= tsintm10AS & tsintm10AS <= EtsPS(H) + 25,1);
    err9b1 = isempty(ind9b1);
    if(err9a1 == 0 && err9b1 == 0)
        S(I).h(9,hamp(ha)) = tsintm10AS(ind9b1) - tsintp10AS(ind9a1);
            S(I).h(9,hamp(ha)+ 1) = tsintp10AS(ind9a1);
            S(I).h(9,hamp(ha)+ 2) = tsintm10AS(ind9b1);
            S(I).h(9,hamp(ha)+ 3) = err9a1 + err9b1;
        else
            S(I).h(9,hamp(ha)) = 0;
            S(I).h(9,hamp(ha)+ 1) = SEtsPS(H,1);
            S(I).h(9,hamp(ha)+ 2) = SEtsPS(H,2);
            S(I).h(9,hamp(ha)+ 3) = err9a1 + err9b1;
    end
        
    %**********  PARA # 10  ***************%
    
    ind101 = find(EtsPS(H) <= tsintZAS & tsintZAS <= EtsPS(H)+25,1);
    err101 = isempty(ind101);
    if(err101 == 0)
        S(I).h(10,hamp(ha)) = tsintZAS(ind101) - S(I).h(9,hamp(ha)+2);
        S(I).h(10,hamp(ha)+1) = S(I).h(9,hamp(ha)+2);
        S(I).h(10,hamp(ha)+2) = tsintZAS(ind101);
        S(I).h(10,hamp(ha)+3) = err101;
    else
        S(I).h(10,hamp(ha)) = 0;
        S(I).h(10,hamp(ha)+ 1) = SEtsPS(H,1);
        S(I).h(10,hamp(ha)+ 2) = SEtsPS(H,2);
        S(I).h(10,hamp(ha)+ 3) = err10;
    end
        
    %**********  PARA # 02  ***************%
    S(I).h(2,hamp(ha)) = S(I).h(6,hamp(ha)+2) - SEtsPS(H,1);
    S(I).h(2,hamp(ha)+ 1) = SEtsPS(H,1);
    S(I).h(2,hamp(ha)+ 2) = S(I).h(6,hamp(ha)+2);
    S(I).h(2,hamp(ha)+ 3) = err6;
    
    %**********  PARA # 08  ***************%
    S(I).h(8,hamp(ha)) = S(I).h(9,hamp(ha)+2) - EtsPS(H);
    S(I).h(8,hamp(ha)+ 1) = EtsPS(H);
    S(I).h(8,hamp(ha)+ 2) = S(I).h(9,hamp(ha)+2);
    S(I).h(8,hamp(ha)+ 3) = err9b1;    
    
    %**********  PARA # 03  ***************%
    ind31 = find(SEtsPS(H,1) <= tsintp10AS & tsintp10AS <= S(I).h(6,hamp(ha)+2),1,'last');
    err31 = isempty(ind31);
    if(err31 == 0)
            S(I).h(3,hamp(ha)) = tsintp10AS(ind31) - SEtsPS(H,1);
            S(I).h(3,hamp(ha)+1) = SEtsPS(H,1);
            S(I).h(3,hamp(ha)+2) = tsintp10AS(ind31);
            S(I).h(3,hamp(ha)+3) = err31;
        else
            S(I).h(3,hamp(ha)) = 0;
            S(I).h(3,hamp(ha)+ 1) = SEtsPS(H,1);
            S(I).h(3,hamp(ha)+ 2) = SEtsPS(H,2);
            S(I).h(3,hamp(ha)+ 3) = err31;
    end
    
    %**********  PARA # 07  ***************%
    if(err31 == 0 && err9b1 == 0)
        S(I).h(7,hamp(ha)) = tsintm10AS(ind9b1) - tsintp10AS(ind31);
        S(I).h(7,hamp(ha)+1) = tsintp10AS(ind31);
        S(I).h(7,hamp(ha)+2) = tsintm10AS(ind9b1);
        S(I).h(7,hamp(ha)+3) = err9b1;
    else
        S(I).h(7,hamp(ha)) = 0;
        S(I).h(7,hamp(ha)+1) = SEtsPS(H,1);
        S(I).h(7,hamp(ha)+2) = SEtsPS(H,2);
        S(I).h(7,hamp(ha)+3) = err9b1;
    end
    
    %**********  PARA # 01  ***************%
    ind1a1 = find(SEtsPS(H,1) >= LvAS & LvAS >= SEtsPS(H,1) - 25,1,'last');
    ind1b1 = find(VtsAS(ind1a1) >= tsintZAS & tsintZAS >= VtsAS(ind1a1) - 25,1,'last');
    err1a1 = isempty(ind1a1);
    err1b1 = isempty(ind1b1);
    if(err1a1 == 0 && err1b1 == 0)
        S(I).h(1,hamp(ha)) = SEtsPS(H,1) - tsintZAS(ind1b1);
        S(I).h(1,hamp(ha)+1) = tsintZAS(ind1b1);
        S(I).h(1,hamp(ha)+2) = SEtsPS(H,1);
        S(I).h(1,hamp(ha)+3) = err1b1;
    else
        S(I).h(1,hamp(ha)) = 0;
        S(I).h(1,hamp(ha)+1) = SEtsPS(H,1);
        S(I).h(1,hamp(ha)+2) = SEtsPS(H,2);
        S(I).h(1,hamp(ha)+3) = err1a1+err1b1;
    end
    
end%%err6 ==0 end
    


ind5 = find(S(I).h(6,hamp(ha) + 2) <= LpVT & LpVT <= S(I).h(6,hamp(ha) + 2) + 25,1);
        err5 = isempty(err5);
        if(err5 == 0) %% the "end" and "else" for this "if" is in FFE_EXT_Part2
        S(I).h(5,hamp(ha)) = PtsVT(ind5,2); % amplitude %
        S(I).h(5,hamp(ha) + 1) = SEtsPS(H,1);   % Start Time %
        S(I).h(5,hamp(ha) + 2) = PtsVT(ind5,1);   % End Time %
        S(I).h(5,hamp(ha) + 3) = err5;   % Error %
        else
            S(I).h(5,hamp(ha)) = 0; % amplitude %
            S(I).h(5,hamp(ha) + 1) = SEtsPS(H,1);   % Start Time %
            S(I).h(5,hamp(ha) + 2) = SEtsPS(H,2);   % End Time %
            S(I).h(5,hamp(ha) + 3) = err5;   % Error %
        end
        
        %**********  PARA # 11  ***************%
        ind11 = find(S(I).h(5,hamp(ha) + 2) <= LvVT & LvVT <= S(I).h(5,hamp(ha) + 2) + 25,1);
        err11 = isempty(ind11);
        if(err11 == 0)
            S(I).h(11,hamp(ha)) = VtsVT(ind11,2); % amplitude %
        S(I).h(11,hamp(ha) + 1) = SEtsPS(H,1);   % Start Time %
        S(I).h(11,hamp(ha) + 2) = VtsVT(ind11,1);   % End Time %
        S(I).h(11,hamp(ha) + 3) = err11;   % Error %
        else
            S(I).h(11,hamp(ha)) = 0; % amplitude %
            S(I).h(11,hamp(ha) + 1) = SEtsPS(H,1);   % Start Time %
            S(I).h(11,hamp(ha) + 2) = SEtsPS(H,2);   % End Time %
            S(I).h(11,hamp(ha) + 3) = err11;   % Error %
        end
        
        %**********  PARA # 13  ***************%
        ind13 = find(S(I).h(6,hamp(ha) + 2) <= LvAS & LvAS <= S(I).h(6,hamp(ha) + 2) + 25,1);
        err13 = isempty(ind13);
        if(err13 == 0)
            S(I).h(13,hamp(ha)) = VtsAS(ind13,2); % amplitude %
        S(I).h(13,hamp(ha) + 1) = SEtsPS(H,1);   % Start Time %
        S(I).h(13,hamp(ha) + 2) = VtsVT(ind13,1);   % End Time %
        S(I).h(13,hamp(ha) + 3) = err13;   % Error %
        else
            S(I).h(13,hamp(ha)) = 0; % amplitude %
            S(I).h(13,hamp(ha) + 1) = SEtsPS(H,1);   % Start Time %
            S(I).h(13,hamp(ha) + 2) = SEtsPS(H,2);   % End Time %
            S(I).h(13,hamp(ha) + 3) = err13;   % Error %
        end
        
        %**********  PARA # 12  ***************%
        ind12 = find(S(I).h(11,hamp(ha) + 2) <= tsintZVT & tsintZVT <= S(I).h(11,hamp(ha) + 2) + 25,1);
        err12 = isempty(ind12);
        if(err12 == 0)
           S(I).h(12,hamp(ha)) = tsintZVT(ind12) - S(I).h(11,hamp(ha)+2); % amplitude %
        S(I).h(12,hamp(ha) + 1) = S(I).h(11,hamp(ha)+2);   % Start Time %
        S(I).h(12,hamp(ha) + 2) = tsintZVT(ind12);   % End Time %
        S(I).h(12,hamp(ha) + 3) = err13;   % Error %
        else
            S(I).h(12,hamp(ha)) = 0; % amplitude %
            S(I).h(12,hamp(ha) + 1) = SEtsPS(H,1);   % Start Time %
            S(I).h(12,hamp(ha) + 2) = SEtsPS(H,2);   % End Time %
            S(I).h(12,hamp(ha) + 3) = err12;   % Error %
        end 
        
        %**********  PARA # 09  ***************%
        ind9a = find(S(I).h(6,hamp(ha)+2) <= tsintp10AS & tsintp10AS <= S(I).h(6,hamp(ha)+2) + 25,1);
        err9a = isempty(ind9a);
        ind9b = find(S(I).h(6,hamp(ha)+2) <= tsintm10AS & tsintm10AS <= S(I).h(6,hamp(ha)+2) + 25,1);
        err9b = isempty(ind9b);
        if(err9a == 0 && err9b == 0)
            S(I).h(9,hamp(ha)) = tsintm10AS(ind9b) - tsintp10AS(ind9a);
            S(I).h(9,hamp(ha)+ 1) = tsintp10AS(ind9a);
            S(I).h(9,hamp(ha)+ 2) = tsintm10AS(ind9b);
            S(I).h(9,hamp(ha)+ 3) = err9a + err9b;
        else
            S(I).h(9,hamp(ha)) = 0;
            S(I).h(9,hamp(ha)+ 1) = SEtsPS(H,1);
            S(I).h(9,hamp(ha)+ 2) = SEtsPS(H,2);
            S(I).h(9,hamp(ha)+ 3) = err9a + err9b;
        end
        
        %**********  PARA # 10  ***************%
        ind10 = find(S(I).h(6,hamp(ha)+2) <= tsintZAS & tsintZAS >= S(I).h(9,hamp(ha)+2),1);
        err10 = isempty(ind10);
        if(err10 == 0)
            S(I).h(10,hamp(ha)) = tsintZAS(ind10) - S(I).h(9,hamp(ha)+2);
            S(I).h(10,hamp(ha)+1) = S(I).h(9,hamp(ha)+2);
            S(I).h(10,hamp(ha)+2) = tsintZAS(ind10);
            S(I).h(10,hamp(ha)+3) = err10;
        else
            S(I).h(10,hamp(ha)) = 0;
            S(I).h(10,hamp(ha)+ 1) = SEtsPS(H,1);
            S(I).h(10,hamp(ha)+ 2) = SEtsPS(H,2);
            S(I).h(10,hamp(ha)+ 3) = err10;
        end
        
        %**********  PARA # 02  ***************%
        S(I).h(2,hamp(ha)) = S(I).h(6,hamp(ha)+2) - SEtsPS(H,1);
        S(I).h(2,hamp(ha)+ 1) = SEtsPS(H,1);
        S(I).h(2,hamp(ha)+ 2) = S(I).h(6,hamp(ha)+2);
        S(I).h(2,hamp(ha)+ 3) = 0;
        
        %**********  PARA # 08  ***************%
        S(I).h(8,hamp(ha)) = S(I).h(9,hamp(ha)+2) - EtsPS(H);
        S(I).h(8,hamp(ha)+ 1) = EtsPS(H);
        S(I).h(8,hamp(ha)+ 2) = S(I).h(9,hamp(ha)+2);
        S(I).h(8,hamp(ha)+ 3) = err9b;
        
        %**********  PARA # 03  ***************%
        ind3 = find(SEtsPS(H,1) <= tsintp10AS & tsintp10AS <= S(I).h(6,hamp(ha)+2),1,'last');
        err3 = isempty(ind3);
        if(err3 == 0)
            S(I).h(3,hamp(ha)) = tsintp10AS(ind3) - SEtsPS(H,1);
            S(I).h(3,hamp(ha)+1) = SEtsPS(H,1);
            S(I).h(3,hamp(ha)+2) = tsintp10AS(ind3);
            S(I).h(3,hamp(ha)+3) = err3;
        else
            S(I).h(3,hamp(ha)) = 0;
            S(I).h(3,hamp(ha)+ 1) = SEtsPS(H,1);
            S(I).h(3,hamp(ha)+ 2) = SEtsPS(H,2);
            S(I).h(3,hamp(ha)+ 3) = err3;
        end
        
        %**********  PARA # 07  ***************%
        if(err3 == 0 && err9b == 0)
            S(I).h(7,hamp(ha)) = tsintm10AS(ind9b) - tsintp10AS(ind3);
            S(I).h(7,hamp(ha)+1) = tsintp10AS(ind3);
            S(I).h(7,hamp(ha)+2) = tsintm10AS(ind9b);
            S(I).h(7,hamp(ha)+3) = err9b;
        else
            S(I).h(7,hamp(ha)) = 0;
            S(I).h(7,hamp(ha)+1) = SEtsPS(H,1);
            S(I).h(7,hamp(ha)+2) = SEtsPS(H,2);
            S(I).h(7,hamp(ha)+3) = err9b;
        end
        
        %**********  PARA # 01  ***************%
        ind1a = find(SEtsPS(H,1) >= LvAS & LvAS >= SEtsPS(H,1) - 25,1,'last');
        ind1b = find(VtsAS(ind1a) >= tsintZAS & tsintZAS >= VtsAS(ind1a) - 25,1,'last');
        err1a = isempty(ind1a);
        err1b = isempty(ind1b);
        if(err1a == 0 && err1b == 0)
            S(I).h(1,hamp(ha)) = SEtsPS(H,1) - tsintZAS(ind1b);
            S(I).h(1,hamp(ha)+1) = tsintZAS(ind1b);
            S(I).h(1,hamp(ha)+2) = SEtsPS(H,1);
            S(I).h(1,hamp(ha)+3) = err1b;
        else
            S(I).h(1,hamp(ha)) = 0;
            S(I).h(1,hamp(ha)+1) = SEtsPS(H,1);
            S(I).h(1,hamp(ha)+2) = SEtsPS(H,2);
            S(I).h(1,hamp(ha)+3) = err1a + err1b;
        end

    



