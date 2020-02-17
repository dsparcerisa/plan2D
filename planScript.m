
clear all

%% LECTURA 
planTable = readtable('plan.csv'); %readTable solo lo carga a workspace todo en formato texto
[parameters_Table, xyqMatrix, xyq_Table] = readPlan(planTable); %lee el plan en dos tablas, ya en formato numérico

%% ESCRITURA, la función writePlan devuelve un fichero csv con el plan
writePlan(parameters_Table, xyqMatrix);
