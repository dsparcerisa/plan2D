function [sigma1, sigma2] = SigmaZE(PFLU,Z,E)
%PFLU and must be a 10x3 matrix where the first column is an array
%containing the energies. The second and third columns are the
%coefficients of the sigma(Z) polynomial for each energy.
% Z entre [0:30]
% E entre [1:10]

% Si la energía está directamente en la tabla
tableIndex = find(PFLU(:,1)==E);
if ~isempty(tableIndex)
    fitPoly = [PFLU(tableIndex,2) PFLU(tableIndex,3) 0];
    sigma1 = polyval(fitPoly,Z);
    sigma2 = polyval(fitPoly,Z);
    
% Si la energía no está en la tabla
else
   
    % Sigma1: Interpolar polinomio y luego calcular E
    %Interpolated polynomials for E
    Ainterpflu=interp1(PFLU(:,1),PFLU(:,2),E);
    Binterpflu=interp1(PFLU(:,1),PFLU(:,3),E);
    fitPoly = [Ainterpflu,Binterpflu,0];
    
    %Caluclation of Sigma in the Z plane
    sigma1 = polyval(fitPoly,Z);
    
    % Sigma2: Calcular según E anterior y posterior e interpolar la media
    Elow = floor(E);
    Ehigh = ceil(E);
    tableIndexLow = find(PFLU(:,1)==Elow);
    fitPolyLow = [PFLU(tableIndexLow,2) PFLU(tableIndexLow,3) 0];    
    fitPolyHigh = [PFLU(tableIndexLow+1,2) PFLU(tableIndexLow+1,3) 0];    
    
    sigmaLow = polyval(fitPolyLow, Z);
    sigmaHigh = polyval(fitPolyHigh, Z);
    
    sigma2 = interp1([Elow Ehigh], [sigmaLow sigmaHigh], E);
    
end

end