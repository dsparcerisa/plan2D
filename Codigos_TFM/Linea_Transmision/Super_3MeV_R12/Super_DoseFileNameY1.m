function [DFN,COMGXFN] = Super_DoseFileNameY1
%% Simulation Radiochromics
z = [4.9:1.5:10.9];
SX = 1;
SY = [0.5:0.2:1.5];
MG1 = [0.10:0.05:0.30];
MG2 = 0.26;
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
                    beginname = sprintf('%0.1f-%0.1f-%0.2f-%0.2f',sx,sy,mg1,mg2);
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