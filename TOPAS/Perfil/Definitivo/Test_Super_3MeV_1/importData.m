function [Dose, Dose_STD, x, y] = importData(DoseFileName)
if nargin < 2
    dataLines = [9, Inf];
end
%% Setup the Import Options
opts = delimitedTextImportOptions("NumVariables", 5);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Var1", "Var2", "Var3", "VarName4", "VarName5"];
opts.SelectedVariableNames = ["VarName4", "VarName5"];
opts.VariableTypes = ["string", "string", "string", "double", "double"];
opts = setvaropts(opts, [1, 2, 3], "WhitespaceRule", "preserve");
opts = setvaropts(opts, [1, 2, 3], "EmptyFieldRule", "auto");
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
DOSE = readtable(DoseFileName, opts);

%% Convert to output type
DOSE = table2array(DOSE);
Dose = DOSE(:,1);
Dose_STD = DOSE(:,2);

%% Read Bin Data
filetext = fileread(DoseFileName);


%% Number of bins
[Delimiter_In1, Delimiter_In2] = regexp(filetext,'in ');
Delimiter_bin = regexp(filetext,' bin');
str_NX = filetext(Delimiter_In2(2)+1:Delimiter_bin(1)-1);
str_NY = filetext(Delimiter_In2(3)+1:Delimiter_bin(2)-1);

NX = str2num(str_NX);
NY = str2num(str_NY);


%% Bin length 
[Delimiter_of1, Delimiter_of2] = regexp(filetext,'of ');
Delimiter_cm = regexp(filetext,' cm');

str_dx = filetext(Delimiter_of2(1)+1:Delimiter_cm(1)-1);
str_dy = filetext(Delimiter_of2(2)+1:Delimiter_cm(2)-1);

dx = str2num(str_dx);
dy = str2num(str_dy);


%% Reshape 
Dose = [reshape(Dose, [NY NX])]';
Dose_STD = [reshape(Dose_STD, [NY NX])]';

%% Bin positions
x = dx * [-(NX/2-1/2):(NX/2-1/2)]*10;
y = dy * [-(NY/2-1/2):(NY/2-1/2)]*10;
