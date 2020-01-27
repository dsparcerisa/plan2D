%<<<<<<< HEAD
function [parameters_Table, xyqMatrix, xyq_Table] = readPlan(planTable)
%El plan se va a leer en dos partes debido a sus dimensiones
%A continuaci�n se lee la primera fila del plan
try parametersTable = planTable(1,1:5);
    disp('Todo bien');
catch
    disp('Ha habido un error en el tama�o o formato del plan');
    return
end
parametersTable = planTable(1,1:5);

energy = parametersTable(:,1);
numericEnergy = table2array(energy);
E = str2double(numericEnergy);

z = parametersTable(:,2);
numericZ = table2array(z);
Z = str2double(numericZ);

intensity = parametersTable(:,3);
numericIntensity = table2array(intensity);
I = str2double(numericIntensity);

filterCode = parametersTable(:,4);
codFiltro = table2array(filterCode);

numberSpots = parametersTable(:,5);
numSpots = table2array(numberSpots);

parameters_Table = table(E,Z,I,codFiltro,numSpots);
parameters_Table.Properties.VariableNames{'E'} = 'E_MeV';
parameters_Table.Properties.VariableNames{'Z'} = 'Z_cm';
parameters_Table.Properties.VariableNames{'I'} = 'I_nA';

%Se leen el resto de filas del plan
xyqTable = planTable(3:end,1:3); 
numericXYQtable = table2array(xyqTable);

x = str2double(numericXYQtable(:,1));
%Comprobaci�n de que el n�mero de spots de la cabezera coincida con el n�mero de spots de la lista
%No us� bloque try catch porque no sab�a c�mo poner la condici�n dentro de �l
 A = size(x); B = A(1);
  if B==numSpots
      disp('Todo bien');
  elseif B~=numSpots
      disp('n�mero de spots de la cabecera no coincide con el n�mero de filas de X, Y, Q');
      return
  end
y = str2double(numericXYQtable(:,2));
q = str2double(numericXYQtable(:,3));
xyq_Table = table(x,y,q);
xyq_Table.Properties.VariableNames{'x'} = 'X_cm';
xyq_Table.Properties.VariableNames{'y'} = 'Y_cm';
xyq_Table.Properties.VariableNames{'q'} = 'Q_pC';
xyqMatrix = [x,y,q];
%=======
function plan = readPlan(planFile)
%% Read name

ID = fopen(planFile);
tline = fgetl(ID);
tline = strtrim(tline(2:end));
fprintf('Reading plan with name %s\n', tline);
fclose(ID);

%% Read header

opts = delimitedTextImportOptions("NumVariables", 5);

% Specify range and delimiter
opts.DataLines = [3, 3];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["EMeV", "Zcm", "InA", "codFiltro", "numSpots"];
opts.VariableTypes = ["double", "double", "double", "string", "uint16"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "codFiltro", "WhitespaceRule", "trim");
opts = setvaropts(opts, "codFiltro", "EmptyFieldRule", "auto");
opts = setvaropts(opts, "numSpots", "TrimNonNumeric", true);
opts = setvaropts(opts, "numSpots", "ThousandsSeparator", ",");

% Import header
header = readtable(planFile, opts);
clear opts

%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 3);

% Specify range and delimiter
opts.DataLines = [5, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Xcm", "Ycm", "QpC"];
opts.VariableTypes = ["double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
dataTable = readtable(planFile, opts);


plan.E = header.EMeV;
plan.Z = header.Zcm;
plan.I = header.InA;
plan.codFiltro = header.codFiltro;
plan.numSpots = header.numSpots;
plan.X = dataTable.Xcm;
plan.Y = dataTable.Ycm;
plan.Q = dataTable.QpC;
plan.name = tline;

%>>>>>>> master
end
end

