function [Edep, Edep_STD, NX, NY, NZ, dx, dy, dz, Spread, AngularSpread, MagneticGradient1, MagneticGradient2, energy] = importData(EdepFileName,Edep_STDFileName,CodeFileName)
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

Edep = tblEdep.D;
Edep_STD = tblEdep_STD.D;

%% Read Bin Data
filetext = fileread(EdepFileName);
filetext2 = fileread(CodeFileName);

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

%Spreads
[Delimiter_spread1,Delimiter_spread2] = regexp(filetext2, 'onSpread');
toma_spreadX = filetext2(Delimiter_spread2(1):Delimiter_spread2(1)+30);
Delimiter_equal = regexp(toma_spreadX,'=');
Delimiter_cm = regexp(toma_spreadX,' cm');
spreadX = str2num(toma_spreadX(Delimiter_equal+2:Delimiter_cm-1));
toma_spreadY = filetext2(Delimiter_spread2(2):Delimiter_spread2(2)+30);
Delimiter_equal = regexp(toma_spreadY,'=');
Delimiter_cm = regexp(toma_spreadY,' cm');
spreadY = str2num(toma_spreadY(Delimiter_equal+2:Delimiter_cm-1));

Spread = [spreadX;spreadY];

%% Angular Spreads
[Delimiter_angularspread1,Delimiter_angularspread2] = regexp(filetext2, 'arSpread');
toma_angularspreadX = filetext2(Delimiter_angularspread2(1):Delimiter_angularspread2(1)+30);
Delimiter_equal = regexp(toma_angularspreadX,'=');
Delimiter_rad = regexp(toma_angularspreadX,' rad');
angularspreadX = str2num(toma_angularspreadX(Delimiter_equal+2:Delimiter_rad));
toma_angularspreadY = filetext2(Delimiter_angularspread2(2):Delimiter_angularspread2(2)+30);
Delimiter_equal = regexp(toma_angularspreadY,'=');
Delimiter_cm = regexp(toma_angularspreadY,' rad');
angularspreadY = str2num(toma_angularspreadY(Delimiter_equal+2:Delimiter_rad));

AngularSpread = [angularspreadX; angularspreadY];

%% Energy
[Delimiter_energy1,Delimiter_energy2] = regexp(filetext2, 'BeamEnergy  ');
toma_energy = filetext2(Delimiter_energy2(1):Delimiter_energy2(1)+30);
Delimiter_equal = regexp(toma_energy,'=');
Delimiter_MeV= regexp(toma_energy,' MeV');
energy = str2num(toma_energy(Delimiter_equal+2:Delimiter_MeV-1));

%% Histories
%[Delimiter_histories1,Delimiter_histories2] = regexp(filetext2, 'HistoriesInRun  ');
%toma_histories = filetext2(Delimiter_histories2(1):Delimiter_histories2(1)+40);
%Delimiter_equal = regexp(toma_histories,'=');
%Delimiter_Ts = regexp(toma_histories,'1#');
%N_histories = str2num(toma_histories(Delimiter_equal+2:Delimiter_Ts-2));

%% Magnetic Gradient 1
[Delimiter_gradient1,Delimiter_gradient2] = regexp(filetext2, '1/Magnetic');
[Delimiter_tesla1,Delimiter_tesla2] = regexp(filetext2, 'tesla');

toma_gradientX = filetext2(Delimiter_gradient2(1)+1:Delimiter_tesla1(1));
Delimiter_equal = regexp(toma_gradientX,'=');
Delimiter_t = regexp(toma_gradientX,'t');
MagneticGradientX1 = str2num(toma_gradientX(Delimiter_equal+1:Delimiter_t(2)-1));

toma_gradientY = filetext2(Delimiter_gradient2(2)+1:Delimiter_tesla1(2));
Delimiter_equal = regexp(toma_gradientY,'=');
Delimiter_t = regexp(toma_gradientY,'t');
MagneticGradientY1 = str2num(toma_gradientY(Delimiter_equal+2:Delimiter_t(2)-2));

MagneticGradient1 = [MagneticGradientX1; MagneticGradientY1];

%% Magnetic Gradient 2
[Delimiter_gradient1,Delimiter_gradient2] = regexp(filetext2, '2/Magnetic');
[Delimiter_tesla1,Delimiter_tesla2] = regexp(filetext2, 'tesla');

toma_gradientX = filetext2(Delimiter_gradient2(1)+1:Delimiter_tesla1(3));
Delimiter_equal = regexp(toma_gradientX,'=');
Delimiter_t = regexp(toma_gradientX,'t');
MagneticGradientX2 = str2num(toma_gradientX(Delimiter_equal+1:Delimiter_t(2)-1));

toma_gradientY = filetext2(Delimiter_gradient2(2)+1:Delimiter_tesla1(4));
Delimiter_equal = regexp(toma_gradientY,'=');
Delimiter_t = regexp(toma_gradientY,'t');
MagneticGradientY2 = str2num(toma_gradientY(Delimiter_equal+2:Delimiter_t(2)-2));

MagneticGradient2 = [MagneticGradientX2; MagneticGradientY2];

