function[EinTrSc] = fCreateMultCopSingleData(TrScX,SampleNo,Copies);
% This function creates multiple copies of the same sample from the same
% sceneario


for i = 1 : 1 : Copies
    EinTrSc(:,:,i) = TrScX(:,:,SampleNo);
end







end