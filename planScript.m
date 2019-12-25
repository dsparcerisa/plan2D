clc
clear all
%LECTURA 
planTable = readtable ('plan.csv');
parametersTable = planTable(1,1:5);

%header = {'X(cm)','Y(cm)','Q(pC)'}; %los nombres de las variables de de xqyTable están mal
xyqTable = planTable(3:8,1:3);
x = xyqTable(:,1);
y = xyqTable(:,2);
q = xyqTable(:,3);
xyqTable.Properties.VariableNames{'E_MeV_'} = 'X(cm)';
xyqTable.Properties.VariableNames{'Z_cm_'} = 'Y(cm)';
xyqTable.Properties.VariableNames{'I_Na_'} = 'Q(pC)';
% X=nan(size(x));
% for i=1:numel(x)
%     X(i) = cell2mat(x(i));
% end
%xyqTable = str2num(xyqTable); %solo funciona si el imput es un vector o un escalar string
%xyqTable = cell2mat(xyqTable);

%ESCRITURA
writetable (parametersTable, 'outputPlan.csv');
%  P = fopen('outputPlan.csv','a'); %devuelve un identificador de archivo
%  fprintf(P,'\n',x,y,q);
%  fclose(P);
%  type outputPlan.csv
csvwrite('outputPlan.csv',xyqTable,2,0); %esto creo que no funciona por no ser numérico¿?

%que escriba primero la de parámetros y luego que la otra se escriba sobre 
%ese csv, igual con fopen outputPlan, luego escribir xqy y luego fclose


%LECTURA
% parametersTable = readtable('plan.csv','Range','A1:E2'); %Lee la primera fila del plan
% xyqTable = readtable('plan.csv','Range','A3:C9'); %Lee el resto de filas del plan

%  X = xyqTable(:,1);
%  Y = xyqTable(:,2);
%  Q = xyqTable(:,3);
%  
%ESCRITURA,se generan los datos del plan en formato texto separado por comas
%writetable(parametersTable,'pTable.csv'); type pTable.csv %para visualizar en command window pTable
%writetable(xyqTable, 'pTable.csv'); type pTable.csv



 