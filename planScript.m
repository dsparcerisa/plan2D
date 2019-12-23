%LECTURA
parametresTable = readtable('plan.xlsx','Range','A1:E2'); %Lee la primera fila del plan
XYQtable = readtable('plan.xlsx','Range','A3:C9'); %Lee el resto de filas del plan

 X = XYQtable(:,1);
 Y = XYQtable(:,2);
 Q = XYQtable(:,3);
 
%ESCRITURA
writetable(parametresTable,'pTable.txt'); type pTable.txt %para visualizar en command window pTable
writetable(XYQtable, 'xqyTable.txt'); type xqyTable.txt


 