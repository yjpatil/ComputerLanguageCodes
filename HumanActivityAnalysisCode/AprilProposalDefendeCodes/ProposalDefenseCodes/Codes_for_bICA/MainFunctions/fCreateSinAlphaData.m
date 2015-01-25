function[Data] = fCreateSinAlphaData(MaxSensors,Stheta,Ltheta,N,Trans,Delta)


%Delta = 5;

for i = 1 : 1 : MaxSensors
    Alpha = [];
    Alpha = i*10 + Delta;
    
    Emis = [(cos(Stheta)-cos(Ltheta))*abs(cos(Alpha)) (1-cos(Stheta)+cos(Ltheta))*abs(cos(Alpha));(1-cos(Stheta))*abs(cos(Alpha)) (cos(Stheta))*abs(cos(Alpha))]; 
    
    seq = [];
    
    [seq,states] = hmmgenerate(N,Trans,Emis);
    index = find(seq == 1);seq(index) = 0;
    index = find(seq == 2);seq(index) = 1;
    
    Data(i,:) = seq;
    
    Delta = Delta + 10;
    
end






















