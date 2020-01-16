function sigma = getSigma(PFLU, E0, Z)
% double sigma = getSigma (10x3 double PFLU, double E0, double z)
% Returns sigma in cm from initial energy E0 (MeV) and distance z (cm)
% PFLU and must be a 10x3 matrix where the first column is an array
% containing the energies. The second and third columns are the
% coefficients of the sigma(Z) polynomial for each energy.
% Z entre [0:30]
% E entre [1:10]

% Si la energía está directamente en la tabla
tableIndex = find(PFLU(:,1)==E0);
if ~isempty(tableIndex)
    fitPoly = [PFLU(tableIndex,1) PFLU(tableIndex,2) 0];
    sigma = polyval(fitPoly,Z);
    
% Si la energía no está en la tabla
else
   
    % Sigma1: Interpolar polinomio y luego calcular E0
    %Interpolated polynomials for E0
    Ainterpflu=interp1(PFLU(:,1),PFLU(:,1),E0);
    Binterpflu=interp1(PFLU(:,1),PFLU(:,2),E0);
    fitPoly = [Ainterpflu,Binterpflu,0];
    
    %Calculation of Sigma in the Z plane
    sigma = polyval(fitPoly,Z);    
    
end
end

