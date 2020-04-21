function [SEdepX,SEdepY] = loadSEdep_XY(EdepFileName,Edep_STDFileName,NZ,NXY)

%% Setup the Import Options
opts = delimitedTextImportOptions("NumVariables", 4);

% Specify range and delimiter
opts.DataLines = [9, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["A", "B", "C", "D"];
opts.VariableTypes = ["double", "double", "double", "double"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

%% Matrices XY
tblEdep = readtable(fullfile(EdepFileName), opts);
tblEdep_STD = readtable(fullfile(Edep_STDFileName), opts);

A=tblEdep.D;
B=tblEdep_STD.D;

Edep_1 = reshape(A,[NZ,NXY^2]);
Edep_STD_1 = reshape(B,[NZ,NXY^2]);
MATRIX = {reshape(Edep_1(1,:),[NXY,NXY])'};
MATRIX_STD = {reshape(Edep_STD_1(1,:),[NXY,NXY])'};
for i = 2:NZ;
    MATRIX(i,:) = {reshape(Edep_1(i,:),[NXY,NXY])'};
    MATRIX_STD(i,:) = {reshape(Edep_STD_1(i,:),[NXY,NXY])'};
end
MATRIX = flipud(MATRIX);
MATRIX_STD = flipud(MATRIX_STD);
%%   
SEdepX = nan(NZ,2);
SEdepY = nan(NZ,2);
for i = 1:NZ;
    [SEdepX(i,:),SEdepY(i,:)] = SEdep_z(MATRIX{i,1},MATRIX_STD{i,1});
end

    
    
    