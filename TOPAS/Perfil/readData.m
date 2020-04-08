function [NR,NZ,dR,dZ,spreadX,spreadY,angularspreadX,angularspreadY,energy,N_histories] = readData(EdepFileName,SDFileName)
filetext = fileread(EdepFileName);
filetext2 = fileread(SDFileName);
%Energy
[Delimiter_energy1,Delimiter_energy2] = regexp(filetext2, 'BeamEnergy  ');
toma_energy = filetext2(Delimiter_energy2(1):Delimiter_energy2(1)+30);
Delimiter_equal = regexp(toma_energy,'=');
Delimiter_MeV= regexp(toma_energy,' MeV');
energy = str2num(toma_energy(Delimiter_equal+2:Delimiter_MeV-1));

%Histories
[Delimiter_histories1,Delimiter_histories2] = regexp(filetext2, 'HistoriesInRun  ');
toma_histories = filetext2(Delimiter_histories2(1):Delimiter_histories2(1)+30);
Delimiter_equal = regexp(toma_histories,'=');
Delimiter_Ts = regexp(toma_histories,'i:Ts/Show');
N_histories = str2num(toma_histories(Delimiter_equal+2:Delimiter_Ts-3));

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


%Angular Spreads
[Delimiter_angularspread1,Delimiter_angularspread2] = regexp(filetext2, 'arSpread');
toma_angularspreadX = filetext2(Delimiter_angularspread2(1):Delimiter_angularspread2(1)+30);
Delimiter_equal = regexp(toma_angularspreadX,'=');
Delimiter_rad = regexp(toma_angularspreadX,' rad');
angularspreadX = str2num(toma_angularspreadX(Delimiter_equal+2:Delimiter_rad-1));
toma_angularspreadY = filetext2(Delimiter_angularspread2(2):Delimiter_angularspread2(2)+30);
Delimiter_equal = regexp(toma_angularspreadY,'=');
Delimiter_cm = regexp(toma_angularspreadY,' rad');
angularspreadY = str2num(toma_angularspreadY(Delimiter_equal+2:Delimiter_rad-1));


%Number of bins
[Delimiter_In1, Delimiter_In2] = regexp(filetext,'in ');
Delimiter_bin = regexp(filetext,' bin');
str_NR = filetext(Delimiter_In2(2)+1:Delimiter_bin(1)-1);
str_NPhi = filetext(Delimiter_In2(3)+1:Delimiter_bin(2)-1);
str_NZ = filetext(Delimiter_In2(5)+1:Delimiter_bin(3)-1);
%Bin length 
[Delimiter_of1, Delimiter_of2] = regexp(filetext,'of ');
Delimiter_cm = regexp(filetext,' cm');
Delimiter_deg = regexp(filetext,' deg');
str_dR = filetext(Delimiter_of2(1)+1:Delimiter_cm(1)-1);
str_dPhi = filetext(Delimiter_of2(2)+1:Delimiter_deg(1)-1);
str_dZ = filetext(Delimiter_of2(3)+1:Delimiter_cm(2)-1);

NR = str2num(str_NR);
NPhi = str2num(str_NPhi);
NZ = str2num(str_NZ);

dR = str2num(str_dR);
dPhi = str2num(str_dPhi);
dZ = str2num(str_dZ);