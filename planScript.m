
clear all
%LECTURA 
planTable = readtable('plan.csv'); 
[parameters_Table,xyqMatrix, xyq_Table] = readPlan(planTable);
%pongo como par�metro de salida xyqMatrix tambi�n porque para poder unir las dos tablas en la funci�n writeTable (concretamente en dlmwrite), necesito el formato matriz

%ESCRITURA, la funci�n writePlan devuelve un fichero csv
writePlan(parameters_Table,xyqMatrix);




 