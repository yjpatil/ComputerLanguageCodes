function[Curr_AS_pk_Index,Curr_AS_pk_time,Curr_AS_pk_amp] = Curr_AS_Peak(Label,PtsAS,Score,SEtsPS,H)
% If "Label == 1" HG "H" is a smoking one, else ...
% Now if "Label == 1", then select the current AS peak using the "Score"
% matrix, i.e. Score(:,3 or 4)
% Else "Label == -1", then select the current AS peak using the "SEtsPS(H,2)"
% value as the starting point to find the current peak

if(Label == -1)
    %Start = SEtsPS(H,1);
    End = SEtsPS(H,2);
    Index1 = find( End <= PtsAS(:,1) & PtsAS(:,1) <= End+55, 1 );
    Curr_AS_pk_Index = Index1;
    Curr_AS_pk_time = PtsAS(Index1,1);
    Curr_AS_pk_amp = PtsAS(Index1,2);
elseif(Label == +1)
    Index2 = find(SEtsPS(H,1) - 5 <= Score(:,4) & Score(:,4) <= SEtsPS(H,2) + 5,1);
    if(~isempty(Index2))
        End = Score(Index2,4);
        Index3 = find(End <= PtsAS(:,1) & PtsAS(:,1) <= End+55,1);
        Curr_AS_pk_Index = Index3;
        Curr_AS_pk_time = PtsAS(Index3,1);
        Curr_AS_pk_amp = PtsAS(Index3,2);
    else
        Index4 = find(SEtsPS(H,1) - 6 <= Score(:,3) & Score(:,3) <= SEtsPS(H,2) + 6,1);  % Very unlikely to come upto this stage. If Score(:,4)
        End = Score(Index4,3);
        Index5 = find(End <= PtsAS(:,1) & PtsAS(:,1) <= End+55,1);
        Curr_AS_pk_Index = Index5;
        Curr_AS_pk_time = PtsAS(Index5,1);
        Curr_AS_pk_amp = PtsAS(Index5,2);
    end
end


end

