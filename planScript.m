
clear all
%LECTURA 
planTable = readtable('plan.csv'); %csvread no me permite leer los valores no numéricos
parametersTable = planTable(1,1:5);
parametersTable.Properties.VariableNames{'E_MeV_'} = 'E(MeV)';
parametersTable.Properties.VariableNames{'Z_cm_'} = 'Z(cm)';
parametersTable.Properties.VariableNames{'I_nA_'} = 'I(nA)';

xyqTable = planTable(3:8,1:3); 
xyqTable.Properties.VariableNames{'E_MeV_'} = 'X(cm)';
xyqTable.Properties.VariableNames{'Z_cm_'} = 'Y(cm)';
xyqTable.Properties.VariableNames{'I_nA_'} = 'Q(pC)';
numericXYQtable = table2array(xyqTable);

x = str2double(numericXYQtable(:,1));
y = str2double(numericXYQtable(:,2));
q = str2double(numericXYQtable(:,3));
xyqMatrix = [x,y,q]; 

%ESCRITURA
writetable (parametersTable, 'outputPlan.csv'); 
header = {'X','Y','Q'};
dlmwrite('outputPlan.csv',header,'-append');
dlmwrite('outputPlan.csv',xyqMatrix,'-append');





 