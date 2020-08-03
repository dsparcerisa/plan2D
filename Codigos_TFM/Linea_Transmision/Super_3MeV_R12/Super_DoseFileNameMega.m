function [DFN,COMGXFN] = Super_DoseFileNameMega
%% Simulation Radiochromics
z = [4.9:1.5:10.9];
SX = [0.8:0.05:1];
SY = [1.9:0.05:2.1];
MG1 = [0.14:0.005:0.16];
MG2 = [0.25:0.005:0.27];
DFN = [];
COMGXFN =[];

for i = 1 : length(SX);
    sx = SX(i);
    for ii = 1: length(SY);
        sy = SY(ii);
            for j = 1 : length(MG1);
                mg1 = MG1(j);
                for jj = 1 : length(MG2);
                    mg2 = MG2(jj);
                    beginname = sprintf('%0.2f-%0.2f-%0.3f-%0.3f',sx,sy,mg1,mg2);
                    DoseFileName = cell(1,5);
                    for k = 1: length(z);
                        endname = sprintf('-%0.1f.csv',z(k));
                        DoseFileName{k} = ['Dose_',beginname,endname];
                    end
                    DFN = [DFN;DoseFileName];
                    COMGXFN =[COMGXFN;{beginname}];
                end
            end    
     end
end