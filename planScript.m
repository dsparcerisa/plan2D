
clear all
%LECTURA 
planTable = readtable('plan.csv'); 
[parameters_Table,xyqMatrix, xyq_Table] = readPlan(planTable);
%pongo como parámetro de salida xyqMatrix también porque para poder unir las dos tablas en la función writeTable (concretamente en dlmwrite), necesito el formato matriz

%ESCRITURA, la función writePlan devuelve un fichero csv
writePlan(parameters_Table,xyqMatrix);




 