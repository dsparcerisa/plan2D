function sigma = SigmaZE(PFLU, Z, E)
%PFLU and must be a 10x3 matrix where the first column is an array
%containing the energies. The second and third columns are the
%coefficients of the sigma(Z) polynomial for each energy.
% Z entre [0:30]
% E entre [1:10]

% Si la energía está directamente en la tabla
tableIndex = find(PFLU(:,1)==E);
if ~isempty(tableIndex)
    fitPoly = [PFLU(tableIndex,2) PFLU(tableIndex,3) 0];
    sigma = polyval(fitPoly,Z);
    
% Si la energía no está en la tabla
else
   
    % Sigma1: Interpolar polinomio y luego calcular E
    %Interpolated polynomials for E
    Ainterpflu=interp1(PFLU(:,1),PFLU(:,2),E);
    Binterpflu=interp1(PFLU(:,1),PFLU(:,3),E);
    fitPoly = [Ainterpflu,Binterpflu,0];
    
    %Calculation of Sigma in the Z plane
    sigma = polyval(fitPoly,Z);    
    
end

end