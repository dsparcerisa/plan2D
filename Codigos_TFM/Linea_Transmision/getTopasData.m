function [D, D_STD, x, y, z] = getTopasData(FileName)
%Returns from a TOPAS output file both matrices with mean and STD distribution along with x, y, z position arrays. The matrices dimensions correspond to [NX, NY, NZ].

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
DD = readtable(FileName, opts);

%% Convert to output type
DD = table2array(DD);
D = DD(:,1);
D_STD = DD(:,2);

%% Read Bin Data
filetext = fileread(FileName);


%% Number of bins
[Delimiter_In1, Delimiter_In2] = regexp(filetext,'in ');
Delimiter_bin = regexp(filetext,' bin');
str_NX = filetext(Delimiter_In2(2)+1:Delimiter_bin(1)-1);
str_NY = filetext(Delimiter_In2(3)+1:Delimiter_bin(2)-1);
str_NZ = filetext(Delimiter_In2(4)+1:Delimiter_bin(3)-1);

NX = str2num(str_NX);
NY = str2num(str_NY);
NZ = str2num(str_NZ);

%% Bin length 
[Delimiter_of1, Delimiter_of2] = regexp(filetext,'of ');
Delimiter_cm = regexp(filetext,' cm');

str_dx = filetext(Delimiter_of2(1)+1:Delimiter_cm(1)-1);
str_dy = filetext(Delimiter_of2(2)+1:Delimiter_cm(2)-1);
str_dz = filetext(Delimiter_of2(3)+1:Delimiter_cm(3)-1);

dx = str2num(str_dx);
dy = str2num(str_dy);
dz = str2num(str_dz);

%% Reshape 
D = permute(reshape(D, [NZ NY NX]), [3 2 1]);
D_STD = permute(reshape(D_STD, [NZ NY NX]), [3 2 1]);


%% Bin positions
x = dx * [-(NX/2-1/2):(NX/2-1/2)]*10;
y = dy * [-(NY/2-1/2):(NY/2-1/2)]*10;
z = dz * [NZ-1/2:-1:1/2];

end