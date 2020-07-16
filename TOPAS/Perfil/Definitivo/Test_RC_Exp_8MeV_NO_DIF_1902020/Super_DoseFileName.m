function [DFN,COMGXFN] = Super_DoseFileName
%% Simulation Radiochromics
z = [4.9:1.5:10.9];
CutOffX = [6.5];
CutOffY = [6.5];
MGX = [0.0765:0.00025:0.077,0.0775:0.00025:0.079];
MGY = [0.1175:0.00025:0.12];
DFN = [];
COMGXFN =[];
for i = 1 : length(CutOffX);
    cutoffx = CutOffX(i);
    for ii = 1 : length(CutOffY);
        cutoffy = CutOffY(ii);
            for j = 1 : length(MGX);
                mgx = MGX(j);
                for jj = 1 : length(MGY);
                    mgy = MGY(jj);
                    endname = sprintf('%0.1f-%0.1f-%0.5f-%0.5f',cutoffx,cutoffy,mgx,mgy);
                    DoseFileName = cell(1,5);
                    for k = 1: length(z);
                        beginname = sprintf('Dose_%0.1f-',z(k));
                        DoseFileName{k} = [beginname,endname,'.csv'];
                    end
                    DFN = [DFN;DoseFileName];
                    COMGXFN =[COMGXFN;{endname}];
                end
            end
    end
end