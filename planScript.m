
clear all

%% LECTURA 
planTable = readtable('plan.csv'); %readTable solo lo carga a workspace todo en formato texto
[parameters_Table, xyqMatrix, xyq_Table] = readPlan(planTable); %lee el plan en dos tablas, ya en formato num�rico

%% ESCRITURA, la funci�n writePlan devuelve un fichero csv con el plan
writePlan(parameters_Table, xyqMatrix);
