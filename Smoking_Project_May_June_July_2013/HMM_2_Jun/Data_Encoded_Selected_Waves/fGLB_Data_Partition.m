function[TrData,TrLabels,TstData,TstLabels] = fGLB_Data_Partition(I,VTEnCod,Labels)
% This function partitions the data for Global Model Training


Len = length(VTEnCod);

Sit1 = [];Read1 = [];
Walk1 = [];Smk1 = [];  

LabelsSit1 = [];LabelsRead1 = [];
LabelsWalk1 = [];LabelsSmk1 = [];  

for i = 1 : 1 : Len
    if(I == i)
        TstData.Sit = VTEnCod(i).Sit;
        TstData.Read = VTEnCod(i).Read;
        TstData.Walk = VTEnCod(i).Walk;
        TstData.Smk = VTEnCod(i).Smk;
        
        TstLabels.Sit = Labels(i).Sit;
        TstLabels.Read = Labels(i).Read;
        TstLabels.Walk = Labels(i).Walk;
        TstLabels.Smk = Labels(i).Smk;
    else
        Sit1 = cat(2,Sit1,VTEnCod(i).Sit);
        Read1 = cat(2,Read1,VTEnCod(i).Read);
        Walk1 = cat(2,Walk1,VTEnCod(i).Walk);
        Smk1 = cat(2,Smk1,VTEnCod(i).Smk);
        
        LabelsSit1 = cat(1,LabelsSit1,Labels(i).Sit);
        LabelsRead1 = cat(1,LabelsRead1,Labels(i).Read);
        LabelsWalk1 = cat(1,LabelsWalk1,Labels(i).Walk);
        LabelsSmk1 = cat(1,LabelsSmk1,Labels(i).Smk);
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