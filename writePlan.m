<<<<<<< HEAD
function writePlan(parameters_Table,xyqMatrix)
%Se crea un archivo csv en el que se escribe parameters_Table y,posteriormente, se añaden a este archivo los valores de X, Y y Q.
writetable (parameters_Table, 'outputPlan.csv'); 
header = {'X','Y','Q'};
dlmwrite('outputPlan.csv',header,'-append');
dlmwrite('outputPlan.csv',xyqMatrix,'-append');

=======
function writePlan(plan, outFile)
    ID = fopen(outFile, 'w');
    
    % Write name
    fprintf(ID, '# %s\n', plan.name);
    
    % Write header
    fprintf(ID, '# E (MeV), Z (cm), I (nA), codFiltro, numSpots\n');
    fprintf(ID, '%3.2f, %3.2f, %3.3f, %s, %u\n', plan.E, plan.Z, plan.I, plan.codFiltro, plan.numSpots);
    
    % Write table
    fprintf(ID, '# X (cm), Y (cm), Q (pC)\n');
    for i=1:plan.numSpots
        fprintf(ID, '%3.2f, %3.2f, %f\n', plan.X(i), plan.Y(i), plan.Q(i));
    end    
    
    fclose(ID);
>>>>>>> master
end

