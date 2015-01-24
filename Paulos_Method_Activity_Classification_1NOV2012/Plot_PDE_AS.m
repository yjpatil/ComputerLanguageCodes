function[I]=Plot_PDE_AS(Subject,I,Sub_Name,Indexx)

figure;hold on;

title(strcat(Sub_Name,'PDE for Feat TD (AS) across different Activity'));

Temp1 = gkde0(Subject(I).Activity.Sitting.AS_feat(:,Indexx));
H1plt = plot(Temp1.x,Temp1.f,'Color',[0.3 0.2 0.1]);

Temp2 = gkde0(Subject(I).Activity.Reading.AS_feat(:,Indexx));
H2plt = plot(Temp2.x,Temp2.f,'Color',[0.7 0.2 0.1]);

% Temp3 = gkde0(Subject(I).Activity.Standing.AS_feat(:,Indexx));
% H3plt = plot(Temp3.x,Temp3.f,'Color',[0.3 0.6 0.1]);

% Temp4 = gkde0(Subject(I).Activity.Walk_Slow.AS_feat(:,Indexx));
% H4plt = plot(Temp4.x,Temp4.f,'Color',[0.3 0.2 0.8]);

% Temp5 = gkde0(Subject(I).Activity.Walk_Fast.AS_feat(:,Indexx));
% H5plt = plot(Temp5.x,Temp5.f,'Color',[0.1 0.2 0.8]);

% Temp6 = gkde0(Subject(I).Activity.Use_Laptop.AS_feat(:,Indexx));
% H6plt = plot(Temp6.x,Temp6.f,'Color',[0.9 0.2 0.8]);

Temp7 = gkde0(Subject(I).Activity.Eat_with_Hands.AS_feat(:,Indexx));
H7plt = plot(Temp7.x,Temp7.f,'Color',[0.9 0.2 0.0]);

% Temp8 = gkde0(Subject(I).Activity.Eat_with_Fork.AS_feat(:,Indexx));
% H8plt = plot(Temp8.x,Temp8.f,'Color',[0.4 0.9 0.9]);

Temp9 = gkde0(Subject(I).Activity.Walk_Outside.AS_feat(:,Indexx));
H9plt = plot(Temp9.x,Temp9.f,'Color',[0.7 0.7 0.7]);

Temp10 = gkde0(Subject(I).Activity.Smoke_Sitting.AS_feat(:,Indexx));
H10plt = plot(Temp10.x,Temp10.f,'Color',[0.07 0.07 0.0]);

% Temp11 = gkde0(Subject(I).Activity.Rest_Inside.AS_feat(:,Indexx));
% H11plt = plot(Temp11.x,Temp11.f,'Color',[0.97 0.07 0.17]);

Temp12 = gkde0(Subject(I).Activity.Smoke_Standing.AS_feat(:,Indexx));
H12plt = plot(Temp12.x,Temp12.f,'Color',[0.9 0.87 0.37]);

legend([H1plt H2plt H7plt H9plt H10plt H12plt],{'Sitting' 'Reading' 'Eat with Hands' 'Walk Outside' 'Smoke Sitting' 'Smoke Standing'})
%legend([H1plt H2plt H3plt H4plt H5plt H6plt H7plt H8plt H9plt H10plt H11plt H12plt],{'Sitting' 'Reading' 'Standing' 'Walk Slow' 'Walk Fast' 'Use Laptop' 'Eat with Hands' 'Eat with Fork' 'Walk Outside' 'Smoke Sitting' 'Rest Inside' 'Smoke Standing'})

end