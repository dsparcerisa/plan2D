function writePlan(parameters_Table,xyqMatrix)
%Se crea un archivo csv en el que se escribe parameters_Table y,posteriormente, se a�aden a este archivo los valores de X, Y y Q.
writetable (parameters_Table, 'outputPlan.csv'); 
header = {'X','Y','Q'};
dlmwrite('outputPlan.csv',header,'-append');
dlmwrite('outputPlan.csv',xyqMatrix,'-append');

end

