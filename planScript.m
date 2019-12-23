%LECTURA
parametresTable = readtable('plan.xlsx','Range','A1:E2'); %Lee la primera fila del plan
xyqTable = readtable('plan.xlsx','Range','A3:C9'); %Lee el resto de filas del plan

 X = xyqTable(:,1);
 Y = xyqTable(:,2);
 Q = xyqTable(:,3);
 
%ESCRITURA,se generan los datos del plan en formato texto separado por comas
writetable(parametresTable,'pTable.txt'); type pTable.txt %para visualizar en command window pTable
writetable(xyqTable, 'XQYtable.txt'); type XQYtable.txt


 