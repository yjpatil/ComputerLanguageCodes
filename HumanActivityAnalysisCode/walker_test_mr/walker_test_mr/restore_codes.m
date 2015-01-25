
space_code={'10001000','10000100','10000010','10000001';
            '01001000','01000100','01000010','01000001';
            '00101000','00100100','00100010','00100001';
            '00011000','00010100','00010010','00010001';}; 
len1=length(path1X); len2=length(path2X);
codes1=cell(size(path1_index)); codes2=cell(size(path2_index));

% ------------------For path2--------------------------------------
k=1;
for i=1:len1
    if i==path1_index(k)
        if path1X(i)+0.5>4
            codei=path1X(i)+0.5-4;
            gridi='1';
        else
            codei=path1X(i)+0.5;
            gridi='0';
        end
        if path1Y(i)+0.5>4
            codej=path1Y(i)+0.5-4;
            gridj='1';
        else
            codej=path1Y(i)+0.5;
            gridj='0';
        end
        
        if floor(codei)==codei&&floor(codej)==codej
            codes1{i}=[space_code{floor(codei),floor(codej)}];
        elseif floor(codei)<codei&&floor(codej)==codej
            aaa1=space_code{codei-0.5,floor(codej)};
            aaa2=space_code{codei+0.5,floor(codej)};
            codes1{i}=dec2bin(bitor(bin2dec(aaa1),bin2dec(aaa2)),8);
        elseif floor(codei)==codei&&floor(codej)<codej
            aaa1=space_code{floor(codei),codej-0.5};
            aaa2=space_code{floor(codei),codej+0.5};
            codes1{i}=dec2bin(bitor(bin2dec(aaa1),bin2dec(aaa2)),8);
        elseif floor(codei)<codei&&floor(codej)<codej
            aaa1=space_code{floor(codei-0.5),floor(codej-0.5)};
            aaa2=space_code{floor(codei+0.5),floor(codej+0.5)};
            codes1{i}=dec2bin(bitor(bin2dec(aaa1),bin2dec(aaa2)),8);
        end
        codes1{i}=[gridi,gridj,codes1{i}];
        k=k+1;
    else
        codes1{i}=codes1{i-1};
        
    end
    
end
% ------------------For path2--------------------------------------
k=1;
for i=1:len2
    if i==path2_index(k)
        if path2X(i)+0.5>4
            codei=path2X(i)+0.5-4;
            gridi='1';
        else
            codei=path2X(i)+0.5;
            gridi='0';
        end
        if path2Y(i)+0.5>4
            codej=path2Y(i)+0.5-4;
            gridj='1';
        else
            codej=path2Y(i)+0.5;
            gridj='0';
        end
        
        if floor(codei)==codei&&floor(codej)==codej
            codes2{i}=[space_code{floor(codei),floor(codej)}];
        elseif floor(codei)<codei&&floor(codej)==codej
            aaa1=space_code{codei-0.5,floor(codej)};
            aaa2=space_code{codei+0.5,floor(codej)};
            codes2{i}=dec2bin(bitor(bin2dec(aaa1),bin2dec(aaa2)),8);
        elseif floor(codei)==codei&&floor(codej)<codej
            aaa1=space_code{floor(codei),codej-0.5};
            aaa2=space_code{floor(codei),codej+0.5};
            codes2{i}=dec2bin(bitor(bin2dec(aaa1),bin2dec(aaa2)),8);
        elseif floor(codei)<codei&&floor(codej)<codej
            aaa1=space_code{floor(codei-0.5),floor(codej-0.5)};
            aaa2=space_code{floor(codei+0.5),floor(codej+0.5)};
            codes2{i}=dec2bin(bitor(bin2dec(aaa1),bin2dec(aaa2)),8);
        end
        codes2{i}=[gridi,gridj,codes2{i}];
        k=k+1;
    else
        codes2{i}=codes2{i-1};
        
    end
    
end

len=max(length(codes1),length(codes2));
codes=cell(1,len);
for i=1:len
    if i<=length(codes2)
        codes{i}=dec2bin(bitor(bin2dec(codes1{i}),bin2dec(codes2{i})),10);
    else
        codes{i}=dec2bin(bitor(bin2dec(codes1{i}),bin2dec(codes2{end})),10);
    end
end
clear codes1 codes2;






