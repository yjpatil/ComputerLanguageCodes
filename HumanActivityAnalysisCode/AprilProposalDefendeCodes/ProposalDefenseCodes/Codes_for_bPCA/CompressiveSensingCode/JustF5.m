% Just RUN F5 %




MSc01 = MSc01LV7;
MSc02 = MSc02LV7;
MSc03 = MSc03LV7;
MSc04 = MSc04LV7;

LV = [];
% % <> ------- Re-Test Using Training Data ------- <> % %
[LL01TrSc1,tstMSc01LV1,tstqcn01,tstRelChange01] = BTPCA_modify(TrSc01,LV,1,1,0,MSc01);
[LL02TrSc1,tstMSc02LV1,tstqcn02,tstRelChange02] = BTPCA_modify(TrSc01,LV,1,1,0,MSc02);
[LL03TrSc1,tstMSc03LV1,tstqcn03,tstRelChange03] = BTPCA_modify(TrSc01,LV,1,1,0,MSc03);

[LL01TrSc2,tstMSc01LV1,tstqcn01,tstRelChange01] = BTPCA_modify(TrSc02,LV,1,1,0,MSc01);
[LL02TrSc2,tstMSc02LV1,tstqcn02,tstRelChange02] = BTPCA_modify(TrSc02,LV,1,1,0,MSc02);
[LL03TrSc2,tstMSc03LV1,tstqcn03,tstRelChange03] = BTPCA_modify(TrSc02,LV,1,1,0,MSc03);

[LL01TrSc3,tstMSc01LV1,tstqcn01,tstRelChange01] = BTPCA_modify(TrSc03,LV,1,1,0,MSc01);
[LL02TrSc3,tstMSc02LV1,tstqcn02,tstRelChange02] = BTPCA_modify(TrSc03,LV,1,1,0,MSc02);
[LL03TrSc3,tstMSc03LV1,tstqcn03,tstRelChange03] = BTPCA_modify(TrSc03,LV,1,1,0,MSc03);

R2_TrLL = [max(LL01TrSc1), max(LL02TrSc1), max(LL03TrSc1);
           max(LL01TrSc2), max(LL02TrSc2), max(LL03TrSc2);
           max(LL01TrSc3), max(LL02TrSc3), max(LL03TrSc3)];
printmat(R2_TrLL, 'Re-Test Train Data', 'TrSc01 TrSc02 TrSc03', 'Sc01_Model Sc02_Model Sc03_Model' )


% % <> ------- Test Using Testing Data ------- <> % %
[LL01TstSc1,tstMSc01LV1,tstqcn01,tstRelChange01] = BTPCA_modify(TstSc01,LV,1,1,0,MSc01);
[LL02TstSc1,tstMSc02LV1,tstqcn02,tstRelChange02] = BTPCA_modify(TstSc01,LV,1,1,0,MSc02);
[LL03TstSc1,tstMSc03LV1,tstqcn03,tstRelChange03] = BTPCA_modify(TstSc01,LV,1,1,0,MSc03);

[LL01TstSc2,tstMSc01LV1,tstqcn01,tstRelChange01] = BTPCA_modify(TstSc02,LV,1,1,0,MSc01);
[LL02TstSc2,tstMSc02LV1,tstqcn02,tstRelChange02] = BTPCA_modify(TstSc02,LV,1,1,0,MSc02);
[LL03TstSc2,tstMSc03LV1,tstqcn03,tstRelChange03] = BTPCA_modify(TstSc02,LV,1,1,0,MSc03);

[LL01TstSc3,tstMSc01LV1,tstqcn01,tstRelChange01] = BTPCA_modify(TstSc03,LV,1,1,0,MSc01);
[LL02TstSc3,tstMSc02LV1,tstqcn02,tstRelChange02] = BTPCA_modify(TstSc03,LV,1,1,0,MSc02);
[LL03TstSc3,tstMSc03LV1,tstqcn03,tstRelChange03] = BTPCA_modify(TstSc03,LV,1,1,0,MSc03);

R1_TstLL = [max(LL01TstSc1), max(LL02TstSc1), max(LL03TstSc1);
           max(LL01TstSc2), max(LL02TstSc2), max(LL03TstSc2);
           max(LL01TstSc3), max(LL02TstSc3), max(LL03TstSc3)];
printmat(R1_TstLL, 'Re-Test Train Data', 'TstSc01 TstSc02 TstSc03', 'Sc01_Model Sc02_Model Sc03_Model' )



clc;
printmat(R1_TrLL,'LogLikVsScs', 'BVs1 BVs2 BVs3 BVs4 BVs5 BVs6 BVs7 BVs8 BVs9 BVs10 BVs11 BVs12 BVs13 BVs14 BVs15 BVs16 BVs17 BVs18 BVs19 BVs20','Scenario1 Scenario2 Scenario3 Scenario4' )
printmat(R2_TrLL, 'Re-Test Train Data', 'TrSc01 TrSc02 TrSc03', 'Sc01_Model Sc02_Model Sc03_Model' )
printmat(R1_TstLL, 'Re-Test Train Data', 'TstSc01 TstSc02 TstSc03', 'Sc01_Model Sc02_Model Sc03_Model' )





