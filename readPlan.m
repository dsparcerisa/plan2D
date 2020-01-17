function [parameters_Table, xyqMatrix, xyq_Table] = readPlan(planTable)
%El plan se va a leer en dos partes debido a sus dimensiones
%A continuación se lee la primera fila del plan
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
y = str2double(numericXYQtable(:,2));
q = str2double(numericXYQtable(:,3));
xyq_Table = table(x,y,q);
xyq_Table.Properties.VariableNames{'x'} = 'X_cm';
xyq_Table.Properties.VariableNames{'y'} = 'Y_cm';
xyq_Table.Properties.VariableNames{'q'} = 'Q_pC';
xyqMatrix = [x,y,q];
end

