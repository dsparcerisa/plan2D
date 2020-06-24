function sigma = getSigma(P, E0, z)
% double sigma = getSigma (10x3 double P, double E0, double z)
% Returns sigma in mm from initial energy E0 (MeV) and distance z (cm)
% P and must be a 10x4 matrix where the first column is an array
% containing the energies. The second, third and fourth columns are the
% coefficients of the sigma(Z) polynomial for each energy.
% Z entre [0:30]
% E entre [1:10]

E = (3:8)';
% If the energy is already in the matrix
tableIndex = find(P(:,1) == E0);
if ~isempty(tableIndex)
    sigma = P(tableIndex,1).*(z.^2) + P(tableIndex,2).*z + P(tabeIndex,3);
    
% Si la energía no está en la tabla
else
   
    % Sigma1: Interpolar polinomio y luego calcular E0
    %Interpolated polynomials for E0
    Ainterp = interp1(E,P(:,2),E0);
    Binterp = interp1(E,P(:,3),E0);
    Cinterp = interp1(E,P(:,4),E0);
    sigma = Ainterp.*(z.^2) + Binterp.*z + Cinterp;
    
end
end

