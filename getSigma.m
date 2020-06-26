function [sigmaX, sigmaY] = getSigma(P, E0, z)
% double sigma = getSigma (10x3x2 double P, double E0, double z)
% Returns sigma in mm from initial energy E0 (MeV) and distance z (cm)
% P and must be a 10x4x2 matrix where the first column is an array
% containing the energies.  The second, third and fourth columns are the
% coefficients of the sigma(Z) polynomial for each energy. The first matrix is x and the second y.
% Z entre [0:30]
% E entre [1:10]
sigma = nan(1,2);
E = (3:8)';
for i = 1 : 2;

    % If the energy is already in the matrix
    tableIndex = find(P(:,1,i) == E0);
    if ~isempty(tableIndex)
        sigma(i) = P(tableIndex,2,i).*(z.^2) + P(tableIndex,3,i).*z + P(tableIndex,4,i);
    
    % Si la energía no está en la tabla
    else
   
        % Sigma1: Interpolar polinomio y luego calcular E0
        %Interpolated polynomials for E0
        Ainterp = interp1(E,P(:,2,i),E0);
        Binterp = interp1(E,P(:,3,i),E0);
        Cinterp = interp1(E,P(:,4,i),E0);
        sigma(i) = Ainterp.*(z.^2) + Binterp.*z + Cinterp;
    
    end
end
sigmaX = sigma(1);
sigmaY = sigma(2);

