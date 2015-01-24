function[TrData,TrLabels,TstData,TstLabels] = fSemi_GLB_Data_Partition(SelSub,I,VTEnCod,Labels)
% This function partitions the data for Global Model Training
% SelSub = Array of Subject #'s that are Selected for Training and Testing
% I = Subject # that is Selected for Training and Testing 

Len = length(SelSub);

Sit1 = [];Read1 = [];
Walk1 = [];Smk1 = [];  

LabelsSit1 = [];LabelsRead1 = [];
LabelsWalk1 = [];LabelsSmk1 = [];  

for i = 1 : 1 : Len
    j = SelSub(i)
    if(I == j)
        TstData.Sit = VTEnCod(j).Sit;
        TstData.Read = VTEnCod(j).Read;
        TstData.Walk = VTEnCod(j).Walk;
        TstData.Smk = VTEnCod(j).Smk;
        
        TstLabels.Sit = Labels(j).Sit;
        TstLabels.Read = Labels(j).Read;
        TstLabels.Walk = Labels(j).Walk;
        TstLabels.Smk = Labels(j).Smk;
    else
        Sit1 = cat(2,Sit1,VTEnCod(j).Sit);
        Read1 = cat(2,Read1,VTEnCod(j).Read);
        Walk1 = cat(2,Walk1,VTEnCod(j).Walk);
        Smk1 = cat(2,Smk1,VTEnCod(j).Smk);
        
        LabelsSit1 = cat(1,LabelsSit1,Labels(j).Sit);
        LabelsRead1 = cat(1,LabelsRead1,Labels(j).Read);
        LabelsWalk1 = cat(1,LabelsWalk1,Labels(j).Walk);
        LabelsSmk1 = cat(1,LabelsSmk1,Labels(j).Smk);
    end
end

TrData.Sit = Sit1;
TrData.Read = Read1;
TrData.Walk = Walk1;
TrData.Smk = Smk1;

TrLabels.Sit = LabelsSit1;
TrLabels.Read = LabelsRead1;
TrLabels.Walk = LabelsWalk1;
TrLabels.Smk = LabelsSmk1;




end





