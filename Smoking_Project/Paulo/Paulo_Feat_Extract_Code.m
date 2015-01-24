clc;clear all;close all;

load 'Subject_hand_features_20sub.mat';
load 'Subject_hand_labels_20sub.mat'
err = 0;
tempS = [];
tempL = [];
% Code to Separate Paulos Features and Labels %

TS = length(Subject_hand_features);

for I = 1 : 1 : TS
    tempS = [];
    tempL = [];
    %hg = 0;
    TA = length(Subject_hand_features{I,1});
    for A = 1 : 1 : TA
        HG = length(Subject_hand_features{I,1}{A,1});
        f1 = Subject_hand_labels{I,1}{A,4};
        indf1 = find(f1 == 0);
        errf1 = isempty(indf1);
        if (errf1 == 1)
        else
            f1(indf1) = -1;
        end
        tempL = cat(1,tempL,f1')
        if (HG == 0)
            tempSz = zeros(1,1506);
            tempS = cat(1,tempS,tempSz);
            %tempF = cat(1,tempF,0);
        else
            for H = 1 : 1 : HG
                %hg = hg + 1;                
                ch = length(Subject_hand_features{I,1}{A,1}{1,H}(1,:));
                if ( ch == 1506)
                    tempS = cat(1,tempS,Subject_hand_features{I,1}{A,1}{1,H}(1,:));
                else
                    %ch
                    %A
                    %H
                    temp = Subject_hand_features{I,1}{A,1}{1,H}(1,ch);
                    app = temp * ones(1,1506-ch);
                    x11 = cat(2,Subject_hand_features{I,1}{A,1}{1,H}(1,:),app);
                    length(Subject_hand_features{I,1}{A,1}{1,H}(1,:))
                    tempS = cat(1,tempS,x11);
                    err = err + 1;
                end
            end
        end
    end
    S(I).F = tempS;
    S(I).L = tempL;
end
S = S';             